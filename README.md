# ECE 528 Project Load Strain Gauge Motor Control


## Project Overview
This project is for a Load Strain Gauge Motor Control project for an interface between a load strain gauge sensor to control a motor.

## System Architecture
The system architecure for this project is based on firmware created in a Zybo Z7-10 for PWM and serial communication logic. This firmware design is used to interface between a Load Cell Amplifier serially to receive the sensor's load value. It also interfaces with the Motor Driver via the PWM signal to control the speed of the motor. 

## Interfaces and Peripherals 
The interface between the components and FPGA pins utilized can be seen in the table and diagram below. 

<img width="441" height="487" alt="image" src="https://github.com/user-attachments/assets/bf34aa96-296f-43f3-bfb4-1ab3fe2fec01" />

<img width="1239" height="700" alt="image" src="https://github.com/user-attachments/assets/20ffe534-7393-42c0-a370-6d49c4aa2686" />

## Verification and Testing
A top module was designed in VHDL to interface with the submodules for PWM and serial communication. Then I created testbenches to verify the functionality of modules. Once the simulations were created the hardware interface was made to test the firmware. 
<img width="1693" height="952" alt="image" src="https://github.com/user-attachments/assets/d0ec2e7c-4c86-4df1-8090-02d01d6f92a5" />

## Project Demonstration
<img width="919" height="823" alt="image" src="https://github.com/user-attachments/assets/2cf71174-7d6b-45be-a0ea-f8e337255a3e" />

## Conclusion
Accomplished the firmware interface between the load strain gauge sensor and the motor via the firmware logic. Challenges encountered was creating a finite state machine for serial communication, but was able to understand the implementation of a FSM for serial communication. 
