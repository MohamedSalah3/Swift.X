# 1 "ADC.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.40/packs/Microchip/PIC16Fxxx_DFP/1.2.33/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "ADC.c" 2
# 1 "./ADC.h" 1
# 11 "./ADC.h"
# 1 "./ADC_Config.h" 1
# 10 "./ADC_Config.h"
# 1 "./DIO.h" 1



# 1 "./DIO_Config.h" 1
# 10 "./DIO_Config.h"
# 1 "./registers.h" 1
# 10 "./registers.h"
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
# 10 "./registers.h" 2
# 10 "./DIO_Config.h" 2

# 1 "./error.h" 1
# 12 "./error.h"
typedef uint8_t ERROR_STATUS;
# 11 "./DIO_Config.h" 2

# 1 "./interrupts.h" 1
# 31 "./interrupts.h"
typedef void (*ptr_to_Fun)(void);
extern ptr_to_Fun TIMER0OVF_INT;
extern ptr_to_Fun TIMER1OVF_INT ;
extern ptr_to_Fun TIMER2OVF_INT ;
extern ptr_to_Fun ADC_INT ;

void global_int_enable(void);

ERROR_STATUS special_int_disable(uint8_t u8_interrupt_prepherals);
ERROR_STATUS special_int_enable(uint8_t u8_interrupt_prepherals);
ERROR_STATUS read_int_flag(uint8_t u8_interrupt_prepherals ,uint8_t * ptr_to_flag);
ERROR_STATUS clear_int_flag(uint8_t u8_interrupt_prepherals);
void global_int_disable(void);
# 12 "./DIO_Config.h" 2
# 58 "./DIO_Config.h"
typedef struct DIO_Cfg_s{
    uint8_t port;
    uint8_t dir;
    uint8_t pin;
    uint8_t operation_mode;

}DIO_Cfg_s;


extern DIO_Cfg_s Dio_configutation_A;
extern DIO_Cfg_s Dio_configutation_A_7_seg;
extern DIO_Cfg_s Dio_configutation_A_ADC ;
extern DIO_Cfg_s Dio_configutation_B;
extern DIO_Cfg_s Dio_configutation_C;
extern DIO_Cfg_s Dio_configutation_D;
extern DIO_Cfg_s Dio_configutation_E;
# 4 "./DIO.h" 2
# 13 "./DIO.h"
ERROR_STATUS DIO_init (DIO_Cfg_s *DIO_info);
# 42 "./DIO.h"
ERROR_STATUS DIO_Write (uint8_t GPIO, uint8_t pins, uint8_t value);
# 70 "./DIO.h"
ERROR_STATUS DIO_Read (uint8_t GPIO,uint8_t pins, uint8_t *data);
# 95 "./DIO.h"
ERROR_STATUS DIO_Toggle (uint8_t GPIO, uint8_t pins);
# 10 "./ADC_Config.h" 2




typedef struct ADC_Cfg_s{
    uint8_t u8_Channel_Number;
    uint8_t u8_Prescaler;
    uint8_t clock_configuration;
    uint8_t u8_ten_bit_arrangment;
    uint8_t u8_polling_interrupt;

}ADC_Cfg_s;
# 56 "./ADC_Config.h"
extern ADC_Cfg_s ADC_Cnfiguration;
# 11 "./ADC.h" 2

# 1 "./softwareDelay.h" 1
# 16 "./softwareDelay.h"
void SwDelay_ms(uint32_t n);






void SwDelay_us(uint32_t n);
# 12 "./ADC.h" 2





ERROR_STATUS ADC_INIT(ADC_Cfg_s *ADC_info);


uint16_t ADC_READ(void);

void adc_interrupt_routine(void);
# 1 "ADC.c" 2


static uint16_t u16_result_data = 0;
ERROR_STATUS ADC_INIT(ADC_Cfg_s *ADC_info)
{
    uint8_t ret_error=0;

    if((ADC_info -> u8_Prescaler ) <= 3)
    {
        *((reg_type8_t)(0x001F)) |= (ADC_info -> u8_Channel_Number)|(ADC_info -> clock_configuration )|0x01;
        *((reg_type8_t)(0x009F)) &= (~0x40);
        *((reg_type8_t)(0x009F)) |=(ADC_info -> u8_ten_bit_arrangment);
    }else if(((ADC_info -> u8_Prescaler ) > 3 )
            &&((ADC_info -> u8_Prescaler ) <= 7))
  {
         *((reg_type8_t)(0x001F)) |= (ADC_info -> u8_Channel_Number)|(ADC_info -> clock_configuration )|0x01;
      *((reg_type8_t)(0x009F)) |= 0x40 | (ADC_info -> u8_ten_bit_arrangment);

         }else{ret_error += 1 + 30;}

    switch(ADC_info -> u8_polling_interrupt)
    {
    case 0x40:
        ret_error=special_int_enable(0x40);
      ADC_INT = adc_interrupt_routine;
        break;
    case 0xBF:
        special_int_disable(0x40);

    break;

    }


    return ret_error;
}


uint16_t ADC_READ(void)
{
SwDelay_ms(2);

    *((reg_type8_t)(0x001F)) &= 0b11000101;
    *((reg_type8_t)(0x001F)) |= 0x00;

SwDelay_us(30);
*((reg_type8_t)(0x001F)) |=0x04 ;
    while(( (*((reg_type8_t)(0x001F)) >> 0x04) & 1 ));

return ((*((reg_type8_t)(0x001E)) << 8) + *((reg_type8_t)(0x009E)));
}

void adc_interrupt_routine(void)
{
u16_result_data=((*((reg_type8_t)(0x001E))<<8)+*((reg_type8_t)(0x009E)));
*((reg_type8_t)(0x000C)) &= (~0x40);

}
