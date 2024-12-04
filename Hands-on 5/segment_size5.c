#include<stdio.h>

int myglobalint1 = 500;
int myglobalint2;
int main() {
  static int mystaticint1;
  static int mystaticint2 = 100; 
  printf("Hello Word\n");
  return 0;
}
