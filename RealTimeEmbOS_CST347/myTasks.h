/*
 * myTasks.h
 *
 * Created: 1/25/2024 10:28:56 AM
 *  Author: Cari Blaker
 * Modified:
 * 3/8/24 removed extraneous tasks and handles.
 * 3/14/24 added ButtonTask()
 */ 


#ifndef MYTASKS_H_
#define MYTASKS_H_

#include <string.h>

//external globals
extern QueueHandle_t LedQ;
extern QueueHandle_t TXQ;
extern QueueHandle_t RXQ;

void ledTask(void * pvParameters);
void TXTask(void * pvParameters);
void RXTask(void * pvParameters);
void ButtonTask(void *pvParameters);

#endif /* MYTASKS_H_ */
