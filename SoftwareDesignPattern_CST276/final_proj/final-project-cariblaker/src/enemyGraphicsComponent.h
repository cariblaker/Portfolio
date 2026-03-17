#pragma once
#include "graphics.h"
#include "entity.h"


class EnemyGraphicsComponent : public GraphicsComponent {
public:

    EnemyGraphicsComponent();

    void update(Entity * entity, Graphics * graphics) override;

};
