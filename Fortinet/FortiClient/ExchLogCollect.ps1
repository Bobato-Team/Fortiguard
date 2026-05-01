Add-PsSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

$target_dir = $PSScriptRoot + "\..\FortiClient_temp"
$last_export_stat_file = $PSScriptRoot + "\logs\exch_log_export_status.json"
$this_export_stat_file = $target_dir + "\exch_log_export_status.json"
Write-host "target_dir: $target_dir"
Write-host "last_export_stat_file: $last_export_stat_file"

class ExportStatus {
    [String] $export_time
    [String] $export_from
    [int] $number_exported
    [DateTime] $last_exported_log_timestamp
    [String] $last_exported_log_time
}

$this_export_stat = [ExportStatus]@{
    number_exported = 0
    export_time = get-date -Format "yyyy-MM-dd HH:mm:ss K"
}

$export_from = (get-date).AddDays(-1)
if (Test-Path $last_export_stat_file -PathType Leaf) {
    $last_export_stat = Get-Content -path "$last_export_stat_file" -Raw | ConvertFrom-Json
    if ($last_export_stat.last_exported_log_timestamp -gt $export_from) {
        $export_from = $last_export_stat.last_exported_log_timestamp.AddTicks(1)
        Write-host "last_exported_log_timestamp: " $last_export_stat.last_exported_log_timestamp.ToString("yyyy-MM-dd HH:mm:ss K")
    }
}

Write-host "export from: $export_from"
$last_exported_log_timestamp = $export_from

# $all_logs = Get-MessageTrackingLog | Where-Object { $_.TimeStamp -lt $cur }
# $all_logs = Get-MessageTrackingLog | Where-Object { $_.Source -eq "SMTP" }
$all_logs = Get-MessageTrackingLog -Start $export_from
$export_finish_timestamp = get-date

# if more that one logs have exactly same timestamp, then append a counter to file name
$log_time_previous = ""
$log_file_rename_count = 0

ForEach($log in $all_logs)
{
    $log_time = $log.TimeStamp.ToString("O").Replace(":", "_")

    if($log_time_previous -eq $log_time)
    {
        $log_file_rename_count = $log_file_rename_count + 1
        $log_time = $log_time + "-" + $log_file_rename_count.ToString()
    } else {
        $log_time_previous = $log_time
        $log_file_rename_count = 0
    }
    $log_file = $target_dir + "\exch_" + $log_time + ".xml"
    $log | Export-Clixml "$log_file"

	Write-host "log timestamp(UTC): $($log.Timestamp.ToUniversalTime()), last_exported_log_timestamp(UTC): $($last_exported_log_timestamp.ToUniversalTime())"
    if($log.Timestamp.ToUniversalTime() -gt $last_exported_log_timestamp.ToUniversalTime()) {
        $last_exported_log_timestamp = $log.Timestamp
		Write-host "last_exported_log_timestamp(UTC) is now set to: $($last_exported_log_timestamp.ToUniversalTime())"
    }
}

$this_export_stat.last_exported_log_timestamp = $last_exported_log_timestamp
$this_export_stat.last_exported_log_time = $last_exported_log_timestamp.ToString("yyyy-MM-dd HH:mm:ss K")
$this_export_stat.export_from = $export_from.ToString("yyyy-MM-dd HH:mm:ss K")
$this_export_stat.number_exported = $all_logs.Length
$this_export_stat | ConvertTo-Json > $this_export_stat_file

Write-host "Total $($all_logs.Length) logs exported"

