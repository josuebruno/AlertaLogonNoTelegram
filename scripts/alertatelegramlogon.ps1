#verifica se existe logs criados no diretorio

$dir = Get-ChildItem -Path B:\logonemserver -Force
$dir = $dir | select name
$dir = $dir -replace "name"
$dir = $dir -replace "@{="
$dir = $dir -replace "}"

#faz a leitura do arquivo e envia no telegram

foreach($i in $dir){

#$i
#usa o get-content para ler e o separa por #

$Text = Get-Content -Path B:\logonemserver\$i
$text = $Text -split "#"

#converte matricula em usuario

$nomedorapaz = Get-ADUser -Filter * | Where-Object {$_.SamAccountName -eq $text[1]} | select name
$nomedorapaz = $nomedorapaz -replace "name"
$nomedorapaz = $nomedorapaz -replace "@{="
$nomedorapaz = $nomedorapaz -replace "}"

#guarda as menssagens

$msg = "O usuario " + $nomedorapaz + " logou data " + $text[3] +" no host " + $text[5]

#envia para o telegram

$token='5052705499:seutokentelegram' #Replace this with your bot HTTP API Token
$URL='https://api.telegram.org/bot{0}' -f $Token
$MessageToSend = New-Object psobject 
$MessageToSend | Add-Member -MemberType NoteProperty -Name 'chat_id' -Value "-265113054" #value chat id
$MessageToSend | Add-Member -MemberType NoteProperty -Name 'text' -Value $msg

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-RestMethod -Method Post -Uri ($URL +'/sendMessage') -Body ($MessageToSend | ConvertTo-Json) -ContentType "application/json"

#depois de ler e enviar move o arquivo para backup

Move-Item -Path B:\logonemserver\$i -Destination B:\bkp\logados\$i



}