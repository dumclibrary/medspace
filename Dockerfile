FROM ruby:2.3.4

ENV FITS_VERSION 1.0.5

ENV BUILD_PACKAGES curl unzip

ENV RUNTIME_PACKAGES ghostscript \
                     imagemagick \
                     libreoffice \
                     nodejs \
                     openssh-client \
                     rsync \
                     supervisor

RUN echo "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN cat /etc/apt/sources.list

RUN apt-get update && apt-get install -y $BUILD_PACKAGES $RUNTIME_PACKAGES

RUN curl -o /tmp/fits.zip http://projects.iq.harvard.edu/files/fits/files/fits-$FITS_VERSION.zip \
    && cd /tmp && unzip fits.zip \
    && chmod +x /tmp/fits-$FITS_VERSION/fits.sh \
    && cp -r fits-$FITS_VERSION/* /usr/local/bin/ \
    && ln -s /usr/local/bin/fits.sh /usr/local/bin/fits \
    && rm /tmp/fits.zip && rm -rf /tmp/fits-$FITS_VERSION \
    && apt-get purge -y --auto-remove $BUILD_PACKAGES

ADD . /srv/rails

WORKDIR /srv/rails

RUN useradd -m rails \
    && chown -R rails:rails /srv/rails \
    && su rails -c "bundle install" \
    && su rails -c "bin/rails assets:precompile RAILS_ENV=production SECRET_KEY_BASE=secret"