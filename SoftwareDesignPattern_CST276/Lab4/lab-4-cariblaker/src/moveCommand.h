#pragma once

#include "command.h"
#include "entity.h"

class MoveCommand : public Command {
public:

  MoveCommand(sf::Vector2f makeVelocity) : velocity(makeVelocity) {}

  void execute(Entity* entity) override {
    entity->setVelocity(velocity);
  }

private:
  sf::Vector2f velocity;
};
