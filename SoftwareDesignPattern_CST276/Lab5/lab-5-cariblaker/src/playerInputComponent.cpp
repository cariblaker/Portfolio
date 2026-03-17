

#include <SFML/Graphics.hpp>
#include "playerInputComponent.h"
#include "enemyInputComponent.h"
#include "bulletGraphicsComponent.h"
#include "bulletPhysicsComponent.h"
#include "world.h"

void PlayerInputComponent::update(Entity * entity, World * world) {
    static int timer = 0;
    static int timer2 = 200;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Left)) {
        entity->velocityX = -10;
    } else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Right)) {
        entity->velocityX = 10;
    } else {
        entity->velocityX = 0;
    }

    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Up)) {
        entity->velocityY = -10;
    } else if (sf::Keyboard::isKeyPressed(sf::Keyboard::Down)) {
        entity->velocityY = 10;
    } else {
        entity->velocityY = 0;
    }


    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space)) {
        if (timer == 0){
            Entity * Bullet = new Entity{ 
                new EnemyInputComponent{},
                new BulletPhysicsComponent{}, 
                new BulletGraphicsComponent{}
            };

            Bullet->x = entity->x;
            Bullet->y = entity->y - 100;
            Bullet->velocityX = 0.0f;
            Bullet->velocityY = -10.0f;
            Bullet->type = bullet;
            world->addEntity(Bullet);
        }
        timer++;
        if ( timer > 100)
            timer = 0;
    } 


    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter)){
        if (timer2 > 0){
            entity->x += entity->x;
        }
        timer2--;
        if (timer2 == 0)
            timer2 = 200;
    }


}
