
#include "angryPhysicsComponent.h"
#include "entity.h"
#include "world.h"

AngryPhysicsComponent::AngryPhysicsComponent(EnemyPhysicsComponent * enemy) : component{enemy} {}

void AngryPhysicsComponent::update(Entity * entity, World * world) {
    const float t = 0.01;
    entity->x += entity->velocityX*t;
    entity->y += entity->velocityY*t;
    resolveWindowCollisions(entity, world);
}

void AngryPhysicsComponent::resolveWindowCollisions(Entity * entity, World * world) {
    if (entity->x + entity->graphicsComponent->size_x > world->graphics.window.getSize().x || entity->x < 0.0){   //if colliding with the left/right side of window
        entity->velocityX = -entity->velocityX;
        entity->y += entity->graphicsComponent->size_y;
    }

    if (entity->y + entity->graphicsComponent->size_y > world->graphics.window.getSize().y){            //if colliding with the bottom of the window
        entity->y = 0.0;
        for (auto i : world->entities){
            i->velocityX = i->velocityX * 1.2;                                                            //and increase speed
        }
    }
}

/*void AngryPhysicsComponent::resolveEntityCollisions(Entity * entity, World * world) { }*/
