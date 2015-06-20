@echo off
REM Created based on script at http://gohugo.io/tutorials/github-pages-blog/

SETLOCAL
SET PATH=%PATH%; %__CD__%unix2dos/bin/
echo %PATH%
echo "Deploying updates to GitHub..."

REM Back to root parent dir.
cd ..

REM Build the project.  If using a theme, and it is not set in config.yaml, replace by `hugo -t <yourtheme>`
hugo

REM Listing all files to be converted LF-CRLF, if necessary.
for /r public\ %%G in (*.*) do unix2dos.exe %%G

REM Go To Public folder
cd public

REM Add changes to git.
git add -A

REM Commit changes. Count the number of arguments: if user has not given any, use default message.
set argC=0
for %%x in (%*) do Set /A argC+=1

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set msg=rebuilding site %mydate%_%mytime%
if %argC% equ 1 (
    set msg=$1
)
git commit -m "%msg%"

REM Push source and build repos.
git push origin master

REM Come Back
cd ../bin

ENDLOCAL