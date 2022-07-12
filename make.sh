#!/bin/bash
echo "input domain: "  
read user_name  

echo "input workdir: "  
read workdir  

# array=(${user_name//,/ })  
## 配置域名前缀
nums=('mobile' 'api' 'superadmin' 'bus' 'sto' 'admin' 'mini')


NGINXs=''
# for var in ${array[@]}
# do
# echo $var
  for index in ${nums[@]}
  do
    # if [[ $var =~ $index ]]
    # then
      var="$index.$user_name"
      if [ "$index" == 'api' ]
      then
        index=''
      fi
      if [ "$index" == 'superadmin' ]
      then
        index='admin'
      fi
  regs='^(.+?\.php)(/.+)'
echo "
server {
    listen       80;
    server_name  $var;

    access_log  logs/access-${var}.log main;
    error_log  logs/err-${var}.log;

    location / {
        root   ${workdir};
        index  index${index}.php index.html index.htm;
        try_files \$uri \$uri/ /index${index}.php?\$query_string;
        if (!-e \$request_filename) {
            rewrite ^/(.*)$ /index${index}.php/\$1 last;
            break;
        }
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }

    location ~ .php {
        root           ${workdir};
        fastcgi_pass    unix:/tmp/php-cgi.sock;
        fastcgi_index  index.php;

        set \$path_info \"\";
        set \$real_script_name \$fastcgi_script_name;

        #rewrite ^\/Payment\/Noity\/(.*) index.php?_apiname=Payment.Noity.\$1 last;

        if (\$fastcgi_script_name ~ \"${regs}\$\") {
            set \$real_script_name \$1;
            set \$path_info \$2;
        }

        fastcgi_param  SCRIPT_FILENAME  \$document_root\$real_script_name;
        fastcgi_param  SCRIPT_NAME  \$real_script_name;
        fastcgi_param  PATH_INFO  \$path_info;
        include        fastcgi_params;
    }
}
" > "$var.conf" 

    # fi
  done
# done