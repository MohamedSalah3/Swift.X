#include "SOS.h"
static uint8_t stu8_increment=0;
static uint16_t last_temp_reading =0;
static uint16_t last_Ten_readings[10];
void Task1(void)
{	/*what happens every 1 ms*/
static uint8_t u8_Counter=0;
static uint8_t u8_Counter1=0;
	if (pushButtonGetStatus(BTN_0))
	{
		u8_Counter++;
	}
	if (u8_Counter > 20)
	{
	stu8_increment++;
	u8_Counter=0;
	}

	if (pushButtonGetStatus(BTN_1))
	{
		u8_Counter1++;
		//stu8_increment++;
	}
	if (u8_Counter1 > 20)
	{
		stu8_increment--;
		u8_Counter1=0;
	}



}
void Task2(void){
/**what happens every 100 ms */
    uint8_t ret = E_OK ;
    static uint16_t adc_data = 0;
     uint8_t EE_Address = 0x0020; // Some Random Address
     uint8_t EE_Data = adc_data ;    // Some Random Data To Write
    static uint8_t readings_counter = 0;
     ret = DIO_init(&Dio_configutation_A_ADC);
    ret = ADC_INIT(&ADC_Cnfiguration);
    ret = sevenSegInit();
     I2C_Master_Init(100000);

/*init task needed**/
    adc_data = ADC_READ();
  ret = sevenSegWrite(adc_data);

  EEPROM_Write(EE_Address, EE_Data); // Write 0x04 @ 0x0020
   last_temp_reading= EEPROM_Read(EE_Address);
   /**/
   last_Ten_readings[readings_counter]=adc_data;
   
   
}
void Task3(void){
/**what happens every 5 seconds*/

    
}

