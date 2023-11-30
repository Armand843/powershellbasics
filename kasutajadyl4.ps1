$eesnimi = Read-Host "Sisesta eesnimi"
$perenimi = Read-Host "Sisesta perenimi"

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

$kasutajanimi = Translit -text "$eesnimi.$perenimi"
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

