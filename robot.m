clc
clear
[h] = setupNXT();
mA = NXTMotor('A', 'Power', 30);
mB = NXTMotor('B', 'Power', 20);
mC = NXTMotor('C', 'Power', 10);
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
%%
M = importdata('coords.txt');
M(:,1:2) = M(:,1:2)*0.032;
M(:,3) = M(:,3)*0.020;
current = M(1,:,:);
alpha_error = 0;
beta_error = 0;
gamma_error = 0;
alpha_old = 0;
securityAngle = 23;
securityInterval = 7;
for i = 2:size(M,1)
    %moveEngine(mB,-10,20);
    fprintf('Point: %d\n',i);
    disp(M(i,:,:))
    desired = M(i,:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    fprintf('Angles (a,b,g) = (%d, %d, %d)\n',alpha,beta,gamma);
    if beta > ((securityAngle-securityInterval)*(24/8))
        beta_error = (moveEngine(mB,-10,-securityAngle*24/8 + beta_error, alpha_old))/(24/8);
        alpha_error = moveEngine(mA,-50,alpha + alpha_error, alpha_old);
        gamma_error = moveEngine(mC,-5,gamma + gamma_error, alpha_old);
        beta_error = (moveEngine(mB,-10, securityAngle*24/8 + beta + beta_error, alpha_old))/(24/8);
    else
        beta_error = (moveEngine(mB,-10,-securityAngle*24/8 + beta + beta_error, alpha_old))/(24/8);
        alpha_error = moveEngine(mA,-50,alpha + alpha_error, alpha_old);
        gamma_error = moveEngine(mC,-5,gamma + gamma_error, alpha_old);
        beta_error = (moveEngine(mB,-10, securityAngle*24/8 + beta_error, alpha_old))/(24/8);
    end
%     mA.WaitFor(); % is contained in moveEngine
%     mB.WaitFor();
%     mC.WaitFor();
    alpha_old = alpha;
    current = desired;
    pause(0.1);
end
