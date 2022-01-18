#include<stdio.h>
#include"fun.h"

int fun(int x)
{
    int i = 0;
    i = fun_inside(1);
    return i > 0;
}

int fun_inside(int x)
{
    printf("enter fun_inside\n");
    return x - 1;
}