

[TOC]

## Jupyter Lab



安装：https://www.dazhuanlan.com/2020/05/27/5ece2f73814c5/

各种语言的 kernel：https://github.com/jupyter/jupyter/wiki/Jupyter-kernels

主题和插件：https://zhuanlan.zhihu.com/p/83252017



### 安装 Jupyter Lab

````bash
# 管理员身份运行cmd，首先安装 Jupyter Lab
python3 --version # 确认Python安装成功
pip --version # 确认pip3安装成功
pip install jupyterlab==3 # 安装成功，但是还没有对js的支持。


# 进入你项目路径
cd "C:\Users\Humoonruc\OneDrive\ICT\Programming-Language\Notes-of-Languages\Notes-JavaScript\3-Node.js\305-Jupyter-JavaScript(Node)"

# 安装中文语言包，然后在设置中选择中文
pip install jupyterlab_language_pack_zh_CN-0.0.1.dev0-py2.py3-none-any.whl

jupyter lab # 开启 Jupyter Lab
````



<img src="http://humoon-image-hosting-service.oss-cn-beijing.aliyuncs.com/img/typora/JavaScript/image-20210514200837662.png" alt="image-20210514200837662" style="zoom:50%;" />

### 更好的使用方式

建立 .ipynb 文件后，在 vscode 内打开。



### R Kernel

```R
install.packages('IRkernel')
IRkernel::installspec()
```

<img src="http://humoon-image-hosting-service.oss-cn-beijing.aliyuncs.com/img/typora/JavaScript/image-20210514213338166.png" alt="image-20210514213338166" style="zoom:50%;" />



### JavaScript(Node.js)  Kernel

以管理员身份运行 cmd，输入：

```bash
# 安装对js的支持
npm i -g ijavascript
ijsinstall --spec-path=full
# 再打开 Jupyter Lab，就可以在新建中看到 javascript(Node.js) 了。
```

<img src="http://humoon-image-hosting-service.oss-cn-beijing.aliyuncs.com/img/typora/JavaScript/image-20210514200931385.png" alt="image-20210514200931385" style="zoom:50%;" />

#### 用途

有时调试 JS 代码，尤其是 Node.js 代码，不需要非得打开浏览器，在 Jupyter Lab 里就能观察到每一步运行的结果。

比如测试正则表达式、对象的一些方法、算法等等。



### Bash Kernel

```bash
# bash
pip install calysto_bash

# powershell
pip install powershell_kernel
python -m powershell_kernel.install
```

