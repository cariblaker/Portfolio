#pragma once

//#include "entity.h"
//#include "world.h"
#include "physics.h"
class Entity;
class World;

class PlayerPhysicsComponent : public PhysicsComponent {
public:
    void update(Entity * entity, World * world) override;
    void resolveWindowCollisions(Entity * entity, World * world) override;
    void resolveEntityCollisions(Entity * entity, World * world) override;
};
