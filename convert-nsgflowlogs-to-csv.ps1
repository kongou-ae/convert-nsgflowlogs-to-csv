Param(
    [Parameter(Mandatory=$true)][System.String]$urlWithSasToken
)

$ErrorActionPreference = "stop"

$res = Invoke-WebRequest -Uri $urlWithSasToken
$logs = [System.Text.Encoding]::UTF8.GetString($flowlogs.Content) | ConvertFrom-Json

$filename = "$($HOME)\flowlogs-$(Get-Date -Format yyyyMMdd-hhmmss).csv"
"utcDate,localDate,srcIP,srcPort,dstIP,dstPort,protocol,direction,action" | Out-File $filename -Append -Encoding utf8

$logs.records | ForEach-Object {
    $flows = $_.properties.flows
    $flows | ForEach-Object {
        $rules = $_.rule
        $2ndFlows = $_.flows
        $2ndFlows | ForEach-Object{
            $mac = $_.mac
            $flowTuple =  $_.flowTuples -split ","
            # https://sevenb.jp/wordpress/ura/2018/01/19/unix-timestamp%E3%82%92datetime%E3%81%AB%E5%A4%89%E6%8F%9B%E3%81%99%E3%82%8B/
            $utcDate = ([DateTime]::Parse("1970/01/01 00:00:00")).addSeconds($flowTuple[0])
            $localDate = [TimeZoneInfo]::ConvertTimeFromUtc($utcDate, [TimezoneInfo]::Local)
            $srcIP = $flowTuple[1]
            $srcPort = $flowTuple[3]
            $dstIP = $flowTuple[2]
            $dstPort = $flowTuple[4]
            
            if ( $flowTuple[5] -eq "T"){
                $protocol = "TCP"
            } else {
                $protocol = "UDP"   
            }

            if ( $flowTuple[6] -eq "I"){
                $direction = "Inbound"
            } else {
                $direction = "Outbound"
            }

            if ( $flowTuple[7] -eq "A"){
                $action = "Accept"
            } else {
                $action = "Deny"
            }

            "$utcDate,$localDate,$srcIP,$srcPort,$dstIP,$dstPort,$protocol,$direction,$action" | Out-File $filename -Append -Encoding utf8
        }
    }
}
