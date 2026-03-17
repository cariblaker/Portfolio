#pragma once

#include "entity.h"
#include "graphics.h"
#include "graphics_component.h"

class PlayerGraphicsComponent : public GraphicsComponent {
public:
    PlayerGraphicsComponent();
    void update(Entity * entity, Graphics * graphics) override;
};
