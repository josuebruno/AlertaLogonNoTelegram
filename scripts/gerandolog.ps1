#Recebe a data e limpa os dados.

$data = Get-Date | select day, month, year, Timeofday
$data = $data -replace "dayMonthYearTimeOfDay"
$data = $data -replace "@{Day="
$data = $data -replace "Month="
$data = $data -replace "Year="
$data = $data -replace "TimeOfDay="
$data = $data -replace "}"
$data = $data -replace ";", "-"
$data = $data -replace ":", " "
#$data
#encaminha para HOME

cd $HOME

#recebe o nome da maquna

$compname = hostname

#Recebe o diretorio atual e limpa a informação para pegar o nome do usuario.

$logado = pwd
$logado = $logado -replace "Path"
$logado = $logado.Split("{\}")
$logado = $logado[2]

#Cria o log no diretorio remoto

$path = "\\fileserver\logonemserver\"+$compname+"-"+$data+".log"
$msg = "O usuario #"+ $logado + "# Realizou um login na data # "+ $data + "# nome: do host:  #"+ $compname
$msg >> $path



