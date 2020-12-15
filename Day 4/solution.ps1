<#
function checkID {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$PassportID,
        [bool]$correct = $false
    )

    $pidr = $PassportID.Contains('pid')
    $iyr = $PassportID.Contains('iyr')
    $eyr = $PassportID.Contains('eyr')
    $hgt = $PassportID.Contains('hgt')
    $hcl = $PassportID.Contains('hcl')
    $ecl = $PassportID.Contains('ecl')
    $byr = $PassportID.Contains('byr')


    if ($pidr -and $iyr -and $eyr -and $hgt -and $hcl -and $ecl -and $byr) {
        $correct = $true
        return $correct
    }

    return $correct
}

$input = Get-Content(".\input.txt")

$newinput = ""
$total = 0

$input | ForEach-Object {
    if ($_ -ne "") {
        $newinput = $newinput + $_ + ' '
    } else {
        $correct = checkID -PassportID $newinput
        if ($correct) {
            $total += 1
        }
        $newinput = ""
    }
}

Write-host "$total"
#>


#Part 2

function checkID {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]$PassportID,
        [bool]$correct = $false
    )

    $splitString = $PassportID.Split(' ')

    $splitString | ForEach-Object {
        if ($_ -match 'pid:'){
            $pidID = ($_ -split(':'))[1]
        } elseif ($_ -match 'iyr:') {
            $iyrdate = ($_ -split(':'))[1]
        } elseif ($_ -match 'eyr:') {
            $eyrdate = ($_ -split(':'))[1]
        } elseif ($_ -match 'hcl:') {
            $hclColour = ($_ -split(':'))[1]
        } elseif ($_ -match 'ecl:') {
            $eclColour = ($_ -split(':'))[1]
        } elseif ($_ -match 'byr:') {
            $byrdate = ($_ -split(':'))[1]
        } elseif ($_ -match 'hgt:') {
            $height = ($_ -split(':'))[1]
        }
    }

    # todo sort this match out should fit 9 digits only
    if ($pidID -match '[0-9]' -and $pidID.Length -eq 9) {
        $pidr = $PassportID.Contains('pid')
    }

    if ($iyrdate -ge '2010' -and $iyrdate -le '2020' -and $iyrdate.Length -eq 4) {
        $iyr = $PassportID.Contains('iyr')
    }

    if ($eyrdate -ge '2020' -and $eyrdate -le '2030' -and $eyrdate.Length -eq 4) {
        $eyr = $PassportID.Contains('eyr')
    }

    if($height -match '[0-9]in'){
        $height = $height -split ('in')
        if ($height -ge 59 -and $height -le 76) {
            $hgt = $PassportID.Contains('hgt')
        }
    }elseif ($height -match '[0-9]cm') {
        $height = $height -split ('cm')
        if ($height -ge 150 -and $height -le 193) {
            $hgt = $PassportID.Contains('hgt')
        }
    }


    if ($hclColour -match '#[aA-fF0-9]{6}') {
        $hcl = $PassportID.Contains('hcl')
    }

    $eyelist = ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth')

    if ($eclColour -in $eyelist) {
        $ecl = $PassportID.Contains('ecl')
    }

    if ($byrdate -ge '1920' -and $byrdate -le '2002' -and $byrdate.Length -eq 4) {
        $byr = $PassportID.Contains('byr')
    }

    if ($pidr -and $iyr -and $eyr -and $hgt -and $hcl -and $ecl -and $byr) {
        $correct = $true
        return $correct
    }

    return $correct
}

$input = Get-Content(".\input.txt")

$newinput = ""
$total = 0

$input | ForEach-Object {
    if ($_ -ne "") {
        $newinput = $newinput + $_ + ' '
    } else {
        $correct = checkID -PassportID $newinput
        if ($correct) {
            $total += 1
        }
        $newinput = ""
    }
}

Write-host "$total"