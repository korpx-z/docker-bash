### This image is built to run on s390x architecture.
-    [build source](https://github.com/korpx-z/docker-bash)
-    [original source code](https://github.com/tianon/docker-bash)

## Tags (All within their respected branches)
-	[`4.2`](https://travis-ci.com/korpx-z/docker-bash.svg?branch=4.2)
-	[`4.3`](https://travis-ci.com/korpx-z/docker-bash.svg?branch=4.3)
-	[`4.4`](https://travis-ci.com/korpx-z/docker-bash.svg?branch=4.4)
-	[`5.0`](https://travis-ci.com/korpx-z/docker-bash.svg?branch=5.0)
-	[`devel`](https://travis-ci.com/korpx-z/docker-bash.svg?branch=devel)

# Bash

Bash is the [GNU](http://www.gnu.org/) Project's Bourne Again SHell, a complete implementation of the [IEEE POSIX and Open Group shell specification](http://www.opengroup.org/onlinepubs/9699919799/nfindex.html) with interactive command line editing, job control on architectures that support it, csh-like features such as history substitution and brace expansion, and a slew of other features.

> [tiswww.case.edu/php/chet/bash/bashtop.html](https://tiswww.case.edu/php/chet/bash/bashtop.html)

![logo](https://raw.githubusercontent.com/docker-library/docs/5cb6fef6ed317e5af7e1e14e64c18c2b81657e81/bash/logo.png)

# How to use this image

The primary use cases this image is targeting are testing new features of more recent Bash versions before your primary distribution updates packages and testing shell scripts against different Bash versions to ensure compatibility. There are likely other interesting use cases as well, but those are the primary two the image was initially created to solve!

## Notes

There are a few main things that are important to note regarding this image:

1.	Bash itself is installed at `/usr/local/bin/bash`, not `/bin/bash`, so the recommended shebang is `#!/usr/bin/env bash`, not `#!/bin/bash` (or explicitly running your script via `bash /.../script.sh` instead of letting the shebang invoke Bash automatically). The image does not include `/bin/bash`, but if it is installed via the package manager included in the image, that package will install to `/bin/bash` and might cause confusion (although `/usr/local/bin` is ahead of `/bin` in `$PATH`, so as long as plain `bash` or `/usr/bin/env` are used consistently, the image-provided Bash will be preferred).

2.	Bash is the only thing included, so if your scripts rely on external tools (such as `jq`, for example), those will need to be added manually (via `apk add --no-cache jq`, for example).

## Interactive shell

```console
$ docker run -it --rm quay.io/ibm/bash:4.4
bash-4.4# which bash
/usr/local/bin/bash
bash-4.4# echo $BASH_VERSION
4.4.0(1)-release
```

## Testing scripts via bind-mount
**Bind mounts are not enabled on ZCX for security purposes, please use docker volumes like demonstrated here:**
```console
$ docker volume create <your_volume>
$ mkdir scripts/
#filling the created volume with contents from the host file system can be tricky..
$ docker run -d --rm --name temp -v <your_volume>:/root/ quay.io/ibm/alpine:3.12 tail -f /dev/null
$ docker cp scripts/. temp:/root
$ docker stop temp
```

Your volume will now contain any scripts you've placed within `scripts/` on your host system - and it can now be mounted into a container.

```console
$ docker run -it --rm -v <your_volume>:/~ quay.io/ibm/bash:4.4 bash <path/to/your/mounted/script>
```

## Testing scripts via `Dockerfile`

```dockerfile
FROM quay.io/ibm/bash:4.4

COPY script.sh /

CMD ["bash", "/script.sh"]
```

Then, build and run the Docker image:

```console
$ docker build -t my-bash-app .
...
$ docker run -it --rm --name my-running-app my-bash-app
...
```

# License

Bash is free software, distributed under the terms of the [GNU General Public License, version 3](http://www.gnu.org/licenses/gpl.html).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

Some additional license information which was able to be auto-detected might be found in [the `repo-info` repository's `bash/` directory](https://github.com/docker-library/repo-info/tree/master/repos/bash).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
