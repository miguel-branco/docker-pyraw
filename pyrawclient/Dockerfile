FROM ipython/notebook
MAINTAINER Miguel Branco <miguel.branco@epfl.ch>

RUN apt-get update && apt-get install -y \
  postgresql-9.3 \
  libpq-dev \
  git \
  python-dev \
  python-pip \
  python-pandas \
  python-psycopg2

# Install RAW package
RUN pip install git+git://github.com/miguel-branco/pyrawcore.git

# Set volumes for data and json
VOLUME /data
VOLUME /resources

ADD start.sh /
RUN chmod u+x /start.sh

CMD ["/start.sh"]