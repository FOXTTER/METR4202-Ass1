function [ ] = moveEngine( engine, power, angle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Motor B
if (angle <= 1)
    return;
end
engine.TachoLimit = abs(angle); % Angle for motor A
engine.Power = power * sign(angle);
engine.ActionAtTachoLimit = 'Holdbrake';
engine.SendToNXT();
engine.WaitFor();
end

