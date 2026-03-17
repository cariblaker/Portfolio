#pragma once

#include "enemy.h"
#include "rand.h"

class WeirdEnemy : public Enemy {
public:

    WeirdEnemy(float x, float y) : Enemy(x, y){
        srand(time(0));
        float random1{ rand(20.0f, 100.0f)};
        float random2{ rand(20.0f, 100.0f)};
        float random3{ rand(20.0f, 100.0f)};

        enemy.setFillColor(sf::Color(random1, random2, random3));
        enemy.setOrigin(x+random1, y+random2);
        x_movement = random3;
    }

};