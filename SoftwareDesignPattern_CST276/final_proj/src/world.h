#pragma once

#include <vector>
#include "angryInputComponent.h"
#include "angryPhysicsComponent.h"
#include "graphics.h"
#include "graphics_component.h"
#include "enemyPhysicsComponent.h"
#include "enemyGraphicsComponent.h"
#include "enemyInputComponent.h"
#include "entity.h"
#include "playerGraphicsComponent.h"
#include "playerInputComponent.h"
#include "playerPhysicsComponent.h"
#include "physics.h"



class World {
public:
    Graphics graphics;
    std::vector<Entity *> entities;


    World() {
        entities.push_back(createPlayer());
        std::vector<Entity *> enemies{createEnemies(10)};
        for (auto & i : enemies){
            entities.push_back(i);
        }
    }

    ~World() {
        for (auto & entity : entities) {
        delete entity;
        }
    }



    void gameLoop() {
        while (graphics.window.isOpen()) {
            processGlobalEvents();

            graphics.window.clear();
            for (size_t i{}, len{entities.size()}; i < len; ++i) {
                entities[i]->update(this, &graphics);
            }

            graphics.window.display();

            bool playerLost = false;
            int numEnemies = 0;
            for (auto& entity : entities) {
                if (entity->type == EntityType::enemy)
                    numEnemies++;
                if (entity->type == EntityType::player && entity->lives <= 0) {
                    playerLost = true;
                    break;
                }
            }

            // If the player has run out of lives, show the game over screen and exit the game loop
            if (playerLost || numEnemies == 0) {
                gameOverScreen();
                break;
            }

            std::erase_if(entities, [](auto & entity) {
                return entity->remove || entity->lives <= 0;
            });
        }
    }

    void run() {
        startScreen();

        while (graphics.window.isOpen()) {
            gameLoop();

            // Reset the game state
            entities.clear();
            entities.push_back(createPlayer());
            std::vector<Entity *> enemies{createEnemies(10)};
            for (auto & i : enemies){
                entities.push_back(i);
            }
        }
    }



Entity * createEnemy() {
    Entity* Enemy = new Entity(
        new EnemyInputComponent{},
        new EnemyPhysicsComponent{},
        new EnemyGraphicsComponent{}
    );
    Enemy->type = enemy;
    return Enemy;
}

Entity * createAngryEnemy() {
    Entity * angryEnemy = new Entity(
        new AngryInputComponent{new EnemyInputComponent{}},
        new AngryPhysicsComponent{new EnemyPhysicsComponent{}},
        new EnemyGraphicsComponent{}
    );
    angryEnemy->type = enemy;
    angryEnemy->lives = 3;
    angryEnemy->velocityX = 15.0f;
    entities.push_back(angryEnemy);
    return angryEnemy;
}


std::vector<Entity *> createEnemies(size_t amount = 15) {
    std::vector<Entity *> enemies;

    float x_{0.0};
    float y_{0.0};
    float direction = 1.0;

    for (size_t i{}; i < amount; ++i) {
        Entity* enemy = createEnemy();
        enemy->x = x_;
        enemy->y = y_;

        if (enemy->x + enemy->graphicsComponent->size_x > graphics.window.getSize().x || enemy->x < 0.0) {
            y_ += enemy->graphicsComponent->size_y;                 //if we've hit window bounds, fix the stored y for next loop
            direction = -direction;                                 //flip the direction for velocity's later use
            enemy->y = y_;                                          //fix the current enemy's y to the fixed y
            if (direction > 0)                                      
                enemy->x = 0;                                       //fix the current enemy's x to be back in bounds
            else
                enemy->x -= graphics.window.getSize().x - enemy->graphicsComponent->size_x;
        }
        if (direction > 0)
            x_ += enemy->graphicsComponent->size_x;
        else
            x_ -= enemy->graphicsComponent->size_x;

        enemy->velocityX = 5.0 * direction;

        enemies.push_back(enemy);
    }

    return enemies;
}


    void addEntity(Entity * entity){
        entities.push_back(entity);
        //eventManager.addListener(entity);
    }

    void addEntities(const std::vector<Entity *> &entities){
        for (auto entity : entities){
            addEntity(entity);
        }
    }


private:
    void processGlobalEvents() {
        sf::Event event;
        while (graphics.window.pollEvent(event)) {
            if (event.type == sf::Event::Closed) {
                graphics.window.close();
                break;
            }
        }
    }


    Entity * createPlayer() {
        Entity * Player = new Entity(
            new PlayerInputComponent{},
            new PlayerPhysicsComponent{},
            new PlayerGraphicsComponent{}
        );
        Player->lives = 3;
        Player->type = player;
        Player->x = ((graphics.window.getSize().x / 2) - (Player->graphicsComponent->size_x / 2));
        Player->y = (graphics.window.getSize().y - Player->graphicsComponent->size_y);
        return Player;
    }


    void startScreen() {
        sf::Font font;
        if (!font.loadFromFile("Ubuntu-Regular.ttf")) {
            std::cerr << "Error: Failed to load font" << std::endl;
            return;
        }

        sf::Text title("SPACE PIRATES", font, 50);
        title.setFillColor(sf::Color::Green);
        title.setPosition(200, 200);

        sf::Text prompt("Press SPACE to start", font, 30);
        prompt.setFillColor(sf::Color::Green);
        prompt.setPosition(280, 350);

        graphics.window.clear();
        graphics.window.draw(title);
        graphics.window.draw(prompt);
        graphics.window.display();

        bool started = false;
        while (!started) {
            sf::Event event;
            while (graphics.window.pollEvent(event)) {
                if (event.type == sf::Event::Closed) {
                    graphics.window.close();
                    return;
                }
                if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Space) {
                    started = true;
                    break;
                }
            }
        }
    }



    void gameOverScreen() {
        sf::Font font;
        if (!font.loadFromFile("Ubuntu-Regular.ttf")) {
            std::cerr << "Error: Failed to load font" << std::endl;
            return;
        }

        sf::Text gameOver("GAME OVER", font, 50);
        gameOver.setFillColor(sf::Color::Green);
        gameOver.setPosition(280, 200);

        sf::Text prompt("Press SPACE to play again", font, 30);
        prompt.setFillColor(sf::Color::Green);
        prompt.setPosition(260, 350);

        graphics.window.clear();
        graphics.window.draw(gameOver);
        graphics.window.draw(prompt);
        graphics.window.display();

        bool replay = false;
        while (!replay) {
            sf::Event event;
            while (graphics.window.pollEvent(event)) {
                if (event.type == sf::Event::Closed) {
                    graphics.window.close();
                    return;
                }
                if (event.type == sf::Event::KeyPressed && event.key.code == sf::Keyboard::Space) {
                    replay = true;
                    break;
                }
            }
        }

        // reset the game
        entities.clear();
        entities.push_back(createPlayer());
        std::vector<Entity *> enemies{createEnemies(10)};
        for (auto & i : enemies){
            entities.push_back(i);
        }
    }



};
