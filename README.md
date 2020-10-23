## Install
To install in current user's home directory, simply run `make install` in
project's root directory, that will also create *.bak files to backup previous
configurations (So be careful if you have existing *.bak files, as it will
override them), to remove them after install, run `make rm-backup`.

```
$ make install && make rm-backup
```
