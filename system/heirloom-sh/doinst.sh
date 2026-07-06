if [ ! -r etc/shells ]; then
  touch etc/shells
  chmod 644 etc/shells
fi

if ! grep -q '^/usr/bin/hsh$' etc/shells ; then
  echo /usr/bin/hsh >> etc/shells
  echo /usr/bin/jsh >> etc/shells
fi
