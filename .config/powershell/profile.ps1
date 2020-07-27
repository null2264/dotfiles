function Git-Status
{
	"$([char]27)[31m"
	if ((git status --porcelain -b 2>$1 | Select-String -Pattern 'M ') -notmatch 'fatal') {
		"M"
	} 
	if ((git status --porcelain -b 2>$1 | Select-String -Pattern '\? ') -notmatch 'fatal') {
		"?"
	}
}
function Git-Branch
{
	" $([char]27)[35m " + (git branch --show-current)
}
function end_of_prompt
{
"
$([char]27)[32;1m$> $([char]27)[0m"
}
function prompt
{
	if ((git log -n 1 2>$1) -notmatch 'fatal') {
	"
$([char]27)[34;1m" + $env:COMPUTERNAME + "" + (Get-Location) + (Git-Branch) + (Git-Status) + (end_of_prompt)
	}
	else 
	{
	"
$([char]27)[34;1m" + $env:COMPUTERNAME + "" + (Get-Location) + (end_of_prompt)
	}
}
