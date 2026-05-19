// cudnn_test.c
#include <stdio.h>
#include <cudnn.h>

int main(void) {
    cudnnHandle_t h;
    cudnnStatus_t s = cudnnCreate(&h);

    if (s != CUDNN_STATUS_SUCCESS) {
      fprintf(stderr, "cudnnCreate failed: %s\n", cudnnGetErrorString(s));
      return 1;
    }

    printf("cuDNN runtime version: %zu\n", cudnnGetVersion());
    cudnnDestroy(h);
    puts("OK");
    return 0;
}

