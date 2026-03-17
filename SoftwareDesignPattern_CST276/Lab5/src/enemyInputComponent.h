#pragma once

class Entity;
class World;

class EnemyInputComponent : public InputComponent {
public:
  virtual void update(Entity * entity, World * world) override { }
};
