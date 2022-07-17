# Download latest revanced/revanced-integrations release from github
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main" -Name "DisableFirstRunCustomize" -Value 2
$githubLatestReleases = 'https://api.github.com/repos/revanced/revanced-integrations/releases/latest'   
$githubLatestRelease = (((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'app-release-unsigned').Line
./wget/bin/wget.exe --content-disposition $githubLatestRelease
Exit