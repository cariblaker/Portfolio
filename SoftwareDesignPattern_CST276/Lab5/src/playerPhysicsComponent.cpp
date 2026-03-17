

#include "playerPhysicsComponent.h"
#include "entity.h"
#include "world.h"

void PlayerPhysicsComponent::update(Entity * entity, World * world) {
    const float t = 0.01;
    entity->x += entity->velocityX*t;
    entity->y += entity->velocityY*t;
    resolveWindowCollisions(entity, world);
    resolveEntityCollisions(entity, world);
}

void PlayerPhysicsComponent::resolveWindowCollisions(Entity * entity, World * world) {                      //left/right wrapping, up/down containment
    if (entity->x + entity->graphicsComponent->size_x > world->graphics.window.getSize().x){                //right window bound
        entity->x = 0.0;
    }
    if (entity->x < 0.0){
        entity->x = world->graphics.window.getSize().x - entity->graphicsComponent->size_x;                 //left window bounds
    }

    if (entity->y + entity->graphicsComponent->size_y > world->graphics.window.getSize().y){
        entity->y = world->graphics.window.getSize().y - entity->graphicsComponent->size_y;
        entity->velocityY = 0.0;
    }
    if (entity->y < 0.0){
        entity->y = 0.0;
        entity->velocityY = 0.0;
    }
    /*if (entity->y + entity->graphicsComponent->size_y > world->graphics.window.getSize().y || entity->y < 0.0){
        entity->velocityY = 0.0;
    }*/
}


    void PlayerPhysicsComponent::resolveEntityCollisions(Entity * entity, World * world) {
        // update collider
        entity->collider.left = entity->x;
        entity->collider.top = entity->y;
        entity->collider.width = entity->graphicsComponent->size_x;
        entity->collider.height = entity->graphicsComponent->size_y;

        // check for collisions with other entities
        for (Entity * otherEntity : world->entities) {
            if (otherEntity != entity) {  // skip self
                //update other entity's collider
                otherEntity->collider.left = otherEntity->x;
                otherEntity->collider.top = otherEntity->y;
                otherEntity->collider.width = otherEntity->graphicsComponent->size_x;
                otherEntity->collider.height = otherEntity->graphicsComponent->size_y;

                if (entity->collider.intersects(otherEntity->collider)) {
                    // handle collision between this enemy and otherEntity
                    entity->lives -= 1;
                    if (entity->lives <= 0)
                        entity->remove = true;
                    otherEntity->lives -= 1;
                    if (otherEntity->lives <= 0)
                        otherEntity->remove = true;
                }
            }
        }

    }
