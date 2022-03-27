#include "print.h"

void kernal_main(){
  print_clear();
  print_set_color(PRINT_COLOR_YELLOW, PRINT_COLOR_BLACK);
  print_str("Hello World!");
  print_newline();
  print_str("whats up how are things going?");
}

