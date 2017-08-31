FROM debian:stretch

ENV FITS_VERSION 1.0.5

ENV BUILD_PACKAGES curl unzip

ENV RUNTIME_PACKAGES ghostscript \
                     libreoffice \
                     nodejs \
                     openjdk-8-jre-headless

RUN apt-get update && apt-get install -y $BUILD_PACKAGES $RUNTIME_PACKAGES

RUN curl -o /tmp/fits.zip http://projects.iq.harvard.edu/files/fits/files/fits-$FITS_VERSION.zip \
    && cd /tmp && unzip fits.zip \
    && chmod +x /tmp/fits-$FITS_VERSION/fits.sh \
    && cp -r fits-$FITS_VERSION/* /usr/local/bin/ \
    && ln -s /usr/local/bin/fits.sh /usr/local/bin/fits \
    && rm /tmp/fits.zip && rm -rf /tmp/fits-$FITS_VERSION \
    && apt-get purge -y --auto-remove $BUILD_PACKAGES
