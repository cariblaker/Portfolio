#include <SFML/Graphics.hpp>

int main() {
  sf::RenderWindow window{sf::VideoMode{800, 600}, "Lab"};

  sf::CircleShape shape{100};
  shape.setFillColor(sf::Color::Blue);
  shape.setOutlineColor(sf::Color::White);
  shape.setPosition(800/2 - 100, 600/2 - 100);

  while (window.isOpen()) {
    sf::Event event;
    while (window.pollEvent(event)) {
      if (event.type == sf::Event::Closed) {
        window.close();
        break;
      }
    }

    window.clear();
    window.draw(shape);
    window.display();
  }
}
