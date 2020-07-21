#include "tasks.h"

static uint16_t last_temp_reading =0;
static uint16_t last_Ten_readings[10];

void Task1(void)
{	/*what happens every 1 ms*/
  static uint8_t u8_Counter1=0;
  static uint8_t u8_Counter=0;

  static uint8_t u8_Counter2=0;
	if (pushButtonGetStatus(BTN_0))
	{	
		u8_Counter++;
	}
	if (u8_Counter > 10)
	{
            /*ON*/
            u8_Counter=0;
	}
	
	if (pushButtonGetStatus(BTN_1))
	{
		u8_Counter1++;
		//stu8_increment++;
	}
	if (u8_Counter1 > 10)
	{
            /*++*/
		u8_Counter1=0;
	}
        if (pushButtonGetStatus(BTN_2))
	{	
		u8_Counter2++;
	}
	if (u8_Counter2 > 10)
	{
          /*--*/
            u8_Counter2=0;
	}
	

	

}
void Task2(void){
/**what happens every 100 ms */
  
static uint16_t adc_data = 0;
	static uint8_t EE_Address = 0x0020; // Some Random Address
	static uint8_t EE_Data = 0;    // Some Random Data To Write
	static uint8_t readings_counter = 0;
        uint8_t ret = 0 ;

EE_Data=adc_data;
/*init task needed**/
 //  adc_data = ADC_READ();
  ret = sevenSegWrite(ADC_READ());
 EEPROM_Write(EE_Address, EE_Data); // Write 0x04 @ 0x0020
last_temp_reading= EEPROM_Read(EE_Address);
last_Ten_readings[readings_counter]=adc_data;
 readings_counter++;
/*
*/
}
void Task3(void){
/**what happens every 5 seconds*/

    
}  


