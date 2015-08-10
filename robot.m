clear
clc
%h = COM_OpenNXT()
%COM_SetDefaultNXT(h)
%mA = NXTMotor('A', 'Power', 50);
%mA.TachoLimit = 20;
%mA.SendToNXT(); % this is actually the moment we start the motor
%pause(1);
%mA.Stop('Brake');
%COM_CloseNXT(COM_GetDefaultNXT());
M = importdata('coords.txt');
for i = 1:size(M,1)
    fprintf('Point: %d\n',i)
    disp(M(i,:,:))
    %Convert the point to angles for the motors
    %mA = NXTMotor('A', 'Power', 50);
    %mA.TachoLimit = 20; % Angle for motor A
    %mA.SendToNXT(); % this is actually the moment we start the motor
    %mB = NXTMotor('B', 'Power', 50);
    %mB.TachoLimit = 20; % Angle for motor B
    %mB.SendToNXT();
    %mC = NXTMotor('C', 'Power', 50);
    %mC.TachoLimit = 20; % Angle for motor C
    %mC.SendToNXT();
    %pause(1);
    %mA.Stop('Brake');
    %mB.Stop('Brake');
    %mC.Stop('Brake');
    %Activate the engines for the angles
end
