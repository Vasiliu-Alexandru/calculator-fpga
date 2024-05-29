#include <stdio.h>
#include "funct.h"

int main(void)
{
  int a, b, ok = 0;
  char op = 0;
  printf("Introduceti primul numar: ");
  scanf("%d", &a);
  while(ok == 0)
    {
      printf("Introduceti operatia: ");
      scanf(" %c", &op);
      switch(op)
	{
	case 'a':
	  {
	    printf("Introduceti urmatorul numar: ");
	    scanf("%d", &b);
	    printf("Rezultat: %d\n", sum(a, b));
	    a = sum(a, b);
	    break;
	  }
	case 's':
	  {
	    printf("Introduceti urmatorul numar: ");
	    scanf("%d", &b);
	    printf("Rezultat: %d\n", diff(a, b));
	    a = diff(a, b);
	    break;
	  }
	case 'i':
	  {
	    printf("Introduceti urmatorul numar: ");
	    scanf("%d", &b);
	    printf("Rezultat: %d\n", prod(a, b));
	    a = prod(a, b);
	    break;
	  }
	case 'd':
	  {
	    printf("Introduceti urmatorul numar: ");
	    scanf("%d", &b);
	    printf("Rezultat: %d\n", div(a, b));
	    a = div(a, b);
	    break;
	  }
	case 'f':
	  {
	    printf("Rezultat: %d\n", fact(a));
	    a = fact(a);
	    break;
	  }
	case 'p':
	  {
	    printf("Introduceti urmatorul numar: ");
	    scanf("%d", &b);
	    printf("Rezultat: %d\n", power(a, b));
	    a = power(a, b);
	    break;
	  }
	case 'r':
	  {
	    printf("Rezultat: %d\n", radical(a));
	    a = radical(a);
	    break;
	  }
	default:
	  {
	    ok = 1;
	    break;
	  }
	}
    }
  return 0;
}
