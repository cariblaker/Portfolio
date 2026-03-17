

#include <SFML/Graphics.hpp>
#include "playerGraphicsComponent.h"
#include "entity.h"
#include "graphics.h"

PlayerGraphicsComponent::PlayerGraphicsComponent(){
    texture.loadFromFile("sailboat.png");
    sprite.setTexture(texture);
    size_x = texture.getSize().x;
    size_y = texture.getSize().y;
}

void PlayerGraphicsComponent::update(Entity * entity, Graphics * graphics) {
    sprite.setPosition(entity->x, entity->y);
    graphics->render(sprite);
}

