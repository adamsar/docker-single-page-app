echo "S3_BUCKET=$S3_BUCKET"

if [ -f /nginx.conf.tmpl ]; then
    cat /nginx.conf.tmpl | envsubst > /nginx/conf/nginx.conf
    sed -i -e 's/<1>/$1/g' /nginx/conf/nginx.conf
    sed -i -e 's/<request_method>/$request_method/g' /nginx/conf/nginx.conf
    sed -i -e 's/<http_x_forwarded_proto>/$http_x_forwarded_proto/g' /nginx/conf/nginx.conf
    sed -i -e 's/<dollar>/$/g' /nginx/conf/nginx.conf
fi

cat /nginx/conf/nginx.conf
echo "\n\nStarting nginx....\n"
nginx
echo "Started!\n"
tail -f /nginx/logs/access.log /nginx/logs/error.log
