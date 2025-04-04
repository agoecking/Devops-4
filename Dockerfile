# Usa a imagem oficial do PHP com suporte a FPM
FROM php:8.2-fpm

# Define o diretório de trabalho no contêiner
WORKDIR /var/www/html

# Instala o Nginx e outras dependências
RUN apt-get update && apt-get install -y nginx curl unzip && rm -rf /var/lib/apt/lists/*

# Copia os arquivos da aplicação
COPY . /var/www/html

# Define permissões adequadas
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Copia a configuração do Nginx
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

# Expõe a porta 80
EXPOSE 80

# Inicia o PHP-FPM e o Nginx corretamente
CMD ["sh", "-c", "php-fpm & exec nginx -g 'daemon off;'"]
