

#include "enemyGraphicsComponent.h"

    EnemyGraphicsComponent::EnemyGraphicsComponent(){
        texture.loadFromFile("alien.png");
        sprite.setTexture(texture);
        size_x = texture.getSize().x;
        size_y = texture.getSize().y;
    }

    void EnemyGraphicsComponent::update(Entity * entity, Graphics * graphics) {
        sprite.setPosition(entity->x, entity->y);
        graphics->render(sprite);
    }


