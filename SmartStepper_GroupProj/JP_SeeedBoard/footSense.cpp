#include <Arduino.h>
#include "footSense.hpp"
#include "bleService.hpp"
#include <stack>

int count = 0;

int sensorThreshhold = 150;

int sensors[] = {A2, A3, A4, A5};

unsigned long badTime = 0;

unsigned long goodTime = 0;

unsigned long triggerDuration = 1000;

unsigned long stepBuffer = 250;

//bool latches[] = {false, false, false, false};

//lastTrigger may be depreciated, used triggerStack
unsigned long lastTrigger[] = {0,0,0,0};

std::stack<unsigned long>  triggerStack[4];

int score()
{
  int scr = 0;

  std::stack<unsigned long> bufferStack;

  while (lastTrigger[2] > lastTrigger[3] && !triggerStack[2].empty())
  {
    lastTrigger[2] = triggerStack[2].top();
    triggerStack[2].pop();
  }
  if(lastTrigger[2] <= lastTrigger[3] && lastTrigger[2] != 0 && lastTrigger[2] >= millis() - 3000) { scr++; }
  else if (lastTrigger[2] > lastTrigger[3] || lastTrigger[2] == 0) { lastTrigger[2] = lastTrigger[3]; } // if a sensor is busted, this should compensate

  
  while (lastTrigger[1] > lastTrigger[2] && !triggerStack[1].empty())
  {
    lastTrigger[1] = triggerStack[1].top();
    triggerStack[1].pop();
  }
  if(lastTrigger[1] <= lastTrigger[2] && lastTrigger[1] != 0 && lastTrigger[1] >= millis() - 3000) { scr++; }
  else if (lastTrigger[1] > lastTrigger[2] || lastTrigger[1] == 0) { lastTrigger[1] = lastTrigger[2]; } // if a sensor is busted, this should compensate

  while (lastTrigger[0] > lastTrigger[1] && !triggerStack[0].empty())
  {
    lastTrigger[0] = triggerStack[0].top();
    triggerStack[0].pop();
  }
  if(lastTrigger[0] <= lastTrigger[1] && lastTrigger[0] != 0 && lastTrigger[0] >= millis() - 3000) { scr++; }
  else if (lastTrigger[0] > lastTrigger[1] || lastTrigger[0] == 0) { lastTrigger[0] = lastTrigger[1]; } // if a sensor is busted, this should compensate

  /*
  if(lastTrigger[0] <= lastTrigger[1] && lastTrigger[0] != 0) { scr++; }
  if(lastTrigger[1] <= lastTrigger[2] && lastTrigger[1] != 0) { scr++; }
  if(lastTrigger[2] <= lastTrigger[3] && lastTrigger[2] != 0) { scr++; }
  if(lastTrigger[3] != 0) { scr++; }
  */

  if(!((lastTrigger[0] >= millis()  - 3000 || lastTrigger[0] == 0) && (lastTrigger[1] >= millis() - 3000 || lastTrigger[1] == 0) && (lastTrigger[2] >= millis() - 3000 || lastTrigger[2] == 0)))
  {
    return -1;
    //if any data used was from more than a full second ago, this data is likely bad. Disregard, its probably just them 
    //fidgiting while sitting or something.
  }

  return scr;

}

void cleanTrigger()
{
  lastTrigger[0] = 0;
  lastTrigger[1] = 0;
  lastTrigger[2] = 0;
  lastTrigger[3] = 0;

  for(int idx = 0; idx < sizeof(sensors) / sizeof(sensors[0]); idx++)
  {
    while(!triggerStack[idx].empty())
    {
      triggerStack[idx].pop();
    }
  }
}

void checkGait()
{
  for(int idx = 0; idx < sizeof(sensors) / sizeof(sensors[0]); idx++)  
  {
    if (analogRead(sensors[idx]) > sensorThreshhold)
    {
      //latches[idx] = true;
      lastTrigger[idx] = millis();
      triggerStack[idx].push(millis());
    }
    /*
    else if (sensors[idx] <= 0.5)
    {
      latches[idx] = false;
    }
    */
    //updateLastTriggers(lastTrigger);
  }

    /*

  bool fullGait = true;

  if(lastTrigger[0] == 0) { fullGait = false; }

  for(int idx = 1; idx < (sizeof(sensors) / sizeof(sensors[0]) - 1); idx++)  
  {
    if(lastTrigger[idx] < lastTrigger[idx - 1] || lastTrigger[idx] == 0)
    {
      fullGait = false;
    }
  }

  if (fullGait = true)
  {
    for(int idx = 0; idx < (sizeof(sensors) / sizeof(sensors[0])); idx++)
    {
      lastTrigger[idx] = 0;
    }
  }

  return fullGait;
  */
}

void footSetup()
{
  for(int idx = 0; idx < sizeof(sensors) / sizeof(sensors[0]); idx++)  
  {
    pinMode(sensors[idx], INPUT);
  }

  pinMode(D8, OUTPUT);

  digitalWrite(D8, HIGH); // MOTOR, LOW = ON

  //memset(array, -1, sizeof(array[0][0]) * row * count)
}

void footMain()
{
  
  //Serial.print("A1: " + String(analogRead(sensors[0])) + "    A2: " + String(analogRead(sensors[1])) + "    A3: " + String(analogRead(sensors[2])) + "    A4: " + String(analogRead(sensors[3])) + "\n");

  checkGait();

  Serial.print("A2: " + String(lastTrigger[0]) + "    A3: " + String(lastTrigger[1]) + "    A4: " + String(lastTrigger[2]) + "    A5: " + String(lastTrigger[3]) + "\n");

  if(lastTrigger[3] && badTime < (millis() - stepBuffer) && goodTime < (millis() - stepBuffer))
  {
    int scr = score();
    if(scr >= 3)
    {
      goodTime = millis();
      Serial.print("GOOD STEP\n");
      addGoodStep();
    }
    else if (scr >= 0)
    {
      badTime = millis();
      Serial.print("BAD STEP\n");
      addBadStep();
    }
    else
    {
      //negitive score means disregard data, likely just some fidgiting
    }
    cleanTrigger();
  }
  else if (badTime >= (millis() - stepBuffer) || goodTime >= (millis() - stepBuffer))
  {
    cleanTrigger();
  }



  if ((badTime + triggerDuration) > millis())
  {
      digitalWrite(D8, LOW);
  }
  else
  {
      digitalWrite(D8, HIGH);
  }

  /*
  if ((goodTime + triggerDuration) > millis())
  {
      digitalWrite(A5, HIGH);
  }
  else
  {
      digitalWrite(A5, LOW);
  }
  */

  /*
  if(analogRead(A1) >= 200)
  {
    digitalWrite(LED_BUILTIN,LOW); //LOW turns it ON, for some reason
  }
  else
  {
    digitalWrite(LED_BUILTIN,HIGH);
  }
  */

  count++;
}

