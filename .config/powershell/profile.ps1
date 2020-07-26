function Prompt
{
"
$([char]27)[34;1m" + $env:COMPUTERNAME + "" + (Get-Location) + "
$([char]27)[32;1m$> $([char]27)[0m"
}
