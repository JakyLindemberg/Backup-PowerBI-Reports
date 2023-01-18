Connect-PowerBIServiceAccount

$Workspaces = @('Workspace 1','Workspace 2','Workspace 3','Workspace 4')

foreach($workspace in $Workspaces) {

$ws = Get-PowerBIWorkspace -Name $workspace
$relatorios = Get-PowerBIReport -Workspace $ws
$dataBackup = Get-Date -Uformat “%Y-%m-%d”

$caminho = "C:\Backup PowerBI\" + $dataBackup + "\" + $workspace + "\"

md $caminho

foreach($relatorio in $relatorios) {
 
 $arquivo = $caminho +  $relatorio.name + ".pbix"

 Export-PowerBIReport -Id $relatorio.ID -OutFile $arquivo

}
}
$caminhobackup = "C:\Backup PowerBI\" + $dataBackup + "\"

$compress = @{
  Path = $caminhobackup
  CompressionLevel = "Fastest"
  DestinationPath = "C:\Backup PowerBI\Backup-power-bi-" + $dataBackup + ".zip"
}
Compress-Archive @compress

$remocao = "C:\Backup PowerBI\" + $dataBackup

Remove-Item -path $remocao -recurse -force