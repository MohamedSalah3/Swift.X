#include "LM35.h"



ERROR_STATUS Temp_sensor_init(void)
{
    uint8_t ret = E_OK;
ret = DIO_init(&Dio_configutation_A_ADC);

ret = ADC_INIT(&ADC_Cnfiguration);
return ret;
}


void Temp_sensor_read(uint16_t *temp_readings)
{
*temp_readings = ADC_READ();
*temp_readings /= 2;
}
