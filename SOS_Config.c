/*
 * TMU_Config.c
 *
 * Created: 24/02/2020 01:23:33 ?
 *  Author: mo
 */

#include "SOS.h"

const TMU_ConfigType TMU_Configuration={
/*
uint8_t u8_resolution;
uint8_t u8_Timer_channel;
*/
TIMER_RESOLUTION_1_MS ,
TIMER_CH2
};


Timer_cfg_s Timer_Configuration2_SOS =
{
  TIMER_CH2,
    TIMER_MODE,
    TIMER2_INTERRUPT_MODE,
    TIMER2_PRESCALER_16,
  timer_interrupt
};