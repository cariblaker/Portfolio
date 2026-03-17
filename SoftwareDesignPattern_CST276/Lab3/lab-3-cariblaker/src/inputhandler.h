#pragma once

#include <SFML/Graphics.hpp>
#include "command.h"
#include "moveCommand.h"

class InputHandler {
public:
    Command * handleInput(const sf::Event & event) {
        if (event.type == sf::Event::KeyPressed) {
            if (event.key.code == sf::Keyboard::Space) {
                return spaceBarCommand;
            }

            if (event.key.code == sf::Keyboard::Right) {
                moveCommand = new MoveCommand(sf::Vector2f(50.0f, 0.0f));
                return moveCommand;
            }

            if (event.key.code == sf::Keyboard::Left) {
                moveCommand = new MoveCommand(sf::Vector2f(-50.0f, 0.0f));
                return moveCommand;
            }

            if (event.key.code == sf::Keyboard::Up) {
                moveCommand = new MoveCommand(sf::Vector2f(0.0f, -50.0f));
                return moveCommand;
            }

            if (event.key.code == sf::Keyboard::Down) {
                moveCommand = new MoveCommand(sf::Vector2f(0.0f, 50.0f));
                return moveCommand;
            }
        }

        return nullptr;
    }

    void setSpaceBarHandler(Command * command) {
        spaceBarCommand = command;
    }

    void setMoveHandler(Command * command){
        moveCommand = command;
    }

private:
  Command * spaceBarCommand{};
  Command * moveCommand{};
};