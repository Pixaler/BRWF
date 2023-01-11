# Download latest revanced/revanced-patches release from github
$githubLatestReleases = 'https://api.github.com/repos/revanced/revanced-patches/releases/latest'   
$githubLatestRelease = (((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-patches').Line
./wget/bin/wget.exe --content-disposition $githubLatestRelease 
Exit