server {
    server_name ~^(www\.)?(?<domain>.+)$;
    root {{ doc_root }}/$domain/www;
    gzip_static on;

    location = /favicon.ico {
                log_not_found off;
                access_log off;
    }

    location = /robots.txt {
                allow all;
                log_not_found off;
                access_log off;
    }

    location ~* \.(txt|log)$ {
                allow 192.168.0.0/16;
                deny all;
    }

    location ~ \..*/.*\.php$ {
                return 403;
    }

    location ~ ^/sites/.*/private/ {
                return 403;
    }

    location ~ (^|/)\. {
                return 403;
    }

    location / {
                try_files $uri @rewrite;
    }

    location @rewrite {
                rewrite ^ /index.php;
    }

    location ~ \.php$ {
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                include fastcgi_params;
                fastcgi_param SCRIPT_FILENAME $request_filename;
                fastcgi_intercept_errors on;
                fastcgi_pass unix:/var/run/php5-fpm.sock;
    }

   location ~ ^/sites/.*/files/styles/ {
                try_files $uri @rewrite;
   }

   location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
                expires max;
                log_not_found off;
   }
}
