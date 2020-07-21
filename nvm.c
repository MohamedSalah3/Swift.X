#include "nvm.h"

ERROR_STATUS nvm_Write(uint8_t u8_data,uint16_t u16_address)
{uint8_t ret_error = 0;
 I2C_Master_Init(100000);
 EEPROM_Write(u16_address, u8_data);
  return ret_error;
}


ERROR_STATUS nvm_Read(uint8_t *u8_data,uint16_t u16_address)
{
 uint8_t ret_error = 0;
 *u8_data=EEPROM_Read(u16_address);
  return ret_error;
}