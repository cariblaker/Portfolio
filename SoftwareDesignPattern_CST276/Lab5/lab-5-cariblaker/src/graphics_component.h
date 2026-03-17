#pragma once
#include <SFML/Graphics.hpp>

//class World;
class Entity;
class Graphics;

class GraphicsComponent {
public:
    virtual ~GraphicsComponent() {}
    virtual void update(Entity * entity, Graphics * graphics) = 0;
    sf::Sprite sprite{};
    sf::Texture texture{};
    float size_x{};
    float size_y{};
};
