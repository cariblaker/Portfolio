#pragma once


#include <SFML/Graphics.hpp>
#include "entity.h"
#include "graphics.h"


class BulletGraphicsComponent : public GraphicsComponent {
public:
    BulletGraphicsComponent();
    void update(Entity * entity, Graphics * graphics);
};
