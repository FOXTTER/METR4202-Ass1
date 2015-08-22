clc
clear
[h] = setupNXT();
mA = NXTMotor('A', 'Power', -50);
mB = NXTMotor('B', 'Power', -15);
mC = NXTMotor('C', 'Power', -30);
mA.SpeedRegulation = true;
mB.SpeedRegulation = true;
mC.SpeedRegulation = true;
M = importdata('coords.txt');
disp('Put robot arm in desired position and press enter')
pause
mA.Stop('Brake');
mB.Stop('Brake');
mC.Stop('Brake');
disp('Press enter to start')
pause
M(:,1:2) = M(:,1:2)*0.032;
M(:,3) = M(:,3)*0.020;
% Initil point
current = [1*0.032 0*0.032 0.2*0.02];
alpha_error = 0;
beta_error = 0;
gamma_error = 0;
alpha_old_sign = 0;
securityAngle = 15;
enginePowerA = -50;
enginePowerB = -15;
enginePowerC = -30;
i = 1;
mB.ResetPosition();

while(1)
    fprintf('Point: %d\n',i);
    disp(M(i,:,:))
    desired = M(i,:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    fprintf('Angles (a,b,g) = (%d, %d, %d)\n',alpha,beta,gamma);
    
    securityAngle = -170 + mB.ReadFromNXT().Position;
    % First move engine B up then do the rest of the moves
    moveEngine(mB,enginePowerB,securityAngle, alpha_old_sign);
    mB.WaitFor();
    moveEngine(mA,enginePowerA,alpha, alpha_old_sign);
    moveEngine(mC,enginePowerC,gamma, alpha_old_sign);
    mA.WaitFor();
    mC.WaitFor();
    moveEngine(mB,enginePowerB, -securityAngle + beta, alpha_old_sign);
    mB.WaitFor();
    alpha_old_sign = alpha;
    %Update current position
    current = desired;
    %Wrap around the points
    i = mod(i,length(M(:,1)))+1;
end
