User
function Translit {
    param (
        [string]$text
    )

    $translitTable = @{
        'ä' = 'a'
        'ö' = 'o'
        'õ' = 'o'
        'ü' = 'u'
    }

    $translitText = $text.ToLower()

    foreach ($char in $translitTable.Keys) {
        $translitText = $translitText -replace $char, $translitTable[$char]
    }

    return $translitText
}

function Generate-Password {
    Add-Type -AssemblyName System.Web
    [System.Web.Security.Membership]::GeneratePassword(8, 2)
}

# Lis
$eesnimi = Read-Host "Sisesta eesnimi"
$perenimi = Read-Host "Sisesta perenimi"

$kasutajanimi = Translit -text "$eesnimi.$perenimi"
$täisnimi = "$eesnimi $perenimi"

$kasutajaOlemas = Get-ADUser -Filter {SamAccountName -eq $kasutajanimi}

if ($kasutajaOlemas -eq $null) {
    $parool = Generate-Password -length $paroolPikkus

    New-ADUser -SamAccountName $kasutajanimi -UserPrincipalName "$kasutajanimi@domain.com" -Name $täisnimi -GivenName $eesnimi -Surname $perenimi -Description "Kasutaja loodud PowerShell skriptiga" -AccountPassword (ConvertTo-SecureString -String $parool -AsPlainText -Force) -Enabled $true

    $userData = [PSCustomObject]@{
        Kasutajanimi = $kasutajanimi
        Täisnimi = $täisnimi
        Parool = $parool
    }
    $userData | Export-Csv -Path "$kasutajanimi.csv" -NoTypeInformation

    Write-Host "Kasutaja $kasutajanimi lisatud AD-sse. Genereeritud parool asub csv failis."
} else {
    Write-Host "Kasutaja $kasutajanimi juba eksisteerib AD-s. Vali teine nimi."
}