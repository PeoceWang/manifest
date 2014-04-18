1. 介绍
====
<b>Coron</b>是一个致力于开源ROM制作的项目，开源了制作百度云ROM的所有工具和部分示例机型。采用Apache License 2.0协议，为乐于分享的开发者提供最大的自由度。

开源项目的访问网址是 https://github.com/baidurom ，创立纪元是二零一三年八月八日。旨在让更多的开发者体验百度云ROM的制作过程，感受其间简洁、细节的情怀。

<b>Coron</b>，意味着与开发者合作而生的ROM，<b>CO</b>-operation <b>ROm</b>；
<b>Coron</b>, 意味着百度云ROM强大的云服务能力，<b>RO</b>m <b>O</b>ver <b>C</b>loud；
<b>Coron</b>, 也是一个清新纯净的小岛。


2. 分支命名
===
开源项目的分支命名基于coron，对于单卡机型，后缀为Android 版本；对于双卡机型，后缀为双卡平台与Andorid版本的结合。

已有单卡分支有coron-4.0, coron-4.1, coron-4.2，已有的双卡分支有coron-mtk-4.0, coron-mtk-4.2

这些分支对应到可以制作的ROM版本，譬如，厂商原来的系统是Android 4.2的单卡版本，那么，就推荐使用coron-4.2分支来移植百度云ROM。

开源项目的Git 库主要涉及到6 个部分：

    1) manifest.git：开源项目的Repo 管理清单文件，以及教程和文档。
    2) build.git：编译脚本，包括基于Makfile 编译环境的构建脚本。
    3) tools.git：工具，包括反编译/编译，解包/打包的脚本，以及其他一些实用工具。
    4) overlay.git：资源覆盖，包括Baidu 对原生Android 资源文件的修改。
    5) reference.git : 参考代码，包括aosp, bosp 的反编译代码。
    6) 示例机型的Git 库：已有devices-u930.git, devices-lt26i.git, devices-onex.git 这些机型移植的修改案例。


3. 代码下载
====

通过repo init命令的-b参数，选择需要下载的分支，譬如coron-4.2。
通过repo sync命令同步远程代码。

    repo init -u https://github.com/baidurom/manifest.git -b coron-4.2
    repo sync

如果下载时，出现以下错误，多试几次即可(一般不超过10次，防火墙导致，难以避免)

    fatal: Cannot get https://gerrit.googlesource.com/git-repo/clone.bundle
    fatal: error [Errno 101] Network is unreachable


4. 百度云ROM移植
===
<b>1) 构建开发工程</b>

下载完代码以后，在开源项目根目录，执行以下命令初始化开发环境

    source build/envsetup.sh

创建一个新的机型工程的目录(以demo为例)，后续的移植都在机型目录完成。

    mkdir -p devices/demo
    cd devices/demo

将手机ROOT以后，取到可用的recovery.img或者recovery.fstab，放到机型根目录，执行以下命令生成一个新的机型工程。

    makeconfig
    make newproject

<b>2) 插入代码改动</b>

自动执行patch，将百度云ROM涉及到的改动注入厂商的代码中，然后编译整个工程，生成一个卡刷包。

    make patchall

执行自动Patch时，可能会存在代码合并冲突。冲突会以下面的形式标注出来，开发者需要在厂商的文件中手工解决这些冲突。

    <<<<<<< VENDOR
      原厂的代码块
    =======
      需要改动的代码块
    >>>>>>> BOSP

<b>3) 编译整个机型</b>

    make

具体机型一般有特定的问题，等待开发者去解决，以下文档可以帮助开发者解决一些实际问题：

《Developer-Guide.pdf》，《Details-to-Smali-Development.pdf》


5. 版本升级
===
对于已有的机型，可以自动化进行版本升级。执行以下命令:

    make upgrade FROM=XX

通过FROM参数指定升级的起始版本，即所开发机型当前的ROM版本。譬如FROM=44，表示需要从ROM44升级。
当百度云发布了ROM45后，执行该命令便能自动升级到ROM45。


6. 代码提交
===
代码提交有2种方式：

<b>1) 直接更新Git库</b>

对于具备开源项目管理权限的开发者，可以直接通过git push命令，提交代码改动；

    git push –u origin coron-4.2

在修改后的Git库使用上述命令。origin是远程仓库的别名，是开发者自定义的，也可以为其他别名；coron-4.2是改动的Git库所在的分支。

<b>2) 通过Code Review方式提交代码</b>

对于具备GitHub账户的开发者，可以利用GitHub提供的Pull Request方式，将代码改动以Code Review的形式，发送给开源项目的管理者。待Code Review通过后，代码改动将会合并到提交分支。

为了能够提交代码，开发者需首先注册GitHub账户，将baidurom的Git库Fork到自己的账户下；然后，对Git库进行代码修改，发送Pull Request。最后，在开源项目的管理者收到提交请求时，会对代码进行Code Review，如果符合准入标准，就会将改动代码合并到主干分支中。

