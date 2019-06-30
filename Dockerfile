# docker build -t ner1804_366 .
## switch back to default user
FROM consol/ubuntu-xfce-vnc
ENV REFRESHED_AT 2018-03-18

# Switch to root user to install additional software
USER 0

# ENV Variables
ENV DEBIAN_FRONTEND=noninteractive

# Install core packages
RUN apt-get update
RUN apt-get install -y libreadline-gplv2-dev build-essential gfortran checkinstall software-properties-common llvm libc6-dev cmake \
    wget git vim nasm yasm zip unzip pkg-config gdebi-core \
    libxml2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libbz2-dev \
    apt-utils apt-transport-https libapparmor1 libcurl4-openssl-dev libssl1.0.0

# install R
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt-get install -y r-base r-base-dev
RUN wget https://download1.rstudio.org/desktop/xenial/amd64/rstudio-1.2.1335-amd64.deb
RUN gdebi -n rstudio-1.2.1335-amd64.deb
RUN rm rstudio-1.2.1335-amd64.deb


# Install Python 3 and pip
RUN apt-get update
RUN apt-get install -y python3-pip 

# install CRFSuite and Jupyter
RUN pip3 install ipython[all] sklearn python-crfsuite

# Install Java 8
RUN apt-get install -y openjdk-8-jdk

## switch back to default user
USER 1000

# install Core NLP
RUN wget -P ~ http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
RUN unzip ~/stanford-corenlp-full-2018-10-05.zip -d ~
RUN rm ~/stanford-corenlp-full-2018-10-05.zip
#    && cd stanford-corenlp-full-2018-10-05 \
#    && for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done \
#    && echo "the quick brown fox jumped over the lazy dog" > input.txt java -mx3g edu.stanford.nlp.pipeline.StanfordCoreNLP -outputFormat json -file input.txt

# switch to root to install software
USER 0
#
