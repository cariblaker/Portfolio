#pragma once

#include <memory>
#include <vector>
#include "Enemy.h"
#include "rand.h"
#include "FastEnemy.h"
#include "WeirdEnemy.h"


class EnemyFactory {
public:

    static Entity* makeEnemy(float x, float y)                                          //creates one randomly generated enemy type
    {
        srand(time(0));
        float random{rand(0, 10)};
        if (random == 1 || random == 10)
            return new FastEnemy{x, y};
        else if (random == 2 || random == 6 || random == 8)
            return new WeirdEnemy{x, y};
        else
            return new Enemy{x, y};
    }

    static std::vector<Entity *> makeEnemies(size_t amount = 20)         //creates either 20 or a specified number of standard enemies 
    {
        static std::vector<Entity *> enemies;
       
        for (size_t i{}; i < amount; ++i) {
            Entity* enemy = new Enemy(i*50 + 5, 0);
            enemies.push_back(enemy);
        }

        return enemies;
    }

    static std::vector<Entity *> makeSomeEnemies()                   //creates between 5 and 100 random enemies... randomly
    {
        std::vector<Entity *> enemies;
        srand(time(0));
        float random{rand(5, 100)};
        for (size_t i{}; i < random; ++i) 
        {
            enemies.push_back(EnemyFactory::makeEnemy(i*50, 0));
        }

        return enemies;
    }
    
};
