#############################################################
# Dockerfile to build a sample tool container for BAMStats
#############################################################

# Set the base image to Ubuntu originally FROM ubuntu:14.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Edico Hello Test original by briandoconnor <just-testing-123@gmail.com>

# Setup packages originally openjdk-7-jre
USER root
RUN apt-get -m update && apt-get install -y wget unzip openjdk-8-jre zip

# get the tool and install it in /usr/local/bin
RUN wget -q http://downloads.sourceforge.net/project/bamstats/BAMStats-1.25.zip
RUN unzip BAMStats-1.25.zip && \
    rm BAMStats-1.25.zip && \
    mv BAMStats-1.25 /opt/
COPY bin/bamstats /usr/local/bin/
RUN chmod a+x /usr/local/bin/bamstats

# switch back to the ubdocker user so this tool (and the files written) are not owned by root originally ubuntu user
RUN groupadd -r -g 1001 ubtest && useradd -r -g ubtest -u 1001 -m ubtest
USER ubtest

# by default /bin/bash is executed
CMD ["/bin/bash"]
