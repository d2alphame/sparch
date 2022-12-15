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
sparch --dir /path/to/folder --output archive --script ./script-to-run --files file1 file2 file3
sparch --help
```
In the above examples `--dir` is used to specify a directory that contains files to be added to the resulting archive. `--files` is also specified listing out files to be added to the archive. The `--output` option specifies the name of the resulting archive in this case, `archive`. Sparch will name the output file `archive.pl`.

The `--help` option is used to get help.

## Description
Sparch is written in Perl and is used for creating self-extracting Perl archives. The archive itself is created and compressed using the module Archive::Tar. The resulting archive is then base64-encoded in using MIME::Base64 and attached to a perl script.

When creating the archive, sparch first attempts to use xz compression. If xz is not available, then it tries bzip, and if that, too, is unavailable, it defaults to gzip.

If `--script` was used during the creation of the archive, the specified script will be extracted upon extraction.

## Options
The following are options that are available with sparch.

### `-d --dir`
The directory that contains the files to archive.

### `-f --files`
List of files that should be in the archive.

### `-h --help`
Displays usage help.

### `-o --output`
Name of the resulting archive file. Sparch attaches '.pl' to the name specified by this option. The resulting file is an executable perl script (chmod +x). If this option is not specified, sparch uses 'out.pl' as the name of the resulting archive file.

### `-s --script`
A script that is part of the archive which will be executed once the archive has been extracted. The script must be an executable perl script.

## Things to note
If both `--dir` and `--files` is used, all the files in the directory and all the files specified by `--files` will be added into the archive.

If neither `--dir` nor `--files` is used, then names of files will be read from STDIN.

Also `--output` defaults to `out.pl`.

## Options for extraction
The following options are available when executing the archive script.

### `--keep`
Keep the archive after extraction. By default, the generated archive script is deleted after the files in the archive have been extracted. This option disables this behaviour and keeps the original archive file after extraction.

### `--no-run`
If an archive is created with the `--script` option, the specified script is executed when the archive is extracted. Using this option prevents the script from running.
