#include "seven_segment.h"
static uint8_t arr_display[2]={0,0};
static uint8_t Segments_Code[10] = {0xFE,0x06,0x6D,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
static uint8_t ovf_counter = 0;
static uint8_t disp_counter = 0;
/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegInit(void)
{
    uint8_t ret=E_OK;
    /**intialize timer needed*/
    ret =Timer_Init(&Timer_Configuration1_7_seg);
  //  ret=Timer_Start(TIMER_CH1,100);
        /*init Enable 7 segments */
    ret=DIO_init(&Dio_configutation_A_7_seg);
    ret += sevenSegDisable(SEG_0);
    ret += sevenSegDisable(SEG_1);
    /*7segments leds*/
    ret=DIO_init(&Dio_configutation_D);
    return ret;


}
void seven_seg_POV(void)
{
    if(ovf_counter  > 50){
    PORTD_DATA=ZERO;
    sevenSegEnable(disp_counter);    
    PORTD_DATA = Segments_Code[arr_display[disp_counter]];
ovf_counter=0;
 disp_counter++;
    if(disp_counter == 2)
        disp_counter = 0;
    }
   ovf_counter++;
   
INTCON &= (~TMR0IF);
}
/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegEnable(uint8_t segment_id)
{uint8_t ret=E_OK;
switch(segment_id)
	{
case SEG_0:
ret += sevenSegDisable(SEG_1);
ret +=DIO_Write(GPIOA,BIT2,HIGH);
break;
case SEG_1:
ret += sevenSegDisable(SEG_0);
ret +=DIO_Write(GPIOA,BIT3,HIGH);
break;
}

return ret;

}
/**
 * Description:
 * @param
 */

ERROR_STATUS sevenSegDisable(En_SevenSegId_t en_segment_id)
{

uint8_t ret=E_OK;
switch(en_segment_id)
	{
case SEG_0:
ret +=DIO_Write(GPIOA,BIT2,LOW);
break;
case SEG_1:
ret +=DIO_Write(GPIOA,BIT3,LOW);
break;
}
return ret;

}
/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegWrite( uint8_t u8_number)
{
uint8_t ret=E_OK;
if(u8_number < 99 && u8_number >= 10 ){
 arr_display[0] = (u8_number / 10);
    u8_number%=10;
    arr_display[1] = u8_number;
}else if(u8_number < 10)
{
arr_display[0] = 0;
arr_display[1] = u8_number;
}else{
    ret += E_NOK;
}
 ret=Timer_Start(TIMER_CH0,100);
return ret;
}
