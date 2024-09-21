if [ -e /usr/bin/context ]; then
	rm /usr/bin/context* /usr/bin/mtxrun*
fi
(export PATH=/opt/context/native/bin:$PATH
 cd /opt/context/native/bin
 ln -s /usr/share/texmf-dist/scripts/context/lua/context.lua
 ln -s /usr/share/texmf-dist/scripts/context/lua/mtxrun.lua
 ln -s luametatex context
 ln -s luametatex mtxrun
 cd ../..
ln -s /usr/share/texmf-config
ln -s /usr/share/texmf-dist
ln -s /usr/share/texmf-local
ln -s /usr/share/texmf-var
/opt/context/native/bin/mtxrun --generate)
