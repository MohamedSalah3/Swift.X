#include "pushButton.h"

 #include "pushButtonConfig.h"
 /*
#define BTN_0_GPIO	GPIOB
#define BTN_0_BIT	BIT1

#define BTN_0_GPIO	GPIOB
#define BTN_1_BIT	BIT2

#define BTN_0_GPIO	GPIOB
#define BTN_2_BIT	BIT3

#define BTN_0_GPIO 	GPIOB
#define BTN_3_BIT	BIT4
BTN_0,
	BTN_1,
	BTN_2,
	BTN_3
*/


En_buttonStatus_t pushButtonGetStatus(En_buttonId_t en_butotn_id)
{uint8_t pushreturn = 0;
	static uint8_t u8_Button_press[3];
static uint8_t u8_S_button_status[3];
switch(en_butotn_id)
{
case BTN_0:
{
    DIO_Read(BTN_0_GPIO,BTN_0_BIT,&(u8_Button_press[0]));
if( u8_Button_press[0]== Pressed)
{ 
	(u8_S_button_status[0])++;
	/************************************************************************/
	/*         Debouncing Using Counting Algorithm			                */
	/************************************************************************/
	if( (u8_S_button_status[0]) > 10)
	pushreturn = Pressed;
	else {pushreturn = Released;}
}else{pushreturn = Released;}
break;
}
case BTN_1:
{
    DIO_Read(BTN_1_GPIO,BTN_1_BIT,&(u8_Button_press[1]));
if( u8_Button_press[1] == Pressed)
{
	(u8_S_button_status[0])++;
	/******************************6******************************************/
	/*         Debouncing Using Counting Algorithm			                */
	/************************************************************************/
	if( (u8_S_button_status[0]) > 10)
return Pressed;
	else {pushreturn = Released;}
}else{pushreturn = Released;}
break;
}
case BTN_2:
{
    DIO_Read(BTN_2_GPIO,BTN_2_BIT,&(u8_Button_press[2]));
if((u8_Button_press[2])== Pressed)
{	(u8_S_button_status[1])++;
	/************************************************************************/
	/*         Debouncing Using Counting Algorithm			                */
	/************************************************************************/
	if( (u8_S_button_status[1]) > 10)
	pushreturn = Pressed;
else {pushreturn = Released;}
}else{pushreturn = Released;}
break;
}



	}

return pushreturn ;
}