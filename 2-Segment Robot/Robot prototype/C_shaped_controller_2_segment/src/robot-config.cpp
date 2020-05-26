#include "vex.h"

using namespace vex;
using signature = vision::signature;
using code = vision::code;

// A global instance of brain used for printing to the V5 Brain screen
brain  Brain;

// VEXcode device constructors
motor Motor1 = motor(PORT1, ratio18_1, false);
controller Controller1 = controller(primary);
motor Motor2 = motor(PORT11, ratio18_1, false);
/*vex-vision-config:begin*/
signature Visionsensor__SIG_RED = signature (1, 10095, 10741, 10418, -717, -357, -538, 6.9, 0);
signature Visionsensor__SIG_BLUE = signature (2, -969, -811, -890, -3527, -3347, -3436, 7.1, 0);
signature Visionsensor__SIG_DGREEN = signature (3, -5649, -5361, -5505, 411, 815, 613, 7, 0);
signature Visionsensor__SIG_REF = signature (4, 0, 0, 0, 0, 0, 0, 3, 0);
signature Visionsensor__SIG_DBLUE = signature (5, -2801, -2457, -2629, 17073, 18079, 17576, 7.4, 0);
signature Visionsensor__SIG_GREEN = signature (6, -5227, -5041, -5134, -3303, -3125, -3214, 6.8, 0);
signature Visionsensor__SIG_7 = signature (7, 0, 0, 0, 0, 0, 0, 3, 0);
vision Visionsensor = vision (PORT5, 38, Visionsensor__SIG_RED, Visionsensor__SIG_BLUE, Visionsensor__SIG_DGREEN, Visionsensor__SIG_REF, Visionsensor__SIG_DBLUE, Visionsensor__SIG_GREEN, Visionsensor__SIG_7);
/*vex-vision-config:end*/
motor Motor11 = motor(PORT2, ratio18_1, false);
motor Motor22 = motor(PORT12, ratio18_1, false);

// VEXcode generated functions
// define variable for remote controller enable/disable
bool RemoteControlCodeEnabled = true;

/**
 * Used to initialize code/tasks/devices added using tools in VEXcode Text.
 * 
 * This should be called at the start of your int main function.
 */
void vexcodeInit( void ) {
  // nothing to initialize
}