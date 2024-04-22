FROM cuhkhaosun/base
RUN apt-get update && apt-get install -y \
    curl \
    git && apt-get clean
RUN git clone https://github.com/PengNi/ccsmeth.git /ccsmeth
RUN curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/miniconda/bin:${PATH}"
RUN conda env create --name ccsmethenv -f /ccsmeth/environment.yml
ENV CONDA_DEFAULT_ENV=ccsmethenv
RUN echo "conda activate ccsmethenv" >> ~/.bashrc
WORKDIR /ccsmeth
CMD [ "/bin/bash", "-c", "source activate ccsmethenv && exec bash" ]
CMD ["/bin/bash", "/ccsmeth/run.sh"]