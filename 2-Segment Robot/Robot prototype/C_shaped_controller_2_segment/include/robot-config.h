using namespace vex;

extern brain Brain;

using signature = vision::signature;

// VEXcode devices
extern motor Motor1;
extern controller Controller1;
extern motor Motor2;
extern signature Visionsensor__SIG_RED;
extern signature Visionsensor__SIG_BLUE;
extern signature Visionsensor__SIG_DGREEN;
extern signature Visionsensor__SIG_REF;
extern signature Visionsensor__SIG_DBLUE;
extern signature Visionsensor__SIG_GREEN;
extern signature Visionsensor__SIG_7;
extern vision Visionsensor;
extern motor Motor11;
extern motor Motor22;

/**
 * Used to initialize code/tasks/devices added using tools in VEXcode Text.
 * 
 * This should be called at the start of your int main function.
 */
void  vexcodeInit( void );