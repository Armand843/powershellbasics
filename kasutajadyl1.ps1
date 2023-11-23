$eesnimi = Read-Host "Sisesta eesnimi"
$perenimi = Read-Host "Sisesta perenimi"

$kasutajanimi = "$eesnimi.$perenimi"
$täisnimi = "$eesnimi $perenimi"
$kontoKirjeldus = "Kasutaja loodud PowerShell skriptiga"

$parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force
$kasutajaLoomine = New-LocalUser -Name $kasutajanimi -Password $parool -Description $kontoKirjeldus

if ($?) {
    Write-Host "Kasutaja $kasutajanimi loodud edukalt."
} else {
    Write-Host "Kasutaja loomine ebaõnnestus. Veateade: $($Error[0].Exception.Message)"
}