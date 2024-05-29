#include <stdio.h>
#include <math.h>

int sum(int a, int b)
{
  int s = 0;
  s = a + b;
  if(s > 99999999 || s < -99999999)
    return -1;
  return s;
}

int diff(int a, int b)
{
  int diff = 0;
  diff = a - b;
  if(diff > 99999999 || diff < -99999999)
    return -1;
  return diff;
}

int prod(int a, int b)
{
  int prod = 0;
  prod = a * b;
  if(prod > 99999999 || prod < -99999999)
    return -1;
  return prod;
}

int div(int a, int b)
{
  int div = 0;
  if(b == 0)
    return -1;
  div = a / b;
  if(div > 99999999 || div < -99999999)
    return -1;
  return div;
}

int fact(int n)
{
  int fact = 1;
  if(n < 0)
    return -1;
  if(n == 0)
    return 1;
  for(int i = n; i > 1; i--)
    fact = fact * i;
  if(fact > 99999999)
    return -1;
  return fact;
}

int radical(int n)
{
  int rad = 0;
  if(n < 0)
    return -1;
  rad = sqrt(n);
  return rad;
}

int power(int a, int b)
{
  int pow = 1;
  if(b < 0)
    return -1;
  for(int i = 0; i < b; i++)
    pow = pow * a;
  if(pow > 99999999 || pow < -99999999)
    return -1;
  return pow;
}
