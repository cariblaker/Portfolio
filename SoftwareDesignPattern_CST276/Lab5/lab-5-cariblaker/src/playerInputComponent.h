#pragma once

#include "input.h"
#include "entity.h"

class World;

class PlayerInputComponent : public InputComponent {
public:
  void update(Entity * entity, World * world);
};
