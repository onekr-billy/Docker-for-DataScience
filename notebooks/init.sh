# /bin/bash

# 升级 pip
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple/ pip -U
# 生成 pip 配置文件
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/

conda config --add channels http://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --add channels http://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/pkgs/main/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/cloud/msys2/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/cloud/bioconda/
conda config --add channels http://mirrors.ustc.edu.cn/anaconda/cloud/menpo/
conda config --set show_channel_urls yes

# mamba install xeus-sql jupyterlab -c conda-forge

# install chines language
pip install jupyterlab-language-pack-zh-CN

pip install jsonpath
pip install jupyterlab_code_formatter
pip install jupyterlab-git
pip install ipython-sql
pip install py-heat-magic

# install plugin @krassowski/jupyterlab-lsp
# Settings–>Advanced Settings Editor -> Code Completion 代码完成 {"continuousHinting": true}
pip install jupyter-lsp
pip install python-lsp-server[all]


