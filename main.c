/*
 * File:   main.c
 * Author: mo
 *
 * Created on 20 ?????, 2020, 06:16 ?
 */
#include "tasks.h"
static uint8_t ret=0;

void system_init(void)
{
ret = Timer_Init(&Timer_Configuration0); 
ret= Timer_Start(TIMER_CH0,100);
ret = SOS_Init(&TMU_Configuration);
ret = SOS_Create_Task(Task1,1,0,1);
ret = SOS_Create_Task(Task2,1,1,50);
ret = SOS_Create_Task(Task3,1,2,2500);
ret = DIO_init(&Dio_configutation_C);
ret = DIO_init(&Dio_configutation_A_ADC);
ret = ADC_INIT(&ADC_Cnfiguration);
ret = sevenSegInit();
 I2C_Master_Init(100000);
}
void main(void) {
    system_init();
  while(1)
  {    
 SOS_Run();
  }
  return;
}