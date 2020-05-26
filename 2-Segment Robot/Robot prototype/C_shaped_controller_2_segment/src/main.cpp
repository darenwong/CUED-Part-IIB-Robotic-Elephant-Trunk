/*----------------------------------------------------------------------------*/
/*                                                                            */
/*    Module:       main.cpp                                                  */
/*    Author:       C:\Users\gic27                                            */
/*    Created:      Wed Nov 27 2019                                           */
/*    Description:  V5 project                                                */
/*                                                                            */
/*----------------------------------------------------------------------------*/

// ---- START VEXCODE CONFIGURED DEVICES ----
// Robot Configuration:
// [Name]               [Type]        [Port(s)]
// Motor1               motor         1               
// Controller1          controller                    
// Motor2               motor         11              
// Visionsensor         vision        5               
// Motor11              motor         2               
// Motor22              motor         12              
// ---- END VEXCODE CONFIGURED DEVICES ----

#include "vex.h"

#include <string>
#include <sstream>
#include <cmath>
#include <complex> 
#include <algorithm>
using namespace vex;

#include <cstdio>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <vector>
std::ofstream rad;
std::ofstream the;
std::ofstream t;
std::ofstream t_tar;
std::ofstream r_tar;
std::ofstream temp;
using std::vector; 

template <typename T>
std::string my_to_string(const T& value)
{
    std::ostringstream os ;
    os << value ;
    return os.str() ;
}

void print_ln(int line, const std::string& str){
  Brain.Screen.setCursor(line, 0);
  Brain.Screen.clearLine();
  Brain.Screen.print(str.c_str());
}

double dot_product(double vector_a[], double vector_b[]) {
   int product = 0;
   for (int i = 0; i < 2; i++)
    product = product + vector_a[i] * vector_b[i];
   return product;
}

void stop_data_logger(){
  rad.close();
  the.close();
  t.close();
  t_tar.close();
  r_tar.close();
  temp.close();
}

