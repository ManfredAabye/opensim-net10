#!/bin/sh
dotnet bootstrap/prebuild.dll /target vs2022 /targetframework net10_0 /excludedir = "obj | bin" /file prebuild.xml
