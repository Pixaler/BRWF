# Download latest revanced/revanced-patches release from github
$githubLatestReleases = 'https://api.github.com/repos/revanced/revanced-patches/releases/latest'   
$githubLatestRelease = (((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'revanced-patches').Line
curl.exe -H 'Accept-encoding: gzip' -L -o revanced-patches.jar $githubLatestRelease
Exit