# Download latest revanced/revanced-cli release from github
$githubLatestReleases = 'https://api.github.com/repos/revanced/revanced-cli/releases/latest'   
$githubLatestRelease = (((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-cli').Line
./wget/bin/wget.exe --content-disposition $githubLatestRelease   
Exit