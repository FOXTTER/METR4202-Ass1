clc
clear
[h, mA, mB, mC] = setupNXT();
mA.SpeedRegulation = true;
mB.SpeedRegulation = true;
mC.SpeedRegulation = true;
disp('Put robot arm in desired position and press enter')
pause
mA.Stop('Brake');
mB.Stop('Brake');
mC.Stop('Brake');
disp('Press enter to start')
pause
M = importdata('coords.txt');
M(:,1:2) = M(:,1:2)*0.032;
M(:,3) = M(:,3)*0.020;
current = M(1,:,:);
for i = 2:size(M,1)
    fprintf('Point: %d\n',i);
    disp(M(i,:,:))
    desired = M(i,:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    current = desired;
    moveEngine(mA,-10,alpha);
    moveEngine(mC,-10,gamma);
    moveEngine(mB,-10,beta);
    pause(0.5);
end
