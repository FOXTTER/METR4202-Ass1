clc
clear
[h] = setupNXT();
mA = NXTMotor('A', 'Power', 30);
mB = NXTMotor('B', 'Power', 20);
mC = NXTMotor('C', 'Power', 10);
mA.SpeedRegulation = true;
mB.SpeedRegulation = true;
mC.SpeedRegulation = true;
M = importdata('coords.txt');
M = Lab1RandLocations(6)
disp('Put robot arm in desired position and press enter')
pause
mA.Stop('Brake');
mB.Stop('Brake');
mC.Stop('Brake');
disp('Press enter to start')
pause
%%
M(:,1:2) = M(:,1:2)*0.032;
M(:,3) = M(:,3)*0.020;
%current = M(1,:,:);
current = [1*0.032 0*0.032 0*0.02];
alpha_error = 0;
beta_error = 0;
gamma_error = 0;
alpha_old = 0;
securityAngle = 15;
securityInterval = 7;
enginePowerA = -50;
enginePowerB = -15;
enginePowerC = -30;
optimal = tsp_dp1(M)
%for i = 2:size(M,1)
i = 1;
while(1)
    %moveEngine(mB,-10,20);
    fprintf('Point: %d\n',i);
    disp(M(optimal(i),:,:))
    desired = M(optimal(i),:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    fprintf('Angles (a,b,g) = (%d, %d, %d)\n',alpha,beta,gamma);
    if beta > ((securityAngle-securityInterval)*(24/8))
        beta_error = (moveEngine(mB,enginePowerB,-securityAngle*24/8 + beta_error, alpha_old))/(24/8);
        alpha_error = moveEngine(mA,enginePowerA,alpha + alpha_error, alpha_old);
        gamma_error = moveEngine(mC,enginePowerC,gamma + gamma_error, alpha_old);
        beta_error = (moveEngine(mB,enginePowerB, securityAngle*24/8 + beta + beta_error, alpha_old))/(24/8);
    else
        beta_error = (moveEngine(mB,enginePowerB,-securityAngle*24/8 + beta + beta_error, alpha_old))/(24/8);
        alpha_error = moveEngine(mA,enginePowerA,alpha + alpha_error, alpha_old);
        gamma_error = moveEngine(mC,enginePowerC,gamma + gamma_error, alpha_old);
        beta_error = (moveEngine(mB,enginePowerB, securityAngle*24/8 + beta_error, alpha_old))/(24/8);
    end
%     mA.WaitFor(); % is contained in moveEngine
%     mB.WaitFor();
%     mC.WaitFor();
    alpha_old = alpha;
    current = desired;
    %pause(0.8);
    i = mod(i,length(optimal)-1)+1;
end
