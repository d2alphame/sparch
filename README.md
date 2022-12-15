# Sparch
Sparch is a tool for creating [self extracting archives](https://en.wikipedia.org/wiki/Self-extracting_archive) Perl archives. When an archive is created, the result is an executable Perl script with the archive attached to it. Running the script decompresses and extracts the archive. Sparch also supports running a script on extraction.

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

Sparch can also be invoked in the following ways
```
sparch --dir /path/to/folder --output archive --script ./script-to-run --files file1, file2, file3
sparch --help
```
In the above examples `--dir` is used to specify a directory that contains files to be added to the resulting archive. `--files` is also specified listing out files to be added to the archive. The `--output` option specifies the name of the resulting archive in this case, `archive`. Sparch will name the output file `archive.pl`.

The `--help` option is used to get help.

## Description
Sparch is written in Perl and is used for creating self-extracting Perl archives. The archive itself is created and compressed using the module Archive::Tar. The resulting archive is then base64-encoded in using MIME::Base64 and attached to a perl script.

When creating the archive, sparch first attempts to use xz compression. If xz is not available, then it tries bzip, and if that, too, is unavailable, it defaults to gzip.

If `--script` was used during the creation of the archive, the specified script will be extracted upon extraction.
