# ----- Messy function to make it looks like my zsh theme
function Git-Status
{
	"$([char]27)[31m"
	if ((git status --porcelain -b 2>$1 | Select-String -Pattern 'M ') -notmatch 'fatal') {
		"!"
	} 
	if ((git status --porcelain -b 2>$1 | Select-String -Pattern '\# ') -notmatch 'fatal') {
		"⇡"
	}
	if ((git status --porcelain -b 2>$1 | Select-String -Pattern '\? ') -notmatch 'fatal') {
		"?"
	}
}
function Git-Branch
{
	" $([char]27)[35m " + (git branch --show-current)
}
function getdir
{
	((Get-Location) -replace '/home/[a-zA-Z]*','~')
}
function end_of_prompt
{
"
$([char]27)[32;1m$> $([char]27)[0m"
}

# ----- Foreground (the thing that actually shows up)
function prompt
{
	if ((git log -n 1 2>$1) -notmatch 'fatal') {
	"
$([char]27)[34;1m" + $env:COMPUTERNAME + "" + (getdir) + (Git-Branch) + " " + ("$(Git-Status)" -replace ' ','') + (end_of_prompt)
	}
	else 
	{
	"
$([char]27)[34;1m" + $env:COMPUTERNAME + "" + (getdir) + (end_of_prompt)
	}
}

# ----- Aliases
New-Alias vim nvim
