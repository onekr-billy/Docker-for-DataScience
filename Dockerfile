FROM continuumio/anaconda3:latest

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:openjdk-r/ppa

# Adding wget and bzip2 apt-utils
RUN apt-get install -y wget bzip2

# Configuring access to Jupyter
RUN conda install jupyter -y --quiet

RUN jupyter notebook --generate-config --allow-root
# password root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# RUN conda update -n base -c defaults conda
# mamba package manage
# RUN conda install -c conda-forge mamba

# Install java
RUN apt install -y openjdk-11-jdk

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
RUN apt-get install -y nodejs

# Configure javascript
# RUN npm install -g node-gyp && npm install --global ijavascript
# RUN ijsinstall

# Jupyter listens port: 8888
EXPOSE 8888

RUN mkdir /opt/notebooks

# Set working directory
WORKDIR /opt/notebooks

# Copy examples
COPY notebooks /opt/notebooks

RUN /opt/notebooks/init.sh

# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
