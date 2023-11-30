$eesnimi = Read-Host "Sisesta eesnimi"
$perenimi = Read-Host "Sisesta perenimi"

function Translit {
    param (
        [string]$text
    )

    $translitTable = @{
        'ä' = 'a'
        'ö' = 'o'
        'õ' = '6'
        'ü' = 'u'
        
    }

    $translitText = $text.ToLower()

    foreach ($char in $translitTable.Keys) {
        $translitText = $translitText -replace $char, $translitTable[$char]
    }

    return $translitText
}

$kasutajanimi = Translit -text "$eesnimi.$perenimi"

try {
    Remove-ADUser -Identity $kasutajanimi -Confirm:$false -ErrorAction Stop
    Write-Host "Kasutaja $kasutajanimi edukalt kustutatud AD-st."
} catch {
    Write-Host "Kasutaja kustutamine ebaõnnestus. Veateade: $($_.Exception.Message)"
}