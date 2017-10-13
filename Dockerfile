FROM dev-env-16.04:latest

USER root

RUN apt-get update && apt-get install -y python-pip
RUN apt-get install -y r-base r-cran-littler
RUN apt-get install -y libreadline6 libreadline6-dev
RUN apt-get install -y \
    libopenblas-dev     \
    libopenmpi-dev
RUN apt-get install -y \
  r-cran-rcurl

#RUN pip install --user rpy2 && \
USER mark
ENV HOME /home/mark
WORKDIR $HOME
RUN mkdir -p ~/.local/R_libs
#CRAN dependencies
RUN Rscript -e "install.packages(c('rlecuyer', 'remotes'), \
  repos='https://cran.rstudio.com/', dependencies='Imports',lib='~/.local/R_libs')"
ENV COLOROUT_VERSION 1.1-2 RUN cd /tmp \
  && wget https://github.com/jalvesaq/colorout/releases/download/v1.2-2/colorout_1.1-2.tar.gz \
  && tar zxf colorout_1.1-2.tar.gz \
  && R CMD INSTALL colorout/ \
  && rm colorout_1.1-2.tar.gz \
  && rm -rf colorout/
ENV R_LIBS="~/.local/R_libs/"

# install latest pbdR packages from github 
RUN Rscript -e "                                      \
  remotes::install_github('RBigData/pbdMPI')  ; \
"

RUN pip install --upgrade --user pip
RUN pip install --user rpy2==2.8.0
RUN pip install --user jupyter
COPY visit2_12_3.linux-x86_64/ $HOME/visit2
# COPY my-dogstar/ $HOME/my-dogstar
# USER root
# RUN chown -R mark $HOME/my-dogstar 
#USER mark
#RUN cd $HOME/my-dogstar && ./autogen.sh && \
#CC=mpicc CFLAGS="-fPIC $(/home/mark/local/adios/bin/adios_config -c )" \
#LDFLAGS="$(/home/mark/local/adios/bin/adios_config -l) -ggdb -fPIC" \
#./configure --prefix=/home/mark/local/dogstar --with-adios_dir=/home/mark/local/adios/ && \
#make install


