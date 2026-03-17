#pragma once

#include <SFML/Graphics.hpp>
#include <vector>
#include "enemyFactory.h"
#include "entity.h"
#include "command.h"
#include "inputhandler.h"
#include "shakecommand.h"
#include "moveCommand.h"


class World{
public:
    World(unsigned int width = 800, unsigned int height = 1000) : window{sf::VideoMode{width, height}, "Lab3"} { 
        spaceBarHandler = new ShakeCommand{};
        inputHandler.setSpaceBarHandler(spaceBarHandler);
        moveHandler = new MoveCommand{sf::Vector2f(0.0f, 0.0f)};
        inputHandler.setMoveHandler(moveHandler);

    }

    ~World(){
        delete spaceBarHandler;
        delete moveHandler;
        for (auto entity : entities){
            delete entity;
        }
    }

    void setActor(Entity* actress){
        actor = actress;
    }

    void run(){
        sf::Clock clock;

        sf::Time t{sf::Time::Zero}; // time
        sf::Time dt{sf::seconds(1.0f / 60.0f)}; // delta time (fixed to 60fps)

        while (window.isOpen()) {
            processEvents();
            t += clock.restart();

            while (t > dt) {
                t -= dt;
                processEvents();
                update(dt);
            }   

            render();
  
        }
    }

    void addEntity(Entity* entity){
        entities.push_back(entity);
    }

    void addEntities(const std::vector<Entity*> &entities){
        for (auto entity : entities){
            addEntity(entity);
        }
    }


private:
    void render() {
        // always clear!
        window.clear();

        // drawing happens here (off-screen)
        for (auto & entity : entities) {
            entity->render(window);
        }

        // swap the display buffer (double-buffering)
        window.display();
    }

    void processEvents() {
        sf::Event event;
        while (window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                window.close();
                break;
            }

            Command * cmd = inputHandler.handleInput(event);
            if (cmd) {
                cmd->execute(actor);
            }
        }
    }

    void update(sf::Time dt) {
        float s{dt.asSeconds()};

        for (auto & entity : entities) {
            entity->update(s);
        }
    }

    std::vector<Entity *> entities{};
    sf::RenderWindow window{};
    InputHandler inputHandler{};
    Command* spaceBarHandler{};
    Command* moveHandler{};
    Entity* actor{};

};
