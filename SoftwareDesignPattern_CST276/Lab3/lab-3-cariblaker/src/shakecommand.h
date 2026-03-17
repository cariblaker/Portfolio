#pragma once

#include "command.h"
#include "entity.h"

class ShakeCommand : public Command {
public:
  virtual void execute(Entity* entity) override {
    entity->shake();
  }
};
