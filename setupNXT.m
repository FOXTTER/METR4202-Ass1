function [h] = setupNXT()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
COM_CloseNXT('all');
close all
clear all
h = COM_OpenNXT();
COM_SetDefaultNXT(h)
%NXT_PlayTone(450, 500);
end