int main() {
  
  // Initializing Robot Configuration. DO NOT REMOVE!
  vexcodeInit();

  if( Brain.SDcard.isInserted() ) {
    // Initialise log files
    rad.open("radius.txt", std::ofstream::out);
    the.open("theta.txt", std::ofstream::out);
    t.open("t.txt", std::ofstream::out);
    r_tar.open("r_tar.txt", std::ofstream::out);
    t_tar.open("t_tar.txt", std::ofstream::out);
    temp.open("temp.txt", std::ofstream::out);
    Brain.Screen.printAt(10, 40, "done");
  }
  else {
    Brain.Screen.printAt(10, 40, "No SD Card");        
  }

  uint64_t timer_force_controller = Brain.Timer.systemHighResolution();
  uint64_t timer_pos_controller = Brain.Timer.systemHighResolution();
  uint64_t timer_screen = Brain.Timer.systemHighResolution();
  int cont = 0;
  double reference_torque_t = 0.1;
  double reference_torque_r = 0.1;


  double voltage1;
  double voltage2;
  double voltage11;
  double voltage22;

  double voltage1t;
  double voltage2t;
  double voltage11t;
  double voltage22t;

  double voltage1r;
  double voltage2r;
  double voltage11r;
  double voltage22r;

  double kp_tor_t = 1, ki_tor_t = 1, kd_tor_t = 1;
  double kp_tor_r = 1, ki_tor_r = 1, kd_tor_r = 1;

  double kp = 10, ki = 10;
  uint64_t force_controllerT = 100u;
  uint64_t pos_controllerT = 2000u;
  uint64_t screenT = 500000u;
  double force_contrT_d = double(force_controllerT);
  double pos_contrT_d = double(pos_controllerT);

  double integral_error_theta = 0, error_theta = 0, derivative_error_theta = 0, error_theta_prev = 0;
  double integral_error_r = 0, error_r = 0, derivative_error_r = 0, error_r_prev = 0;

  double error;
  double integral_error_1t = 0, integral_error_1r = 0, integral_error_11t = 0, integral_error_11r = 0, integral_error_2t = 0, integral_error_2r = 0, integral_error_22t = 0, integral_error_22r = 0;


  double t_target = -30;
  double r_target = 500;

  double red_x = 0, red_y = 0;
  double blue_x = 0, blue_y = 0;
  double green_x = 0, green_y = 0;
  double dgreen_x = 0, dgreen_y = 0;
  double dblue_x = 0, dblue_y = 0;
  double ee_x = 0, ee_y = 0;
  double theta = 0;
  double r = 0;



  double found[4] = {};
  vector<uint8_t> time;

  while(1) {
  

    if (Brain.Timer.systemHighResolution() - timer_pos_controller >= pos_controllerT)
    {
      time.push_back(Brain.Timer.systemHighResolution());
      
      timer_pos_controller = Brain.Timer.systemHighResolution();
      
      Visionsensor.takeSnapshot(Visionsensor__SIG_RED);
      if (Visionsensor.largestObject.exists){
        red_x = Visionsensor.largestObject.originX;
        red_y = Visionsensor.largestObject.originY;
        found[0] = 1;
      }
      else {
        found[0] = 0;
      }
      Visionsensor.takeSnapshot(Visionsensor__SIG_BLUE);
      if (Visionsensor.largestObject.exists){
        blue_x = Visionsensor.largestObject.originX;
        blue_y = Visionsensor.largestObject.originY;
        found[1] = 1;
      }
      else {
        found[1] = 0;
      }

      Visionsensor.takeSnapshot(Visionsensor__SIG_DBLUE);
      if (Visionsensor.largestObject.exists){
        dblue_x = Visionsensor.largestObject.originX;
        dblue_y = Visionsensor.largestObject.originY;
        found[2] = 1;
      }
      else {
        found[2] = 0;
      }

      Visionsensor.takeSnapshot(Visionsensor__SIG_DGREEN);
      if (Visionsensor.largestObject.exists){
        dgreen_x = Visionsensor.largestObject.originX;
        dgreen_y = Visionsensor.largestObject.originY;
        found[3] = 1;
      }
      else {
        found[3] = 0;
      }

      Visionsensor.takeSnapshot(Visionsensor__SIG_GREEN);
      if (Visionsensor.largestObject.exists){
        green_x = Visionsensor.largestObject.originX;
        green_y = Visionsensor.largestObject.originY;
        found[4] = 1;
      }
      else {
        found[4] = 0;
      }


      ee_x = 360*abs(dblue_x-dgreen_x)/abs(dblue_x-red_x) - 570;
      ee_y = 400*(-dblue_y+dgreen_y)/abs(dblue_y-red_y) + 510;
      theta = atan(ee_x/ee_y)*180/3.142;
      r = pow(pow(ee_x,2)+pow(ee_y,2),0.5);

      double x_target = 360*abs(dblue_x-blue_x)/abs(dblue_x-red_x) - 570;
      double y_target = 400*(-dblue_y+green_y)/abs(dblue_y-red_y) + 510;
      t_target = atan(x_target/y_target)*180/3.142;
      r_target = pow(pow(x_target,2)+pow(y_target,2),0.5);


      if (found[3] ==1 && found[2] == 1)
      {
        // theta control
        error_theta = theta- t_target;
        integral_error_theta += error_theta * pos_contrT_d * 1e-6;

        if (((voltage1 <= 0 && voltage22 <= 0) || (voltage11 <= 0 && voltage2 <= 0)) && integral_error_theta < -1) {
          integral_error_theta = -1;
        }
        if (error_theta != 0 && error_theta_prev != 0) 
        {
          derivative_error_theta = (error_theta - error_theta_prev)/(pos_contrT_d * 1e-6);
        }
        error_theta_prev = error_theta;
        reference_torque_t = 0.05*kp_tor_t* error_theta + 0.01*ki_tor_t*integral_error_theta + 0.000*kd_tor_t*derivative_error_theta;
        
        // radius control
        error_r = r - r_target;
        integral_error_r += error_r * pos_contrT_d * 1e-6;

        if (((voltage1 <= 0 && voltage22 <= 0) || (voltage11 <= 0 && voltage2 <= 0)) && integral_error_r < -1) {
          integral_error_r = -1;
        }
        if (error_r != 0 && error_r_prev != 0) 
        {
          derivative_error_r = (error_r - error_r_prev)/(pos_contrT_d * 1e-6);
        }
        error_r_prev = error_r;
        reference_torque_r = 0.01*kp_tor_r* error_r + 0.005*ki_tor_r*integral_error_r + 0.000*kd_tor_r*derivative_error_r;

        ++cont;
      }
    }

    if (Brain.Timer.systemHighResolution() - timer_force_controller >= force_controllerT)
    {
      double anti_wind_thres = -1.0;
      timer_force_controller = Brain.Timer.systemHighResolution();
      if (found[3] == 1 && found[2] == 1)
      {          
       if (t_target >= 0)
        {
          voltage1t = 0;
          error = reference_torque_t - Motor11.torque(Nm);
          integral_error_11t += error * force_contrT_d * 1e-6;
          if (voltage11 <= 0 && integral_error_11t < anti_wind_thres){
            integral_error_11t = anti_wind_thres;
          }
          voltage11t = kp * error + ki * integral_error_11t;
        
          error = - reference_torque_t + Motor2.torque(Nm);
          integral_error_2t += error * force_contrT_d * 1e-6;
          if (voltage2 <= 0 && integral_error_2t < anti_wind_thres){
            integral_error_2t = anti_wind_thres;
          }
          voltage2t =  kp * error + ki * integral_error_2t;
          voltage22t = 0;


          voltage1r = 0;
          error = reference_torque_r - Motor11.torque(Nm);
          integral_error_11r += error * force_contrT_d * 1e-6;
          if (voltage11 <= 0 && integral_error_11r < anti_wind_thres){
            integral_error_11r = anti_wind_thres;
          }
          voltage11r = kp * error + ki * integral_error_11r;

          error = reference_torque_r - Motor2.torque(Nm);
          integral_error_2r += error * force_contrT_d * 1e-6;
          if (voltage2 <= 0 && integral_error_2r < anti_wind_thres){
            integral_error_2r = anti_wind_thres;
          }
          voltage2r =  kp * error + ki * integral_error_2r;
          voltage22r = 0;
        }
        else
        {
          voltage11t = 0;
          error = reference_torque_t - Motor1.torque(Nm);
          integral_error_1t += error * force_contrT_d * 1e-6;
          if (voltage1 <= 0 && integral_error_1t < anti_wind_thres){
            integral_error_1t = anti_wind_thres;
          }
          voltage1t = kp * error + ki * integral_error_1t;
           
          error = - reference_torque_t + Motor22.torque(Nm);
          integral_error_22t += error * force_contrT_d * 1e-6;
          if (voltage22 <= 0 && integral_error_22t < anti_wind_thres){
            integral_error_22t = anti_wind_thres;
          }
          voltage22t =  kp * error + ki * integral_error_22t;
          voltage2t = 0;


          voltage11r = 0;
          error = reference_torque_r - Motor1.torque(Nm);
          integral_error_1r += error * force_contrT_d * 1e-6;
          if (voltage11 <= 0 && integral_error_11r < anti_wind_thres){
            integral_error_11r = anti_wind_thres;
          }
          voltage1r = kp * error + ki * integral_error_1r;
          
          error = reference_torque_r - Motor22.torque(Nm);
          integral_error_22r += error * force_contrT_d * 1e-6;
          if (voltage22 <= 0 && integral_error_22r < anti_wind_thres){
            integral_error_22r = anti_wind_thres;
          }
          voltage22r =  kp * error + ki * integral_error_22r;
          voltage2r = 0;
        } 


        voltage1 = voltage1t + voltage1r;
        voltage11 = voltage11t + voltage11r;
        voltage2 = voltage2t + voltage2r;
        voltage22 = voltage22t + voltage22r;

        if (voltage1 < 0)
        {
          voltage1 = 0;
          Motor1.stop(coast);
        }
        else {
          Motor1.spin(vex::reverse, voltage1, volt);
          
        }

        if (voltage11 < 0)
        {
          voltage11 = 0;
          Motor11.stop(coast);
        }          
        else {  
          Motor11.spin(vex::reverse, voltage11, volt);
        }

        if (voltage2 < 0)
        {
          voltage2 = 0;
          Motor2.stop(coast);
        }
        else {
          Motor2.spin(vex::forward, voltage2, volt);
        }

        if (voltage22 < 0)
        {
          voltage22 = 0;
          Motor22.stop(coast);
        }
        else {
          Motor22.spin(vex::forward, voltage22, volt);
        }

        if( Brain.SDcard.isInserted() ) {
          rad << r << '\n';
          the << theta << '\n';
          t << timer_force_controller << '\n';
          r_tar << r_target << '\n';
          t_tar << t_target << '\n';

          temp << r << ' ';
          temp << theta << ' ';
          temp << timer_force_controller << ' ';
          temp << r_target << ' ';
          temp << t_target << ' ';
          temp << Motor1.torque(Nm) << ' ';
          temp << Motor2.torque(Nm) << ' ';
          temp << Motor11.torque(Nm) << ' ';
          temp << Motor22.torque(Nm) << '\n';
        }
        else {
          Brain.Screen.printAt(10, 40, "No SD Card");        
        }
      }

    }

    Controller1.ButtonA.pressed(stop_data_logger);

    if (Brain.Timer.systemHighResolution() - timer_screen >= screenT)
    {
      timer_screen = Brain.Timer.systemHighResolution();

      Brain.Screen.clearScreen();
      Brain.Screen.setOrigin(1,1);
      Brain.Screen.drawRectangle(0,0,316,212);

      Visionsensor.takeSnapshot(Visionsensor__SIG_RED);
      if (Visionsensor.largestObject.exists){
        Brain.Screen.drawRectangle(Visionsensor.largestObject.originX,Visionsensor.largestObject.originY,Visionsensor.largestObject.width,Visionsensor.largestObject.height,color::red);
      }
      
      Visionsensor.takeSnapshot(Visionsensor__SIG_BLUE);
      if (Visionsensor.largestObject.exists){
        Brain.Screen.drawRectangle(Visionsensor.largestObject.originX,Visionsensor.largestObject.originY,Visionsensor.largestObject.width,Visionsensor.largestObject.height,color::yellow);
      }
      
      Visionsensor.takeSnapshot(Visionsensor__SIG_DBLUE);
      if (Visionsensor.largestObject.exists){
        Brain.Screen.drawRectangle(Visionsensor.largestObject.originX,Visionsensor.largestObject.originY,Visionsensor.largestObject.width,Visionsensor.largestObject.height,color::blue);
      }

      Visionsensor.takeSnapshot(Visionsensor__SIG_GREEN);
      if (Visionsensor.largestObject.exists){
        Brain.Screen.drawRectangle(Visionsensor.largestObject.originX,Visionsensor.largestObject.originY,Visionsensor.largestObject.width,Visionsensor.largestObject.height,color::white);
      }
      
      Visionsensor.takeSnapshot(Visionsensor__SIG_DGREEN);
      if (Visionsensor.largestObject.exists){
        Brain.Screen.drawRectangle(Visionsensor.largestObject.originX,Visionsensor.largestObject.originY,Visionsensor.largestObject.width,Visionsensor.largestObject.height,color::green);
      }


      Brain.Screen.printAt(400,30,  "t1 = %.2f"  ,Motor1.torque(Nm));
      Brain.Screen.printAt(400,50,  "t2 = %.2f"  ,Motor2.torque(Nm));

      Brain.Screen.printAt(400,70,  "t11 = %.2f"  ,Motor11.torque(Nm));
      Brain.Screen.printAt(400,90,  "t22 = %.2f"  ,Motor22.torque(Nm));

      Brain.Screen.printAt(400,130, "t: %.2f", theta);
      Brain.Screen.printAt(400,150, "r: %.2f", r);
    }    

  }
  if( Brain.SDcard.isInserted() ) {
  }
  else {
    Brain.Screen.printAt(10, 40, "No SD Card");        
  }

  
}
