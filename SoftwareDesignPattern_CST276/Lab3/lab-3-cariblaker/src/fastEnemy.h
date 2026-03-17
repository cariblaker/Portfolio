#pragma once

#include "enemy.h"

class FastEnemy : public Enemy {
public:

    FastEnemy(float x, float y) : Enemy(x, y){
        enemy.setFillColor(sf::Color::Cyan);
        x_movement = 300.0;
        enemy.setOrigin(x, y);
    }

};