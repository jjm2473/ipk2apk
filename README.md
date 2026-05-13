# ipk2apk

`ipk2apk` 是一个用于将传统 OpenWrt 的 `.ipk` (opkg) 格式软件包转换为新版的 `.apk` (APKND) 格式的工具。

### 主要功能

- 元数据映射：提取 IPK `control` 文件中的字段（包名、版本、依赖、架构、描述等）并转换为 APK 规范
- 脚本转换：处理 `preinst`、`postinst`、`prerm` 和 `postrm` 脚本
- 升级兼容：注入 `post-upgrade` 逻辑，确保软件包在升级过程中保持正确的行为
- 列表生成：扫描安装文件并在包内生成 `/lib/apk/packages/<name>.list` 以符合 APK 包规范
- 批量处理：支持单文件转换及通配符、多文件输入批量操作

### 环境要求

脚本依赖 `apk-tools` 提供的 `apk` 命令行工具进行打包。

- 如果你的系统尚未安装 `apk` 命令，可以下载适用于 x86_64 的静态构建版本：
  
  下载地址：[https://github.com/sbwml/apk-tools/releases](https://github.com/sbwml/apk-tools/releases)
  
- 安装建议：下载后将 `apk` 放置在 `/usr/bin/` 或其他系统 `PATH` 路径下，并赋予执行权限：
  
  ```bash
  chmod +x /usr/bin/apk
  ```

### 脚本使用

下载脚本并添加执行权限：

```bash
chmod +x ipk2apk
```

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
