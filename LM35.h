/* 
 * File:   LM35.h
 * Author: mo
 *
 * Created on 21 ?????, 2020, 01:54 ?
 */

#ifndef LM35_H
#define	LM35_H
#include "ADC.h"

ERROR_STATUS Temp_sensor_init(void);

void Temp_sensor_read(uint16_t *temp_readings);

#endif	/* LM35_H */

