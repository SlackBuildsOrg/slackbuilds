config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then
    # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

preserve_perms() {
  NEW="$1"
  OLD="$(dirname ${NEW})/$(basename ${NEW} .new)"
  if [ -e ${OLD} ]; then
    cp -a ${OLD} ${NEW}.incoming
    cat ${NEW} > ${NEW}.incoming
    mv ${NEW}.incoming ${NEW}
  fi
  config ${NEW}
}

preserve_perms etc/rc.d/rc.openresty.new
config etc/logrotate.d/openresty.new
config usr/local/openresty/nginx/conf/fastcgi_params.new
config usr/local/openresty/nginx/conf/fastcgi.conf.new
config usr/local/openresty/nginx/conf/mime.types.new
config usr/local/openresty/nginx/conf/nginx.conf.new
config usr/local/openresty/nginx/conf/koi-utf.new
config usr/local/openresty/nginx/conf/koi-win.new
config usr/local/openresty/nginx/conf/scgi_params.new
config usr/local/openresty/nginx/conf/uwsgi_params.new
config usr/local/openresty/nginx/conf/win-utf.new
