# 1 "seven_segment.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.40/packs/Microchip/PIC16Fxxx_DFP/1.2.33/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "seven_segment.c" 2
# 1 "./seven_segment.h" 1
# 10 "./seven_segment.h"
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
# 10 "./seven_segment.h" 2

# 1 "./Timer.h" 1
# 11 "./Timer.h"
# 1 "./Timer_Config.h" 1
# 20 "./Timer_Config.h"
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
# 11 "./seven_segment.h" 2

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
# 1 "seven_segment.c" 2

static uint8_t arr_display[2]={0,0};
static uint8_t Segments_Code[10] = {0xFE,0x06,0x6D,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F};
static uint8_t ovf_counter = 0;
static uint8_t disp_counter = 0;




ERROR_STATUS sevenSegInit(void)
{
    uint8_t ret=0;

    ret =Timer_Init(&Timer_Configuration1_7_seg);


    ret=DIO_init(&Dio_configutation_A_7_seg);
    ret += sevenSegDisable(SEG_0);
    ret += sevenSegDisable(SEG_1);

    ret=DIO_init(&Dio_configutation_D);
    return ret;


}
void seven_seg_POV(void)
{
    if(ovf_counter > 50){
    *((reg_type8_t)(0x0008))=0x00;
    sevenSegEnable(disp_counter);
    *((reg_type8_t)(0x0008)) = Segments_Code[arr_display[disp_counter]];
ovf_counter=0;
 disp_counter++;
    if(disp_counter == 2)
        disp_counter = 0;
    }
   ovf_counter++;

*((reg_type8_t)(0x000B)) &= (~0x04);
}




ERROR_STATUS sevenSegEnable(uint8_t segment_id)
{uint8_t ret=0;
switch(segment_id)
 {
case SEG_0:
ret += sevenSegDisable(SEG_1);
ret +=DIO_Write(0,0x04,0xFF);
break;
case SEG_1:
ret += sevenSegDisable(SEG_0);
ret +=DIO_Write(0,0x08,0xFF);
break;
}

return ret;

}





ERROR_STATUS sevenSegDisable(En_SevenSegId_t en_segment_id)
{

uint8_t ret=0;
switch(en_segment_id)
 {
case SEG_0:
ret +=DIO_Write(0,0x04,0);
break;
case SEG_1:
ret +=DIO_Write(0,0x08,0);
break;
}
return ret;

}




ERROR_STATUS sevenSegWrite( uint8_t u8_number)
{
uint8_t ret=0;
if(u8_number < 99 && u8_number >= 10 ){
 arr_display[0] = (u8_number / 10);
    u8_number%=10;
    arr_display[1] = u8_number;
}else if(u8_number < 10)
{
arr_display[0] = 0;
arr_display[1] = u8_number;
}else{
    ret += 1;
}
 ret=Timer_Start(0,100);
return ret;
}
