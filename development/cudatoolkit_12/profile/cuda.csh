#!/bin/csh
setenv CUDA_PATH /opt/cuda-@VERSION@
setenv PATH /opt/cuda-@VERSION@/bin:${PATH}
setenv MANPATH "/opt/cuda-@VERSION@/gds/man":${MANPATH}
setenv PKG_CONFIG_PATH "/opt/cuda-@VERSION@/usr/share/pkgconfig":${PKG_CONFIG_PATH}
setenv LD_LIBRARY_PATH "$CUDA_PATH/lib64":"$CUDA_PATH/nvvm/lib64":"$CUDA_PATH/extras/CUPTI/lib64":"$LD_LIBRARY_PATH"

