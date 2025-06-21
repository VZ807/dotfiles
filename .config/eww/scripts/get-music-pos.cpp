#include <cstring>
#include <iostream>
#include <string>
int main(int argc, char *argv[]) {
  if (strcmp(argv[1], "No players found")) {
    std::cout << "-1";
    return 0;
  }
  float position = std::stof(argv[1]);
  float length = std::stof(argv[2]);
  float pos = (position / (length / 1000000)) * 100;
  std::cout << pos;
  return 0;
}
