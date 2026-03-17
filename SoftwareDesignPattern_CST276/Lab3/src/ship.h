#pragma once

#include "entity.h"
#include "config.h"

class Ship : public Entity
{
public:

    Ship() : acceleration(1) {
        ship.setFillColor(sf::Color::White);
        ship.setPosition( (Config::instance().getWindowWidth() / 2), ( (Config::instance().getWindowHeight() - (ship.getRadius() * 2) ) ) );
    }

    void render(sf::RenderWindow & window) override {
        window.draw(ship);
    }

    void update(float dt) override {
        auto dx = velocity.x*dt;
        auto dy = velocity.y*dt;

        if (timer > 0) {
            constexpr int speed{100};
            dx += rand(-speed, speed)*dt;
            dy += rand(-speed, speed)*dt;
            --timer;
        }

        
        // Screen wrapping
        const float padding{ship.getRadius()};
        unsigned int screenWidth{Config::instance().getWindowWidth()};
        unsigned int screenHeight{Config::instance().getWindowHeight()};
        if (ship.getPosition().x < -padding) {
            ship.setPosition(screenWidth + padding, ship.getPosition().y);
        } else if (ship.getPosition().x > screenWidth + padding) {
            ship.setPosition(-padding, ship.getPosition().y);
        }
        if (ship.getPosition().y < -padding) {
            ship.setPosition(ship.getPosition().x, screenHeight + padding);
        } else if (ship.getPosition().y > screenHeight + padding) {
            ship.setPosition(ship.getPosition().x, -padding);
        }


        ship.move(dx*acceleration, dy*acceleration);
    }

    void shake() override {
        if (timer == 0) {
            timer = 50;
        }
    }

    void setVelocity(sf::Vector2f newVel) override {        //only the keys are using this function for now, so acceleration only increases when an arrow key is pressed
        velocity = newVel;
        acceleration++;
    }

private:
    sf::CircleShape ship{20.f};
    sf::Vector2f velocity{};
    int acceleration;
    int timer{};
};