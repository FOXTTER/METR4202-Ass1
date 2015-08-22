function [] = angleTest(motor, power, angle)
start = motor.ReadFromNXT().Position;
moveEngine(motor,power,angle,0);
% Read Data and Show
pause(0.5)
data = motor.ReadFromNXT().Position;
fprintf('Start angle: %d\n', start);
fprintf('End angle: %d\n', data);
fprintf('Moved angle intervall: %d\n', data-start);
fprintf('Desired angle intervall: %d\n', angle);
fprintf('Deviation angle: %d\n', angle+(data-start));