@echo OFF

copy bin\System.Drawing.Common.dll.win bin\System.Drawing.Common.dll

set "PREBUILD_EXE=Prebuild\src\bin\Release\prebuild.exe"
set "MSBUILD_EXE="

if not exist "%PREBUILD_EXE%" (
	echo Building Prebuild generator...
	for /f "delims=" %%i in ('where msbuild 2^>NUL') do (
		set "MSBUILD_EXE=%%i"
		goto :build_prebuild
	)

	if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
		set "MSBUILD_EXE=%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
		goto :build_prebuild
	)

	echo ERROR: MSBuild wurde nicht gefunden. Bitte Visual Studio 2022 Build Tools installieren.
	goto :done
)

:build_prebuild
if defined MSBUILD_EXE (
	"%MSBUILD_EXE%" Prebuild\src\Prebuild.csproj /p:Configuration=Release /m || goto :done
)

"%PREBUILD_EXE%" /target vs2022 /targetframework net10_0 /excludedir = "obj | bin" /file prebuild.xml
if errorlevel 1 goto :done

    @echo Creating compile.bat
rem To compile in release mode
    @echo dotnet build --configuration Release OpenSim.sln > compile.bat
rem To compile in debug mode comment line (add rem to start) above and uncomment next (remove rem)
rem    @echo dotnet build --configuration Debug OpenSim.sln > compile.bat
:done


if exist "bin\addin-db-002" (
	del /F/Q/S bin\addin-db-002 > NUL
	rmdir /Q/S bin\addin-db-002
	)
if exist "bin\addin-db-004" (
	del /F/Q/S bin\addin-db-004 > NUL
	rmdir /Q/S bin\addin-db-004
	)	