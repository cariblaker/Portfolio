#pragma once
#include <string>
#include <fstream>
#include <SFML/Graphics.hpp>
#include "rand.h"

class Config{
public:

    static Config& instance()
    {
        static Config instance{};

        return instance;
    }

    unsigned int getWindowWidth()
    {
        return m_window_width;
    };
    
    unsigned int getWindowHeight()
    {
        return m_window_height;
    };

    void setWindowWidth(unsigned int w)
    {
        m_window_width = w;
    };
    
    void setWindowHeight(unsigned int h)
    {
        m_window_height = h;
    };

    void readConfig(const char* fileName)
    {
        std::ifstream f{fileName};
        f >> m_window_width >> m_window_height;
    }

private:

    Config(){};

    ~Config(){};

    unsigned int m_window_width;
    unsigned int m_window_height;

};