#pragma once

#include "input.h"
#include "entity.h"
#include "enemyInputComponent.h"

class World;

class AngryInputComponent : public EnemyInputComponent {
public:
    AngryInputComponent(InputComponent * inputComponent);
    void update(Entity * entity, World * world) override;

    InputComponent * enemy;
};


