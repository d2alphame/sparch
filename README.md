# Sparch
Sparch is a tool for creating [self extracting archives](https://en.wikipedia.org/wiki/Self-extracting_archive).
When an archive is created, the result is an executable Perl script with the archive attached to it. Running the script decompresses and extracts the archive. Sparch also supports running a script on extraction.



## Using Sparch
The simplest invocation of sparch is
```
sparch
```
Used in the above form, (without any options) names of files that make up the archive are read from STDIN. The output file `out.pl` (the default) is created. The output file can then be executed to (decompress and) extract the archive. For example
```
sparch
aang
katara
sokka
toph
zuko
^X
```
The above example reads the files `aang`, `katara`, `sokka`, `toph`, and `zuko` from the STDIN. The output file `out.pl` is created which contains the files in the archive.
