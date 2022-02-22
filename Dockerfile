FROM registry.access.redhat.com/ubi8/php-74:1-47

ENV BUILD_ENV=${BUILD_ENV:-dev}
ENV DOCUMENTROOT=/public

# USER root
USER 0

# Copy and Work dir
WORKDIR /opt/app-root/src
COPY . .
#RUN mv .env.${BUILD_ENV} .env

# Composer
#RUN TEMPFILE=$(mktemp) && \
 #   curl -o "$TEMPFILE" "https://getcomposer.org/installer" && \
  #  php <"$TEMPFILE" && \
   # ./composer.phar install --no-interaction --no-ansi --optimize-autoloader

#RUN ln -s storage/app public/storage

# Cache laravel
#RUN php artisan cache:clear

# Set the default command for the resulting image
CMD /usr/libexec/s2i/run
