#include <iostream>

__global__ void AddIntsCUDA(int* a, int* b)
{
    a[0] += b[0];
}

int main()
{
    
    int a = 5;
    int b = 9;
    int* d_a, *d_b;
    if(cudaMalloc(&d_a, sizeof(int)) != cudaSuccess)
        std::cout << "OH NO" << std::endl;
    if(cudaMalloc(&d_b, sizeof(int)) != cudaSuccess)
        std::cout << "OH NO" << std::endl;
    
    cudaMemcpy(d_a, &a, sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, &b, sizeof(int), cudaMemcpyHostToDevice);
    AddIntsCUDA<<<1,1>>>(d_a, d_b);
    
    cudaMemcpy(&a, d_a, sizeof(int), cudaMemcpyDeviceToHost);
    std::cout << "ANS: " << a << std::endl;
    cudaFree(d_a);
    cudaFree(d_b);
    return 0;
}