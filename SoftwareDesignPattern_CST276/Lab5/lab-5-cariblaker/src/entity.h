#pragma once

class World;
class Graphics;

#include "graphics_component.h"
#include "input.h"
#include "physics.h"


enum EntityType {
    player,
    enemy,
    bullet
};


class Entity{
public:
    float velocityX{};
    float velocityY{};
    float x{};
    float y{};
    bool remove{false};
    int lives{1};
    sf::FloatRect collider;
    EntityType type{};

    Entity(InputComponent * inputComponent,
            PhysicsComponent * physicsComponent,
            GraphicsComponent * graphicsComponent)
    : inputComponent{inputComponent},
        physicsComponent{physicsComponent},
        graphicsComponent{graphicsComponent}
    {}

    void update(World * world, Graphics * graphics) {
        inputComponent->update(this, world);
        physicsComponent->update(this, world);
        graphicsComponent->update(this, graphics);
    }



//private:
    InputComponent * inputComponent;
    PhysicsComponent * physicsComponent;
    GraphicsComponent * graphicsComponent;
};
