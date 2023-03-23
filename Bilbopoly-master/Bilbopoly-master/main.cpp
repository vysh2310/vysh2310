// main.cpp

#include <cstdlib>
#include <iostream>

#include "game.h"
#include "player.h"

typedef unsigned int uint32_t;

uint32_t main() {
  try {
    game a_game;
    player a_player_0("Sand");
    player a_player_1("Vins");
    a_game.add_player(&a_player_0);
    a_game.add_player(&a_player_1);
    a_game.play();
    std::cout << "Going to run the destructures as exiting the main.";
  }

  catch (...) {
    std::cout << "An error occured" << std::endl;
  }

  return 0;
}
