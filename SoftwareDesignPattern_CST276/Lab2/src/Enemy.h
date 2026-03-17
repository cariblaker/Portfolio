#pragma once
#include <SFML/Graphics.hpp>
#include "Entity.h"
#include "Config.h"


class Enemy : public Entity {
public:

    Enemy()
    {
        enemy.setSize(sf::Vector2f(50, 50));
        initial_position = enemy.getPosition();
    }

    Enemy(float x, float y)
    {
        enemy.setFillColor(sf::Color::Red);
        enemy.setSize(sf::Vector2f(50, 50));
        enemy.setPosition(x, y);
        initial_position = enemy.getPosition();
    }

    void render(sf::RenderWindow & window) override 
    {
        window.draw(enemy);
    }

    void update(float dt) override
    {
        if ( (enemy.getPosition().x < 0) || (enemy.getPosition().x > (Config::instance().getWindowWidth() - enemy.getSize().x) ) )
        {
            x_movement = -x_movement;
            enemy.move(0.0, enemy.getSize().y);                        
        }
        if (enemy.getPosition().y > (Config::instance().getWindowHeight() - enemy.getSize().y) ) 
            enemy.setPosition(initial_position);

        enemy.move(x_movement * dt, y_movement * dt);
    }


protected:
    sf::RectangleShape enemy{};
    float x_movement{100};
    float y_movement{0};
    sf::Vector2f initial_position{};

};
