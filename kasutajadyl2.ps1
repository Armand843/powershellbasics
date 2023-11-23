# 1. Küsi kasutajalt ees- ja perenimi, keda kustutada
$eesnimiKustutamine = Read-Host "Sisesta kasutaja eesnimi, keda kustutada"
$perenimiKustutamine = Read-Host "Sisesta kasutaja perenimi, keda kustutada"

# 2. Loo kasutajanimi
$kasutajanimiKustutamine = "$eesnimiKustutamine.$perenimiKustutamine"

# 3. Kustuta kasutaja vastavalt loodud kasutajanimele
try {
    Remove-LocalUser -Name $kasutajanimiKustutamine -ErrorAction Stop
    Write-Host "Kasutaja $kasutajanimiKustutamine kustutatud edukalt."
} catch {
    Write-Host "Kasutaja kustutamine ebaõnnestus. Veateade: $($_.Exception.Message)"
}
