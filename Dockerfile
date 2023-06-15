# We will use Ubuntu for our image
FROM ubuntu:latest

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa
# Updating Ubuntu packages
RUN  apt-get update && yes|apt-get upgrade

# Adding wget and bzip2 apt-utils
RUN apt-get install -y wget bzip2

# Anaconda installing
RUN wget https://repo.anaconda.com/archive/Anaconda3-2022.10-Linux-x86_64.sh
RUN bash Anaconda3-2022.10-Linux-x86_64.sh -b
RUN rm Anaconda3-2022.10-Linux-x86_64.sh

RUN jupyter --version

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

# # Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# Configuring access to Jupyter
RUN mkdir /opt/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# Install java
RUN apt install -y openjdk-8-jdk

# Install scala
RUN wget https://downloads.lightbend.com/scala/2.11.0/scala-2.11.0.tgz && tar -xvzf scala-2.11.0.tgz && rm scala-2.11.0.tgz
ENV SCALA_HOME=/scala-2.11.0
ENV export PATH=$PATH:$SCALA_HOME/bin:$PATH

# Install Ruby
RUN apt-get install -y libtool libffi-dev ruby ruby-dev make
RUN apt-get install -y libzmq3-dev libczmq-dev

# Configure Java
COPY ijava-1.3.0 ./ijava-1.3.0
RUN cd ijava-1.3.0 && python install.py --sys-prefix

# Configure Scala
COPY almond .
RUN chmod +x ./almond && ./almond --install

# Configure Ruby
RUN gem install cztop
RUN gem install iruby --pre
RUN iruby register --force


# Install Nodejs
RUN apt-get install -y nodejs npm

# Configure javascript
RUN npm install --global --unsafe-perm ijavascript
RUN ijsinstall

# Jupyter listens port: 8888
EXPOSE 8888

# Set working directory
WORKDIR /opt/notebooks

# Copy examples
COPY notebooks /opt/notebooks

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
