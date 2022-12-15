# Sparch
Sparch is a tool for creating [self extracting archives](https://en.wikipedia.org/wiki/Self-extracting_archive) in Perl. When an archive is created, the result is an executable Perl script with the archive attached to it. Running the script decompresses and extracts the archive. Sparch also supports running a script on extraction.

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
Sparch is written in Perl and is used for creating self-extracting Perl archives. The archive itself is created and compressed using the module Archive::Tar. The resulting archive is then base64-encoded in MIME::Base64 and attached to a perl script.

When creating the archive, sparch first attempts to use xz compression. If xz is not available, then it tries bzip, and if that, too, is unavailable, it defaults to gzip.

If `--script` was used during the creation of the archive, the specified script will run upon extraction.

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
If both `--dir` and `--files` are used, all the files in the directory and all the files specified by `--files` will be added into the archive.

If neither `--dir` nor `--files` is used, then names of files will be read from STDIN.

Also `--output` defaults to `out.pl`.

## Options for extraction
The following options are available when executing the archive script.

### `--keep`
Keep the archive after extraction. By default, the generated archive script is deleted after the files in the archive have been extracted. This option disables this behaviour and keeps the original archive file after extraction.

### `--no-run`
If an archive is created with the `--script` option, the specified script is executed when the archive is extracted. Using this option prevents the script from running.

## Examples
The following example will create an archive consisting of the files aang, katara, sokka, toph, zuko
```
sparch --files aang katara sokka toph zuko
```
In the above example, because `--output` was not specified, the resulting archive will be named `out.pl`.

Note that `--files` should always be last whenever it is present. That is because everything after it is taken to be the name of a file to be included in the archive.

The following will create an archive from the files specified by `--dir`. Note that the operation is recursive so files in subdirectories are included.
```
sparch --dir benders
```
Just like with the previous example, the name of the resulting archive file will be `out.pl` because the `--output` option was not used.

The next example makes use of both `--dir` and `--files`. All files in the directory and all files specified by `--files` will be added to the archive.
```
sparch --dir benders --files aang katara sokka toph zuko
```
If neither `--dir` nor `--files` is specified, then files will be read in from STDIN. For example
```
sparch --output the-gaang
aang
katara
sokka
toph
zuko
^X
```
In the above example, because `--output the-gaang` was specified, the resulting archive file will be named the-gaang.pl.

To run a script after extraction, specify the name of the script while creating the archive. The script must be part of the archive
```
sparch --script tear-bending --output the-gaang
aang
katara
sokka
toph
zuko
tear-bending
^X
```
The user extracting the archive might decide not to let the script run by using the `--no-run` option when extracting the archive.
