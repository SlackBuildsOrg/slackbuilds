# Update shared library cache
if [ -x /sbin/ldconfig ]; then
    /sbin/ldconfig 2>/dev/null
fi
