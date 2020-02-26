#!/usr/bin/env bash
PATH="$PATH:/home/builder/.dotnet/tools"
if [ -z $SONARHOST ] ; then
SONARHOST = "51.158.78.1"
SONARKEY = "8053be8e6cdf21e7e46dd3664e7ce948cf502298"
fi
cd ${PWD}/samples/complexapp
dotnet sonarscanner begin /k:dotNet /d:sonar.login=$SONARKEY /d:sonar.host.url="http://$SONARHOST:9000"
dotnet build .
dotnet sonarscanner end  /d:sonar.login=$SONARKEY
