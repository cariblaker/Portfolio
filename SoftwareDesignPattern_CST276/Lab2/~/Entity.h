
#pragma once
#include <SFML/Graphics.hpp>

class Entity {
public:
    virtual void render(sf::RenderWindow & window) = 0;
    virtual void update(float dt) = 0;

    int get_x() {
        return x;
    }

    int get_y() {
        return y;
    }

    void set_x(int x_pos) {
        x = x_pos;
    }

    void set_y(int y_pos) {
        y = y_pos;
    }
    
protected:
    int x{};
    int y{};

};
