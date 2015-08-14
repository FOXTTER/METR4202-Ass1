clc
[h, mA, mB, mC] = setupNXT();
disp('Put robot arm in desired position and press enter')
pause
mA.Stop('Brake');
mB.Stop('Brake');
mC.Stop('Brake');
M = importdata('coords.txt');
current = M(1,:,:);
for i = 2:size(M,1)
    fprintf('Point: %d\n',i);
    disp(M(i,:,:))
    desired = M(i,:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    current = desired;
    moveEngine(mA,10,alpha);
    moveEngine(mC,-5,gamma);
    moveEngine(mB,-5,beta);
    pause(0.5);
end
