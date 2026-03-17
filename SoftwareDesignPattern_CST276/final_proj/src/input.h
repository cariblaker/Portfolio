#pragma once

class World;
class Entity;
//class Graphics;

class InputComponent {
public:
  virtual ~InputComponent() {}
  virtual void update(Entity * entity, World * world) = 0;
};
