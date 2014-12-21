FROM ubuntu:14.04
MAINTAINER Miguel Branco <miguel.branco@epfl.ch>

RUN apt-get update && apt-get install -y \
  postgresql-9.3 \
  postgresql-contrib-9.3 \
  postgresql-server-dev-9.3 \
  git \
  python-dev \
  python-pip \
  python-pandas \
  python-psycopg2

# Install (patched) Multicorn
RUN cd /tmp && git clone git://github.com/miguel-branco/Multicorn.git && \
    cd Multicorn && \
    make && \
    make install

# Install RAW packages
RUN pip install git+git://github.com/miguel-branco/pyrawcore.git
RUN pip install git+git://github.com/miguel-branco/pyrawfdw.git

# Create RAW configuration file
RUN echo "[files]\nbase_path=/data\n\n[sql]\nresource_path=/resources\nconnection_string = host=localhost port=5432 dbname=raw" > /etc/raw.config

# Run the remaining as the postgres user
USER postgres

ENV PATH /usr/lib/postgresql/9.3/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

# Initialize PostgreSQL
RUN initdb

# Set PostgreSQL to listen on all address
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Allow externals connections to PostgreSQL for 'raw' user
RUN echo "host all raw 0.0.0.0/0 md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# Create 'raw' user and database in PostgreSQL and configure FDW
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER raw WITH SUPERUSER PASSWORD 'raw';" && \
    createdb -O raw raw && \
    psql --command "CREATE EXTENSION multicorn" raw && \
    psql --command "CREATE SERVER rawfdw FOREIGN DATA WRAPPER multicorn OPTIONS ( wrapper 'pyrawfdw.RawForeignDataWrapper' )" raw

# Expose PostgreSQL port
EXPOSE 5432

# Set volumes for data and json
VOLUME /data
VOLUME /resources

# Default command
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]
