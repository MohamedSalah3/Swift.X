/*
 * File:   main.c
 * Author: mo
 *
 * Created on 20 ?????, 2020, 06:16 ?
 */
#include "SOS.h"

void system_init(void)
{
uint8_t ret=0;

ret = SOS_Init(&TMU_Configuration);
 ret = SOS_Create_Task(Task1,1,0,1);
ret = SOS_Create_Task(Task2,1,1,50);
ret = SOS_Create_Task(Task3,1,2,2500);

}
void main(void) {
    system_init();
  while(1)
  {    
 SOS_Run();
  }
  return;
}