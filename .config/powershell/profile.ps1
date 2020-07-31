function UsernameAtComputer
{
	if (! "$env:ComputerName" -eq "") {
		$compname = $env:ComputerName
	}
	else {
		$compname = "unknown"
	}
	if (! "$env:UserName" -eq "") {
		$username = $env:UserName
	}
	if (! "$env:USER" -eq "") {
		$username = $env:USER
	}
	else {
		$username = "unknown"
	}
	"`e[35;1m" + $username + "`e[0m`e[1m@" + "`e[35;1m" + $compname
}
Write-Host " `e[34;1m   ,___---'‾‾‾|`e[0m  " (UsernameAtComputer)
Write-Host " `e[34;1m|'‾    |      |  "
Write-Host " `e[34;1m|      |      |"
Write-Host " `e[34;1m|------|------|"
Write-Host " `e[34;1m|      |      |"
Write-Host " `e[34;1m|,_    |      |"
Write-Host " `e[34;1m   '‾‾‾---,___|"

# ----- set default color
Set-PSReadlineOption -Colors @{ Parameter = "`e[96m"}
Set-PSReadlineOption -Colors @{ Operator = "`e[96m"}
Set-PSReadlineOption -Colors @{ String = "`e[93m"}

# ----- Messy function to make it looks like my zsh theme / git support
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
	# ((Get-Location) -replace '[a-zA-Z].\\','~\') # change 'c:/' into '~' (optional)
	((Get-Location) -replace '/home/[a-zA-Z]*','~') # change '/home/<username>' into '~'
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
function q{exit}
