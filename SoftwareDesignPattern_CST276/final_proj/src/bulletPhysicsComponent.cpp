
#include "bulletPhysicsComponent.h"
#include "entity.h"
#include "world.h"



void BulletPhysicsComponent::update(Entity * entity, World * world) {
    const float t = 0.01;
    entity->x += entity->velocityX*t;
    entity->y += entity->velocityY*t;
    resolveWindowCollisions(entity, world);                             //well, it's not this function
    resolveEntityCollisions(entity, world);
}

void BulletPhysicsComponent::resolveWindowCollisions(Entity * entity, World * world) {
    if (entity->x + entity->graphicsComponent->size_x > world->graphics.window.getSize().x || entity->x < 0.0){   //if colliding with the left/right side of window
        entity->velocityX = -entity->velocityX;
        entity->y += entity->graphicsComponent->size_y;
    }

    if (entity->y + entity->graphicsComponent->size_y > world->graphics.window.getSize().y){            //if colliding with the bottom of the window
        entity->remove = true;
    }
}

void BulletPhysicsComponent::resolveEntityCollisions(Entity * entity, World * world) {
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
                    // bullet gets removed, other entity loses a life
                    entity->remove = true;
                    otherEntity->lives -= 1;
                    if (otherEntity->lives <= 0)
                        otherEntity->remove = true;
                }
            }
        }


}
