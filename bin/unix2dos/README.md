### UNIX2DOS

Hugo usually generates files with LF EOL (Unix standard); but I'm always on a Windows machine, so Git will complain 
about those line-endings differences and I want to automatically solve this, just before committing data.

For that, I'm calling **unix2dos** in my [publish.bat](../bin/publish.bat) script to change any files that needs to be 
changed.

I'm not versioning the tool, but anyone can find it and download it at 
[http://waterlan.home.xs4all.nl/dos2unix.html](http://waterlan.home.xs4all.nl/dos2unix.html)

Once downloaded, unzip it inside this folder and you're good to go. **Attention**: you need to unzip the unix2dos 
version only and you shouldn't create any new folder - meaning the tree folder should be like 
`<project_root>/bin/unix2dos/bin/` and, optionally, `<project_root>/bin/unix2dos/share/`.
