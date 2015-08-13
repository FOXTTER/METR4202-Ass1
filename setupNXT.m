function [h, mA, mB, mC] = setupNXT()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
COM_CloseNXT('all');
clear
h = COM_OpenNXT();
COM_SetDefaultNXT(h)
NXT_PlayTone(440, 500);
mA = NXTMotor('A', 'Power', 10);
mB = NXTMotor('B', 'Power', 10);
mC = NXTMotor('C', 'Power', 10);
end

