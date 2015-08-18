function [ error ] = moveEngine( engine, power, angle, alpha_old )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% Motor B
initAngle = angle;
start = engine.ReadFromNXT().Position;
error = 0;
if (abs(angle) <= 1)
    disp('Angle is 0');
    return
end
port = engine.Port;
if (port ==0)
    % play compensation of motor A - Start has to be with positiv alpha
    % No play at first motion
    if (sign(angle) == sign(alpha_old)) && (alpha_old~=0)
        angle = angle + 0;
    elseif (sign(angle) ~= sign(alpha_old)) && (alpha_old~=0)
        angle = angle + 7 * sign(angle);
    end
elseif (port == 1)
    if(angle > 2)
        angle = angle + (-2);
    elseif (angle < -2)
        angle = angle + (-2);
    end
elseif (port == 2)
    if(angle > 1)
        angle = angle + (0);
    elseif (angle < 0)
        angle = angle + (0);
    end
end
engine.TachoLimit = abs(angle); % Angle for motor A
engine.Power = power * sign(angle);
engine.ActionAtTachoLimit = 'Holdbrake';
engine.SendToNXT();
engine.WaitFor();
data = engine.ReadFromNXT().Position;
% error = initAngle + (data - start); % Commented out due to sign problems
% from motor to motor
end

