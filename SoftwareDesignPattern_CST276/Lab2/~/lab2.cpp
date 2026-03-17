#include <SFML/Graphics.hpp>
#include "Config.h"
#include "EnemyFactory.h"
#include "Entity.h"
#include "Ship.h"

void render(sf::RenderWindow & window, std::vector<Entity*> & entities) {
  // always clear!
  window.clear();

  // drawing happens here (off-screen)
  for (Entity * entity : entities) {
    entity->render(window);
  }

  // swap the display buffer (double-buffering)
  window.display();
}

void processEvents(sf::RenderWindow & window) {
  sf::Event event;
  while (window.pollEvent(event)) {
    if (event.type == sf::Event::Closed) {
      window.close();
    }
  }
}

void update(sf::Time dt, std::vector<Entity*> & entity) {
  float s{dt.asSeconds()};

  for (Entity * entities : entity) {  //window.getsize() or something instead of config window stuff
    entities->update(s);
  }
}

int main(int argc, char * argv[]) {
  
  const char * filename{ argc > 1 ? argv[1] : "config.txt"};
  
  //configure the window
  Config::instance().readConfig(filename);
  sf::RenderWindow window{sf::VideoMode{Config::instance().getWindowWidth(), 
                                        Config::instance().getWindowHeight()}, "Lab2"};

        
  std::vector <Entity*> entities{ EnemyFactory::makeSomeEnemies()};
  Entity* ship = new Ship{};
  entities.push_back(ship);

  // for info on game loops:
  //   https://subscription.packtpub.com/book/game+development/9781849696845/1/ch01lvl1sec11/game-loops-and-frames
  sf::Clock clock;

  sf::Time t{sf::Time::Zero}; // time
  sf::Time dt{sf::seconds(1.0f / 60.0f)}; // delta time (fixed to 60fps)

  while (window.isOpen()) {
    processEvents(window);
    t += clock.restart();

    while (t > dt) {
      t -= dt;
      processEvents(window);
      update(dt, entities);
    }

    render(window, entities);
  
  } 

  for (Entity * entity : entities)
  {
    delete entity;
  }

} 
