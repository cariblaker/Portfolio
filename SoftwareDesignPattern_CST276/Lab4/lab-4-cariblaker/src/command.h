#pragma once

#include <SFML/Graphics.hpp>
#include "ship.h"

class Command {
public:
  virtual ~Command() {}
  virtual void execute(Entity* ship) = 0;
};
