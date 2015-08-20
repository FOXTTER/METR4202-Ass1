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
%M = Lab1RandLocations(6)
disp('Put robot arm in desired position and press enter')
pause
mA.Stop('Brake');
mB.Stop('Brake');
mC.Stop('Brake');
disp('Press enter to start')
pause
M(:,1:2) = M(:,1:2)*0.032;
M(:,3) = M(:,3)*0.020;
%current = M(1,:,:);
current = [1*0.032 0*0.032 0.2*0.02];
alpha_error = 0;
beta_error = 0;
gamma_error = 0;
alpha_old_sign = 0;
securityAngle = 15;
enginePowerA = -50;
enginePowerB = -15;
enginePowerC = -30;
%optimal = tsp_dp1(M)
%for i = 2:size(M,1)
i = 1;
base2a = 0.162;
joint_A = [5.5*0.032, -2.125*0.032, base2a];
T_0 = norm(joint_A - [1*0.032, 0, 0]);
beta_0 = int32(rad2deg(acos(base2a/T_0)));
mB.ResetPosition();
beta = 0;
beta_sum = 0;

while(1)
    fprintf('Point: %d\n',i);
    disp(M(i,:,:))
    desired = M(i,:,:);
    %Convert the point to angles for the motors
    [alpha, beta, gamma] = calcAngles(current, desired);
    fprintf('Angles (a,b,g) = (%d, %d, %d)\n',alpha,beta,gamma);
    
    %alpha_old = mA.ReadFromNXT().Position;
    %beta_old = mB.ReadFromNXT().Position;
    %gamma_old = mC.ReadFromNXT().Position;
    securityAngle = -170 + mB.ReadFromNXT().Position;
    
    moveEngine(mB,enginePowerB,securityAngle, alpha_old_sign);
    mB.WaitFor();
    moveEngine(mA,enginePowerA,alpha, alpha_old_sign);
    moveEngine(mC,enginePowerC,gamma, alpha_old_sign);
    mA.WaitFor();
    mC.WaitFor();
    moveEngine(mB,enginePowerB, -securityAngle + beta, alpha_old_sign);
%     mA.WaitFor(); % is contained in moveEngine
    mB.WaitFor();
%     mC.WaitFor();
    alpha_old_sign = alpha;
%   pause(0.8);
    %alpha_error = alpha + (mA.ReadFromNXT().Position - alpha_old);
    %beta_error = beta + (mB.ReadFromNXT().Position - beta_old);
    %gamma_error = gamma + (mC.ReadFromNXT().Position - gamma_old);
    current = desired;
    i = mod(i,length(M(:,1)))+1;
end
