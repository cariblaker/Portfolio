#pragma once

#include <SFML/Graphics.hpp>
#include <iostream>
#include "enemyPhysicsComponent.h"


class World;
class Entity;


class AngryPhysicsComponent : public EnemyPhysicsComponent {
public:
    AngryPhysicsComponent(EnemyPhysicsComponent * enemy);
    void update(Entity * entity, World * world) override;
    void resolveWindowCollisions(Entity * entity, World * world) override;
    //void resolveEntityCollisions(Entity * entity, World * world) override;

private:
    EnemyPhysicsComponent * component;
};
