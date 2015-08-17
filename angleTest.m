function [] = angleTest(motor, angle)
start = motor.ReadFromNXT().Position;
if motor.Port == 0
    power = -50;
elseif motor.Port ==1
    power = -20;
elseif motor.Port == 2
    power = -15;
end
moveEngine(motor,power,angle);
% Read Data and Show
pause(2)
data = motor.ReadFromNXT().Position;
fprintf('Start angle: %d\n', start);
fprintf('End angle: %d\n', data);
fprintf('Moved angle intervall: %d\n', data-start);
fprintf('Desired angle intervall: %d\n', angle);
fprintf('Deviation angle: %d\n', angle+(data-start));