/* 
 * File:   pushButton.h
 * Author: mo
 *
 * Created on 19 ?????, 2020, 02:31 ?
 */

#ifndef PUSHBUTTON_H
#define	PUSHBUTTON_H

#include "DIO.h"
#include "pushButtonConfig.h"

typedef enum En_buttonId_t{
	BTN_0,
	BTN_1,
	BTN_2
}En_buttonId_t;

typedef enum En_buttonStatus_t{
	Released,
	Pressed,

}En_buttonStatus_t;

/**
 * Description: Initialize the BTN_x Pin state (where x 0, 1, 2, 3) to Input
 * @param btn_id: The btn to be initialized and it takes
 * 				  one of the enum (En_buttonId) parameters
 *
 */
extern void pushButtonInit(En_buttonId_t en_butotn_id);
/**
 * Description: read all BTN_x (where x 0, 1, 2, 3) states and store it in the program
 *
 * @note : this function must be called in the system tick handler or in the super loop handler
 */
void pushButtonUpdate(void);
/**
 * Description: read BTN_x (where x 0, 1, 2, 3) state which is stored in the program
 * 				in the update function
 *
 */
En_buttonStatus_t pushButtonGetStatus(En_buttonId_t en_butotn_id);
/*
for external interrupt
*/
extern void check_button(void);


#endif	/* PUSHBUTTON_H */

