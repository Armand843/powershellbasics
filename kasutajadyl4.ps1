$eesnimi = Read-Host "Sisesta eesnimi"
$perenimi = Read-Host "Sisesta perenimi"

$kasutajanimi = "$eesnimi.$perenimi"
$täisnimi = "$eesnimi $perenimi"
$kontoKirjeldus = "Kasutaja loodud PowerShell skriptiga"

$kasutajaOlemas = Get-ADUser -Filter {SamAccountName -eq $kasutajanimi}

if ($kasutajaOlemas -eq $null) {
    $parool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force
    New-ADUser -SamAccountName $kasutajanimi -UserPrincipalName "$kasutajanimi@domain.com" -Name $täisnimi -GivenName $eesnimi -Surname $perenimi -Description $kontoKirjeldus -AccountPassword $parool -Enabled $true
    Write-Host "Kasutaja $kasutajanimi lisatud AD-sse."
} else {
    Write-Host "Kasutaja $kasutajanimi juba eksisteerib AD-s. Vali teine nimi."
}