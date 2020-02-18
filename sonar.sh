#!/usr/bin/env bash
PATH="$PATH:/home/builder/.dotnet/tools"
cd ${PWD}/samples/complexapp
dotnet sonarscanner begin /k:dotNet /d:sonar.login=8053be8e6cdf21e7e46dd3664e7ce948cf502298 /d:sonar.host.url="http://51.158.78.1:9000"
dotnet build .
dotnet sonarscanner end  /d:sonar.login=8053be8e6cdf21e7e46dd3664e7ce948cf502298
