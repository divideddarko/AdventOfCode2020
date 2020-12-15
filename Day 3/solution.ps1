$i = Get-Content(".\input.txt")
$loc, $tree, $rows = 0

# How many rows are there
$i | ForEach-Object {
    $rows++
}

# duplicate the length of the lines by the rows

$i | ForEach-Object {
    $q = $_
    $r = ""
    0 .. $rows | ForEach-Object {
        $r += $q
    }

    "$r" | Out-File .\a.txt -Append
}


$i = Get-Content(".\a.txt")

$i | ForEach-Object {

    $q = $_[$loc]
    "loc $loc Value $($q)" | Out-File "C:\Users\divid\desktop\p.txt" -Append
    if ($q -match '#') {
        $tree++
    }
    $loc += 1
}
Write-Host "Found trees $($tree)"





#part 2



$i = Get-Content(".\input.txt")
$rows = 0

Remove-Item -Path .\a.txt -Force

# How many rows are there
$i | ForEach-Object {
    $rows++
}

# duplicate the length of the lines by the rows

$i | ForEach-Object {
    $q = $_
    $r = ""
    0 .. $rows | ForEach-Object {
        $r += $q
    }

    "$r" | Out-File .\a.txt -Append
}



$content = Get-Content(".\a.txt")
$c = @(1, 3, 5, 7, 1)
$cinteration = 0
$totimes = @{ }
$line = 0;
$l = 0
$col = 0

$c | ForEach-Object {

    $l = $_
    $tree = 0
    $loc = 0

    if ($cinteration -eq 4) {
        for ($row = 0; $row -lt $content.Length; $row += 2) {
            $val = $content[$row][$col]
            if ($val -match '#'){
                $tree++
            }
            $col += 1
        }
    } else {
        $content | ForEach-Object {
            $q = $_[$loc]
            if ($q -match '#') {
                $tree++
            }

            $line++
            $loc += $l
        }
    }
    $totimes.Add($cinteration, $tree)
    $cinteration++
    Write-Host "Found trees $($tree)"
}

$v = 1

$totimes.Values | ForEach-Object {
    $v *= $_
}

"$v"
