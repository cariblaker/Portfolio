#pragma once

#include "Entity.h"
#include "Config.h"

class Ship : public Entity
{
public:

    Ship()
    {
        ship.setFillColor(sf::Color::White);
        ship.setPosition( (Config::instance().getWindowWidth() / 2), ( (Config::instance().getWindowHeight() - (ship.getRadius() * 2) ) ) );
    }

    void render(sf::RenderWindow & window) override 
    {
        window.draw(ship);
    }

    void update(float dt) override 
    {
        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) 
        {
            ship.move(20*dt, 0);
        }

        if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left)) 
        {
            ship.move(-20*dt, 0);
        }
    }

private:
    sf::CircleShape ship{20.f};

};
