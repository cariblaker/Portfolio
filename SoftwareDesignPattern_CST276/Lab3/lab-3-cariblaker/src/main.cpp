#include <SFML/Graphics.hpp>
#include "config.h"
#include "enemyFactory.h"
#include "entity.h"
#include "ship.h"
#include "world.h"


int main(int argc, char * argv[]) {
  
  const char * filename{ argc > 1 ? argv[1] : "config.txt"};
  
  //configure the window
  Config & config = Config::instance();
  config.instance().readConfig(filename);
  World world{config.getWindowWidth(), config.getWindowHeight()};

  
  std::vector<Entity *> entities{EnemyFactory::makeSomeEnemies()};
  Entity* ship = new Ship{};
  entities.push_back(ship);

  world.addEntities(entities);
  
  world.setActor(ship);

  world.run();

  // for info on game loops:
  //   https://subscription.packtpub.com/book/game+development/9781849696845/1/ch01lvl1sec11/game-loops-and-frames
  
} 