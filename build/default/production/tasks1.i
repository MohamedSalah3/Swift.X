# 1 "tasks1.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.40/packs/Microchip/PIC16Fxxx_DFP/1.2.33/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "tasks1.c" 2
# 1 "./tasks.h" 1
# 11 "./tasks.h"
# 1 "./SOS.h" 1








# 1 "./sosConfig.h" 1
# 11 "./sosConfig.h"
# 1 "./Timer.h" 1
# 11 "./Timer.h"
# 1 "./Timer_Config.h" 1
# 11 "./Timer_Config.h"
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
# 11 "./Timer_Config.h" 2

# 1 "./registers.h" 1
# 12 "./Timer_Config.h" 2

# 1 "./error.h" 1
# 12 "./error.h"
typedef uint8_t ERROR_STATUS;
# 13 "./Timer_Config.h" 2

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
# 14 "./Timer_Config.h" 2






typedef struct Timer_cfg_s
{
 uint8_t Timer_CH_NO;
 uint8_t Timer_Mode;
 uint8_t Timer_Polling_Or_Interrupt;
 uint8_t Timer_Prescaler;
 void (*Timer_Cbk_ptr)(void);
}Timer_cfg_s;
# 122 "./Timer_Config.h"
extern Timer_cfg_s Timer_Configuration0;

extern Timer_cfg_s Timer_Configuration2_SOS;
extern Timer_cfg_s Timer_Configuration1;
extern Timer_cfg_s Timer_Deinit_Configuration0;
extern Timer_cfg_s Timer_Deinit_Configuration1;
extern Timer_cfg_s Timer_Deinit_Configuration2;
# 11 "./Timer.h" 2
# 28 "./Timer.h"
ERROR_STATUS Timer_Init(Timer_cfg_s* Timer_cfg);


void global_int_enable(void);
# 42 "./Timer.h"
ERROR_STATUS Timer_Start(uint8_t Timer_CH_NO, uint16_t Timer_Count);
extern void timer0_interrupt_ovfRoutine(void);
extern void timer1_interrupt_ovfRoutine(void);
extern void timer2_interrupt_ovfRoutine(void);
# 55 "./Timer.h"
ERROR_STATUS Timer_Stop(uint8_t Timer_CH_NO);
# 67 "./Timer.h"
ERROR_STATUS Timer_GetStatus(uint8_t Timer_CH_NO, uint8_t* Data);
# 79 "./Timer.h"
ERROR_STATUS Timer_GetValue(uint8_t Timer_CH_NO, uint16_t* Data);
# 11 "./sosConfig.h" 2


typedef struct TMU_ConfigType{

 uint8_t u8_resolution;
 uint8_t u8_Timer_channel;

}TMU_ConfigType;





extern const TMU_ConfigType TMU_Configuration;
# 9 "./SOS.h" 2



  ERROR_STATUS SOS_Init (const TMU_ConfigType * ConfigPtr );
# 25 "./SOS.h"
 ERROR_STATUS TMU_DeInit( void );






 void TMU_Stop_Timer(uint8_t u8_function_index);




 ERROR_STATUS SOS_Create_Task(ptr_to_Fun Function_Consumer,uint8_t u8_Preodicity,uint8_t u8_function_index,uint16_t u16_Time_delay);
# 49 "./SOS.h"
 ERROR_STATUS SOS_Run(void);



 extern void Task1(void);
 extern void Task2(void);
 extern void Task3(void);

 typedef struct start_status
 { uint8_t u8Started;
  uint8_t function_Index;
 }start_status;

 typedef struct Buffer_Request
 {
  ptr_to_Fun Fuction_consumer;

  uint8_t u8_flag_is_stopped;

  uint16_t u16_time_delay;

  uint8_t preodic;

  uint16_t u16_Counter;
 }Buffer_Request;

void timer_interrupt(void);
# 11 "./tasks.h" 2


# 1 "./ADC.h" 1
# 11 "./ADC.h"
# 1 "./ADC_Config.h" 1
# 10 "./ADC_Config.h"
# 1 "./DIO.h" 1



# 1 "./DIO_Config.h" 1
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
# 13 "./tasks.h" 2

# 1 "./seven_segment.h" 1
# 12 "./seven_segment.h"
void seven_seg_POV (void);
Timer_cfg_s Timer_Configuration1_7_seg =
{
  0,
    0xC2,
    0xA0,
    0,
   seven_seg_POV
};

typedef enum En_SevenSegId_t{
 SEG_0 = 0,
 SEG_1 = 1,
}En_SevenSegId_t;





ERROR_STATUS sevenSegInit(void);





ERROR_STATUS sevenSegEnable(uint8_t segment_id);





ERROR_STATUS sevenSegDisable(En_SevenSegId_t en_segment_id);





ERROR_STATUS sevenSegWrite(uint8_t u8_number);
# 14 "./tasks.h" 2

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
# 15 "./tasks.h" 2

# 1 "./pushButton.h" 1
# 12 "./pushButton.h"
# 1 "./pushButtonConfig.h" 1
# 12 "./pushButton.h" 2


typedef enum En_buttonId_t{
 BTN_0,
 BTN_1,
 BTN_2
}En_buttonId_t;

typedef enum En_buttonStatus_t{
 Released,
 Pressed,

}En_buttonStatus_t;







extern void pushButtonInit(En_buttonId_t en_butotn_id);





void pushButtonUpdate(void);





En_buttonStatus_t pushButtonGetStatus(En_buttonId_t en_butotn_id);



extern void check_button(void);
# 16 "./tasks.h" 2
# 1 "tasks1.c" 2


static uint16_t last_temp_reading =0;
static uint16_t last_Ten_readings[10];

void Task1(void)
{
  static uint8_t u8_Counter1=0;
  static uint8_t u8_Counter=0;

  static uint8_t u8_Counter2=0;
 if (pushButtonGetStatus(BTN_0))
 {
  u8_Counter++;
 }
 if (u8_Counter > 10)
 {

            u8_Counter=0;
 }

 if (pushButtonGetStatus(BTN_1))
 {
  u8_Counter1++;

 }
 if (u8_Counter1 > 10)
 {

  u8_Counter1=0;
 }
        if (pushButtonGetStatus(BTN_2))
 {
  u8_Counter2++;
 }
 if (u8_Counter2 > 10)
 {

            u8_Counter2=0;
 }




}
void Task2(void){


static uint16_t adc_data = 0;
 static uint8_t EE_Address = 0x0020;
 static uint8_t EE_Data = 0;
 static uint8_t readings_counter = 0;
        uint8_t ret = 0 ;

EE_Data=adc_data;


  ret = sevenSegWrite(ADC_READ());
 EEPROM_Write(EE_Address, EE_Data);
last_temp_reading= EEPROM_Read(EE_Address);
last_Ten_readings[readings_counter]=adc_data;
 readings_counter++;


}
void Task3(void){



}
