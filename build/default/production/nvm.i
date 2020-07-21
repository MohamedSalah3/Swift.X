# 1 "nvm.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.40/packs/Microchip/PIC16Fxxx_DFP/1.2.33/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "nvm.c" 2
# 1 "./nvm.h" 1
# 10 "./nvm.h"
# 1 "./i2c_EEPROM.h" 1
# 13 "./i2c_EEPROM.h"
void I2C_Master_Init(const unsigned long baud);
void I2C_Master_Wait();
void I2C_Master_Start();
void I2C_Master_RepeatedStart();
void I2C_Master_Stop();
void I2C_ACK();
void I2C_NACK();
unsigned char I2C_Master_Write(unsigned char);
unsigned char I2C_Read_Byte(void);

void EEPROM_Write(unsigned int add, unsigned char data);
void EEPROM_Write_Page(unsigned int add, unsigned char* data, unsigned char len);
unsigned char EEPROM_Read(unsigned int add);
void EEPROM_Read_Page(unsigned int add, unsigned char* data, unsigned int len);
# 10 "./nvm.h" 2

# 1 "./std_types.h" 1
# 16 "./std_types.h"
typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;
typedef signed char sint8_t;
typedef signed int sint16_t;
typedef signed long int sint32_t;
typedef signed long long sint64_t;
typedef volatile uint8_t* const reg_type8_t;
typedef volatile uint16_t* const reg_type16_t;
# 11 "./nvm.h" 2

# 1 "./error.h" 1
# 12 "./error.h"
typedef uint8_t ERROR_STATUS;
# 12 "./nvm.h" 2


ERROR_STATUS nvm_Write(uint8_t u8_data,uint16_t u16_address);

ERROR_STATUS nvm_Read(uint8_t *u8_data,uint16_t u16_address);
# 1 "nvm.c" 2


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
