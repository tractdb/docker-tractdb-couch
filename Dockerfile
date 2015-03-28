FROM ubuntu:14.04

# Install the packages we need for getting things done
RUN apt-get update && \
    apt-get install -y \
      build-essential \
      dos2unix \
      git \
    && \
    apt-get clean

# Install the packages we need for CouchDB
RUN apt-get update && \
    apt-get install -y \
      couchdb \
      python3-pip \
    && \
    apt-get clean

# Install the Python packages we need
COPY requirements3.txt /tmp/requirements3.txt
RUN pip3 install -r /tmp/requirements3.txt && \
    rm /tmp/requirements3.txt

## Our local.ini file, which still needs the secret added
COPY local.ini /tmp/local.ini
RUN dos2unix /tmp/local.ini

# We use this script to manipulate our local.ini to add the secret
COPY applysecrets.py /tmp/applysecrets.py

# Port where CouchDB will listen
EXPOSE 5984

# Expose our data and logs
VOLUME ["/var/lib/couchdb", "/var/log/couchdb"]

# Volume for secrets
VOLUME ["/secrets"]

# Our wrapper script
COPY run.sh /tmp/run.sh
RUN dos2unix /tmp/run.sh
RUN chmod a+x /tmp/run.sh

# Run the wrapper script
CMD ["/tmp/run.sh"]
