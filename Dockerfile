FROM alpine:3.6

ENV BUILD_PACKAGES build-base \
                   libxml2-dev \
                   libffi-dev \
                   ruby-dev \
                   sqlite-dev

ENV RUNTIME_PACKAGES bash \
                     curl \
                     libreoffice \
                     nodejs \
                     openjdk8-jre \
                     ruby \
                     ruby-bigdecimal \
                     ruby-bundler \
                     ruby-irb \
                     ruby-rdoc \
                     tzdata \
                     unzip

ENV GEM_HOME /home/rails/.ruby/gems
ENV PATH $PATH:/home/rails/.ruby/gems/bin
ENV RAILS_VERSION 5.0.3
ENV FITS_VERSION 1.0.5

COPY . /srv/rails/hyrax

RUN apk --no-cache add $BUILD_PACKAGES \
    && apk --no-cache add $RUNTIME_PACKAGES \
    && addgroup -g 400 rails \
    && adduser -Ss /bin/sh -u 400 -G rails rails \
    && chown -R rails:rails /srv/rails \
    && curl -o /tmp/fits.zip http://projects.iq.harvard.edu/files/fits/files/fits-$FITS_VERSION.zip \
    && cd /tmp && unzip fits.zip \
    && chmod +x /tmp/fits-$FITS_VERSION/fits.sh \
    && cp -r fits-$FITS_VERSION/* /usr/local/bin/ \
    && ln -s /usr/local/bin/fits.sh /usr/local/bin/fits \
    && rm /tmp/fits.zip && rm -rf /tmp/fits-$FITS_VERSION \
    && ruby -pi -e "gsub(/gem 'therubyracer', platforms: :ruby/, '')" /srv/rails/hyrax/Gemfile \
    && su rails -c "gem install rails -v $RAILS_VERSION" \
    && su rails -c "bundle install --gemfile=/srv/rails/hyrax/Gemfile" \
    && su rails -c "cd /srv/rails/hyrax && bin/rails db:migrate RAILS_ENV=development"

USER rails

EXPOSE 3000

WORKDIR /srv/rails/hyrax

VOLUME /srv/rails/hyrax

CMD ["bin/rails", "hydra:server"]