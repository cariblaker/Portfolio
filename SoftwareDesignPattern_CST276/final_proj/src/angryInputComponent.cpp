
#include "angryInputComponent.h"
#include "entity.h"
#include "world.h"

AngryInputComponent::AngryInputComponent(InputComponent * inputComponent) : enemy{inputComponent} {}

void AngryInputComponent::update(Entity * entity, World * world){
    static int timer = 200;
    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Space)) {
        entity->velocityX = -entity->velocityX;
    }

    if (sf::Keyboard::isKeyPressed(sf::Keyboard::Enter)){
        if (timer > 0){
            entity->velocityY = -2;
        }
        timer--;
        if (timer == 0)
            timer = 200;
    }



    enemy->update(entity, world);
  }




