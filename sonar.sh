#!/usr/bin/env bash
PATH="$PATH:/home/builder/.dotnet/tools"
cd ${PWD}/samples/complexapp
dotnet sonarscanner begin /k:dotNet /d:sonar.login=09c92583be3d3d6d8bb3880e724f4f9558548be6 /d:sonar.host.url="http://jenkins.piraiinfo.co.uk:9000"
dotnet build .
dotnet sonarscanner end  /d:sonar.login=09c92583be3d3d6d8bb3880e724f4f9558548be6
