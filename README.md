# ipk2apk
openwrt ipk to apk (WIP)

# Config
apk支持以下两个位置的软件源：`/etc/apk/repositories`, `/etc/apk/repositories.d/*.list`。

apk支持root参数指定根目录`apk -root "/tmp/is-root"`，但是好像不支持单独指定index缓存目录。

# Ref

https://wiki.alpinelinux.org/wiki/Apk_spec

https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper

https://gitlab.alpinelinux.org/alpine/apk-tools/-/blob/master/doc/apk-v2.5.scd?ref_type=heads

https://gitlab.alpinelinux.org/alpine/apk-tools/-/blob/master/doc/apk-v3.5.scd?ref_type=heads

https://man.archlinux.org/man/extra/apk-tools/apk.8.en

https://man.archlinux.org/man/extra/apk-tools/apk-repositories.5.en
