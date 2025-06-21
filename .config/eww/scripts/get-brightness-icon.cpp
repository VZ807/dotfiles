#include <iostream>
#include <string>
int main(int argc, char *argv[]) {
  float percent = ((std::stof(argv[1]) * 100) / 937);
  if (percent >= 90) {
    std::cout << 2;
  }
}
