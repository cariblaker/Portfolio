#pragma once
//#include "world.h"
class World;
class Entity;
//class Graphics;

class PhysicsComponent {
public:
  virtual ~PhysicsComponent() {}
  virtual void update(Entity * entity, World * world) = 0;
  virtual void resolveWindowCollisions(Entity * entity, World * world) = 0;
  virtual void resolveEntityCollisions(Entity * entity, World * world) = 0;
};
