# ipk2apk

`ipk2apk` 是一个用于将传统 OpenWrt 的 `.ipk` (opkg) 格式软件包转换为新版的 `.apk` (APKv3) 格式的工具。

### 主要功能

- 元数据映射：提取 IPK `control` 文件中的字段（包名、版本、依赖、架构、描述等）并转换为 APK 规范，支持解析 `Require-User` 生成 `.rusers`，兼容 `-rN` 版本号后缀
- 脚本重建：模拟 OpenWrt 构建系统逻辑，将 `postinst-pkg` / `prerm-pkg` 等包内逻辑代码与系统级脚本外壳拼接，生成 `post-install`、`pre-upgrade`、`post-upgrade` 和 `pre-deinstall` 生命周期脚本
- 配置保留：提取和解析 `conffiles` 配置文件列表，并生成相应的 `.conffiles_static`（包含文件的 SHA256 校验和），用于在升级时保留用户配置
- 列表生成：扫描安装文件并在包内生成 `/lib/apk/packages/<name>.list` 以符合 APK 包规范
- 批量处理：支持单文件转换及通配符、多文件输入批量操作

### 环境要求

满足以下条件**之一**即可：
1. 系统中有可用的 `apk` 和 `fakeroot` 命令，并能直接在 shell 中调用
2. 系统中有本地的 Docker 环境，且 `docker` 命令能被直接调用

### 脚本使用

1. 拉取项目
2. 将 bin 路径添加到 PATH 环境变量；或进入 bin 目录执行 `./ipk2apk`

#### 转换单个 IPK 文件

将生成的 `.apk` 文件保存在当前目录：

```bash
./ipk2apk test-package_1.0-1_aarch64_generic.ipk
```

#### 转换并指定输出目录

仅支持单个 IPK 转换时使用，批量转换时，参数不生效

```bash
./ipk2apk test.ipk /tmp/output_folder
```

#### 批量转换当前目录下所有 IPK

```bash
./ipk2apk *.ipk
```

#### 转换指定的多个 IPK 文件

```bash
./ipk2apk test1.ipk test2.ipk test3.ipk
```
