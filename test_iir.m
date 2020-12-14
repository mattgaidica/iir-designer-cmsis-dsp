close all
clear all
plot_results=true
%///////////////////////////////////////////////////////////////
% Example 1
% 2nd filtOrder DC blocker, 20 Hz, sampling frequency = 44.1kHz
% Plots the filter response and sample signals 
%///////////////////////////////////////////////////////////////

filtOrder=2
f1=400
fs=44100

design_iir_highpass_cmsis_butter(filtOrder,f1,fs,plot_results);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%///////////////////////////////////////////////////////////////
% Example 2
% Elliptical bandpass between 150 and 600 Hz, 1dB ripple, 60dB
% stopband attenuation
%///////////////////////////////////////////////////////////////

filtOrder=4
ripple=1
att=60
f1=150
f2=600
fs=16000

design_iir_bandpass_cmsis_elliptical(filtOrder,ripple,att,f1,f2,fs,plot_results);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%///////////////////////////////////////////////////////////////
% Example 3
% & Same as frequencies sd example 2, but designed as Butterworth 
% filter
%///////////////////////////////////////////////////////////////

filtOrder=4
f1=150
f2=600
fs=16000

design_iir_bandpass_cmsis_butter(filtOrder,f1,f2,fs,plot_results);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%///////////////////////////////////////////////////////////////
% Example 4
% 50 Hz notch filter, 
% bandstop between 47 and 53 Hz, sampling frequency = 1kHz
%///////////////////////////////////////////////////////////////

filtOrder=4
f1=47
f2=53
fs=1000

design_iir_bandstop_cmsis_butter(filtOrder,f1,f2,fs,plot_results);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

design_iir_lowpass_cmsis_butter(filtOrder,f1,fs,plot_results);
design_iir_highpass_cmsis_butter(filtOrder,f1,fs,plot_results);
