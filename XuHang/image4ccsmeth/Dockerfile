# 基础镜像，使用cuhkhaosun/base作为基础镜像  
FROM cuhkhaosun/base  
  
# 更新软件包列表，并安装curl和git工具，然后清理缓存  
RUN apt-get update && apt-get install -y \  
    curl \  
    git && apt-get clean  
  
# 克隆ccsmeth项目的源代码到/ccsmeth目录  
RUN git clone https://github.com/PengNi/ccsmeth.git /ccsmeth  
  
# 下载Miniconda安装脚本，并执行安装到/miniconda目录，然后删除安装脚本  
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \  
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda && \  
    rm Miniconda3-latest-Linux-x86_64.sh  
  
# 将miniconda的bin目录添加到PATH环境变量中，以便全局访问conda命令  
ENV PATH="/miniconda/bin:${PATH}"  
  
# 根据/ccsmeth/environment.yml文件创建名为ccsmethenv的conda环境  
RUN conda env create --name ccsmethenv -f /ccsmeth/environment.yml  
  
# 设置默认的conda环境为ccsmethenv  
ENV CONDA_DEFAULT_ENV=ccsmethenv  
  
# 将本地的run.sh脚本复制到容器的/ccsmeth目录下  
COPY run.sh /ccsmeth/run.sh  
  
# 为/ccsmeth/run.sh脚本添加执行权限  
RUN chmod +x /ccsmeth/run.sh  
  
# 设置工作目录为/ccsmeth  
WORKDIR /ccsmeth  
  
# 容器启动时，激活ccsmethenv环境并执行run.sh脚本  
CMD ["/bin/bash", "-c", "source activate ccsmethenv && ./run.sh"]
