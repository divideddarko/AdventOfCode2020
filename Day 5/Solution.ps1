# $lowernum = [math]::Floor(40)
# $uppernum = [math]::Floor(47)
# # exp 47

# $results = $lowernum / 2 + $uppernum / 2

# Write-Host "Results $([math]::floor($results))"

# 882 - too high
###- potential = 874
# 871 - too low

function dealWithData {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Direction,
        [int]$firstRow = 0, $lastRow = 0, $firstCol = 0, $lastCol = 0
    )


    switch ($Direction) {
        'F' {
            $lastRow = [math]::round($firstRow / 2 + $lastRow / 2)
            # Write-Host "First Row: $firstRow - $lastRow"
            Return $firstRow, $lastRow
        }
        'B' {
            $firstRow = [math]::round($firstRow / 2 + $lastRow / 2)
            # Write-Host "B: $firstRow - $lastRow"
            Return $firstRow, $lastRow
        }
        'L' {
            # $lastCol = [math]::floor($firstCol / 2  + $lastCol / 2)
            $lastCol = [math]::floor($lastCol / 2 + $firstCol / 2)
            # Write-Host "First Col: $firstCol - $lastCol"
            Return $firstCol, $lastCol
        }
        'R' {
            # $firstCol = [math]::round($firstCol / 2 + $lastCol / 2)
            $firstCol = [math]::round($firstCol / 2 + $lastCol / 2)
            # Write-Host "Last Col: $firstCol - $lastCol"
            Return $firstCol, $lastCol
        }
    }
}

function doSumSums {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]$firstRow, $lastCol,
        [int]$n = 0
    )

    $results = $firstRow * 8 + $lastCol
    return $results
}

$content = Get-Content ('.\input.txt')

$idRank = [ordered]@{}

for ($i = 0; $i -lt $content.Length; $i++) {

    $firstRow = 1
    $lastRow = 128
    $firstCol = 0
    $lastCol = 7

    $rowData = $content[$i].Substring(0, 7)
    $colData = $content[$i].Substring(7, 3)

    for ($q = 0; $q -lt $rowData.Length; $q++) {
        $firstRow, $lastRow = dealWithData -Direction $rowData[$q] -firstRow $firstRow -lastRow $lastRow
    }

    for ($q = 0; $q -lt $colData.Length; $q++) {
        $firstCol, $lastCol = dealWithData -Direction $colData[$q] -firstCol $firstCol -lastCol $lastCol
    }

    $results = doSumSums -firstRow $firstRow -lastCol $lastCol

    # Write-Host "Rows: $($FirstRow) Cols: $($lastCol) Results: $($results)"


    $idRank.Add($i, $results)
}


$idRank.GetEnumerator() | Sort-Object -Property value | Select-Object -last 1

$q = 48
$idRank.GetEnumerator() | Sort-Object -Property value | Select-Object -ExpandProperty Value | ForEach-Object {
    if ($q -ne $_){
        Write-Host "Missing Boarding Pass $($q)"
        break
    }
    $q++
}