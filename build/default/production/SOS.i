# 1 "SOS.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 288 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "C:/Program Files (x86)/Microchip/MPLABX/v5.40/packs/Microchip/PIC16Fxxx_DFP/1.2.33/xc8\\pic\\include\\language_support.h" 1 3
# 2 "<built-in>" 2
# 1 "SOS.c" 2








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
# 9 "SOS.c" 2





uint8_t u8_Init_finished=0;
uint8_t u8_Is_Intialized=0;
start_status start[3];
uint8_t u8_FUN_index=0;
Buffer_Request Buffer_Array[3];
volatile static uint8_t u8Excution_to_be_done=0;

uint8_t Start_status[3];


ERROR_STATUS SOS_Init (const TMU_ConfigType * ConfigPtr )
{uint8_t u8_channel_ID=ConfigPtr->u8_Timer_channel;
uint8_t ret=0;



u8_Is_Intialized++;

if(ConfigPtr==((void *)0)){ret=32 +16;}
switch(u8_channel_ID)
{
 case 0:
   Timer_Init(&Timer_Configuration0);
    break;
 case 2:

  Timer_Init(&Timer_Configuration2_SOS);
                TIMER2OVF_INT = timer_interrupt;
   break;
 default:
   ret+=1;
   break;
}





switch(ConfigPtr->u8_resolution)
{
 case 1:
 {
  switch(u8_channel_ID)
  {
   case 0 :
  Timer_Start(0,250);

     break;
   case 2 :
    Timer_Start(2,250);
     break;
   default:
    ret+=1;
     break;
  }
 break;
 }



 default:
 ret+=1;
 break;

}






return ret;
}



ERROR_STATUS TMU_DeInit( void )
{
 uint8_t ret=0;




if (u8_Is_Intialized==1)
{
 Timer_Init(&Timer_Deinit_Configuration0);

 u8_Is_Intialized=0;

}else if(u8_Is_Intialized>1){ret+=10;}
 else{
 ret=1;
 }


return ret;
}

ERROR_STATUS SOS_Create_Task(ptr_to_Fun Function_Consumer,uint8_t u8_Preodicity,
                             uint8_t u8_function_index,uint16_t u16_Time_delay)
{uint8_t ret=0;
  u8Excution_to_be_done++;





 if(u8_Is_Intialized == 1)
 {

  (Buffer_Array[u8_function_index]).Fuction_consumer=Function_Consumer;
  (Buffer_Array[u8_function_index]).preodic=u8_Preodicity;
  (Buffer_Array[u8_function_index]).u16_time_delay=u16_Time_delay;
  (Buffer_Array[u8_function_index]).u8_flag_is_stopped=1;


 }
 else if(u8_Is_Intialized>1){ret+=10;}else{
  ret+=12;
 }

 return ret;
}

ERROR_STATUS SOS_Run(void)
{
    uint8_t ret=0;
# 149 "SOS.c"
   while(1)
  {
if (u8Excution_to_be_done)
{ u8Excution_to_be_done=0;

  for (u8_FUN_index=0;u8_FUN_index<3;u8_FUN_index++)
   {
# 165 "SOS.c"
                    if((Buffer_Array[u8_FUN_index]).u8_flag_is_stopped==0){ret=0;}
  else{






 ((Buffer_Array[u8_FUN_index]).u16_Counter)++;




 if(((Buffer_Array[u8_FUN_index]).u16_time_delay) == ((Buffer_Array[u8_FUN_index]).u16_Counter) )
 {
  ((Buffer_Array[u8_FUN_index]).Fuction_consumer)();



  (Buffer_Array[u8_FUN_index]).u16_Counter=0;

 }





 if((Buffer_Array[u8_FUN_index]).preodic==0)
 {



  (Buffer_Array[u8_FUN_index]).u8_flag_is_stopped=0;
 }


  }
 }
}
return ret;
}
}

void TMU_Stop_Timer(uint8_t u8_function_index)
{




 (Buffer_Array[u8_function_index]).u8_flag_is_stopped=0;
}



void timer_interrupt(void)
{
u8Excution_to_be_done=1;
*((reg_type8_t)(0x000C)) &= (~0x02);
}
