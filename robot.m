clc
setupNXT();
disp('Put robot arm in desired position and press enter')
pause
M = importdata('coords.txt');
for i = 1:size(M,1)
    break;
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
