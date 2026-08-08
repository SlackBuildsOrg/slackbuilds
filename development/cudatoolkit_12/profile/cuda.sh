export CUDA_PATH=/opt/cuda-@VERSION@
export PATH="$CUDA_PATH/bin":"$CUDA_PATH/nsight_compute":"$CUDA_PATH/nsight_systems/bin":"$PATH"
export MANPATH="$CUDA_PATH/gds/man":"$MANPATH"
export PKG_CONFIG_PATH="$CUDA_PATH/usr/share/pkgconfig":"$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$CUDA_PATH/lib64":"$CUDA_PATH/nvvm/lib64":"$CUDA_PATH/extras/CUPTI/lib64":"$LD_LIBRARY_PATH"
