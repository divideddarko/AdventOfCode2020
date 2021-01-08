
$a = Measure-Command {
    $input = Get-Content(".\input.txt")
    foreach ($one in $input) {
        foreach ($two in $input) {
            if ($two -ne $one) {
                $counted = [int]$two + [int]$one
                if ($counted -eq "2020") {
                    $results = [int]$i * [int]$one
                    Write-Host "results: $results"
                }
            }
        }
    }
}
Write-Host "timetake: $($a.minutes):$($a.Seconds):$($a.Milliseconds)"

# much better solution - take the 2020 minus the current number and see if that exists within the list
# if it does then times the two together.

# Attempt 2 with solution list above 
$a = Measure-Command {
    $content = Get-Content(".\input.txt") 

    foreach ($i in $content) {
        $tofind = 2020 - [int]$i

        if ($content.Contains($tofind)) {
            $results = [int]$i * [int]$tofind
            Write-Host "Results: $results"
            break
        }
    }
}
Write-Host "timetake: $($a.minutes):$($a.Seconds):$($a.Milliseconds)"


# Original solution for day 1 part 2 
# takes ~1min 17seconds
$a = Measure-Command {
    $input = Get-Content(".\input.txt")
    foreach ($item in $input) {
        foreach ($i in $input) {
            foreach ($p in $input) {
                if ($i -ne $item -and $p -ne $input -and $p -ne $i) {
                    $q = [int]$i + [int]$item + [int]$p
                    if ($q -eq "2020") {
                        $results = [int]$i * [int]$item * [int]$p
                        Write-Host "results: $results"
                        return
                    }
                }
            }
        }
    }
}
Write-Host "timetake: $($a.minutes):$($a.Seconds):$($a.Milliseconds)"

# Improved command as above
# takes: ~300milliseconds
$a = Measure-Command {
    $content = Get-Content(".\input.txt")
    foreach ($item in $content) {
        foreach ($i in $content) {
            $toFind = 2020 - [int]$item - [int]$i
            if ($content.Contains($toFind)) {
                $results = [int]$i * [int]$item * [int]$p
                Write-Host "results: $results"
                return
            }
        }
    }
}
Write-Host "timetake: $($a.minutes):$($a.Seconds):$($a.Milliseconds)"
