/*
 * File:   seven_segment.h
 * Author: mo
 *
 * Created on 20 ?????, 2020, 01:27 ?
 */

#ifndef SEVEN_SEGMENT_H
#define	SEVEN_SEGMENT_H
#include "DIO.h"
#include "Timer.h"
void seven_seg_POV (void);
Timer_cfg_s Timer_Configuration1_7_seg =
{
  TIMER_CH0,
    TIMER0_PRESCALER_8_TIMER_MODE,
    TIMER0_INTERRUPT_MODE,
    0,
   seven_seg_POV
};

typedef enum En_SevenSegId_t{
	SEG_0 = 0,
	SEG_1 = 1,
}En_SevenSegId_t;

/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegInit(void);

/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegEnable(uint8_t segment_id);

/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegDisable(En_SevenSegId_t en_segment_id);

/**
 * Description:
 * @param
 */
ERROR_STATUS sevenSegWrite(uint8_t u8_number);








#endif	/* SEVEN_SEGMENT_H */
