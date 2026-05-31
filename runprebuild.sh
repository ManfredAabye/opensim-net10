#!/bin/sh

set -e

refresh_prebuild() {
  dotnet build Prebuild/src/Prebuild.csproj -c Release
  cp Prebuild/src/bin/Release/net10.0/prebuild.dll bin/prebuild.dll
  cp Prebuild/src/bin/Release/net10.0/prebuild.runtimeconfig.json bin/prebuild.runtimeconfig.json
  cp Prebuild/src/bin/Release/net10.0/prebuild.deps.json bin/prebuild.deps.json
}

case "$1" in

 'clean')
   refresh_prebuild
    dotnet bin/prebuild.dll /file prebuild.xml /clean

  ;;


  'autoclean')

    refresh_prebuild
    echo y|dotnet bin/prebuild.dll /file prebuild.xml /clean

  ;;



  *)

    refresh_prebuild
    cp bin/System.Drawing.Common.dll.linux bin/System.Drawing.Common.dll
    dotnet bin/prebuild.dll /target vs2022 /targetframework net10_0 /excludedir = "obj | bin" /file prebuild.xml
    echo "dotnet build -c Release OpenSim.sln" > compile.sh
    chmod +x compile.sh

  ;;

esac
