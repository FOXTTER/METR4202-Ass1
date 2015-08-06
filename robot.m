h = COM_OpenNXT()
COM_SetDefaultNXT(h)
mA = NXTMotor('A', 'Power', 50);
mA.TachoLimit = 20;
mA.SendToNXT(); % this is actually the moment we start the motor
pause(1);
mA.Stop('Brake');
COM_CloseNXT(COM_GetDefaultNXT());