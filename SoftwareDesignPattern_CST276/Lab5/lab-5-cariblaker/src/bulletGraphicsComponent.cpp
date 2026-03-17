
#include <SFML/Graphics.hpp>
#include "bulletGraphicsComponent.h"
#include "entity.h"
#include "graphics.h"

BulletGraphicsComponent::BulletGraphicsComponent(){     //commented out both components for bullet---it's not the components
    texture.loadFromFile("flame.jpeg");
    sprite.setTexture(texture);
    size_x = texture.getSize().x;
    size_y = texture.getSize().y;
}

void BulletGraphicsComponent::update(Entity * entity, Graphics * graphics) {
    sprite.setPosition(entity->x, entity->y);
    graphics->render(sprite);
}
