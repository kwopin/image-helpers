export ARTIFACT_ID=`curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/kwopin/alpine-cmake/actions/artifacts | jq -r '.artifacts[0].id?'`
curl -u intjelic:$CMAKE_DOWNLOAD_ARTIFACT_TOKEN -o cmake.zip -L https://api.github.com/repos/kwopin/alpine-cmake/actions/artifacts/$ARTIFACT_ID/zip
