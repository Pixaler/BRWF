# Download latest revanced/revanced-integrations release from github
$githubLatestReleases = 'https://api.github.com/repos/revanced/revanced-integrations/releases/latest'   
$githubLatestRelease = (((Invoke-WebRequest $gitHubLatestReleases) | ConvertFrom-Json).assets.browser_download_url | select-string -Pattern 'app-release-unsigned').Line
curl.exe -H 'Accept-encoding: gzip' -L -o app-release-unsigned.apk $githubLatestRelease 
Exit