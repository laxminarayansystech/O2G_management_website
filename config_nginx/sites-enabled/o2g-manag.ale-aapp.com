server {
	      listen 80;
	      listen [::]:80;

	      server_name o2g-manag.ale-aapp.com www.o2g-manag.ale-aapp.com;
	      return 301 https://$server_name$request_uri;
      }

server {
	      listen 443 ssl http2;
	      listen [::]:443 ssl http2;

	      ssl_certificate /etc/certificate/bundle.crt;
	      ssl_certificate_key /etc/certificate/myserver.key;

	      #include snippets/ssl-example.com.conf;
	      #include snippets/ssl-params.conf;
	      $userArray = array(
	      
	      root /var/www/html/public;

	      index index.php index.html index.htm index.nginx-debian.html;

	      server_name o2g-manag.ale-aapp.com www.o2g-manag.ale-aapp.com;

	      location / {
	      try_files $uri $uri/ /index.php?$query_string;
	      }

	      location ~ \.php$ {
	      include snippets/fastcgi-php.conf;
	      fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	      }

	      location ~ /\.ht {
	      deny all;
	      }

	      location ~ /.well-known {
	      allow all;
      }
}
