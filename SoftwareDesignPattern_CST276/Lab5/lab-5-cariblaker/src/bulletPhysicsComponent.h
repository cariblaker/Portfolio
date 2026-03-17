#pragma once

#include <SFML/Graphics.hpp>
#include <iostream>
#include "physics.h"


class World;
class Entity;


class BulletPhysicsComponent : public PhysicsComponent {
public:

    void update(Entity * entity, World * world) override;
    void resolveWindowCollisions(Entity * entity, World * world) override;
    void resolveEntityCollisions(Entity * entity, World * world) override;
};



