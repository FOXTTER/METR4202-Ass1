function [] = angleTest(motor, angle)
start = motor.ReadFromNXT().Position;
moveEngine(motor,-5,angle);
% Read Data and Show
pause(1.5)
data = motor.ReadFromNXT().Position;
fprintf('Start angle: %d\n', start);
fprintf('End angle: %d\n', data);
fprintf('Moved angle: %d\n', data-start);
fprintf('Desired angle: %d\n', angle);
fprintf('Deviation angle: %d\n', angle+(data-start));