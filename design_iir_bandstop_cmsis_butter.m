% @author Matteo Scordino
% @date 2018-08-04
% @version 1.0.0
% 
% @brief M file to design a bandstop Butterworth filter and get the coefficients for CMSIS DSP
% 
 
function design_iir_bandstop_cmsis_butter(requested_order, f1, f2, fs, plot_results)
% it's a bandstop filter, so if we want a 4th order, we need to compute a
% 2nd order (because it's actually 2 filters in one, so the final order will be double)
filtOrder = requested_order/2;
% Nyquist frequency, for convenience
fNyquist=fs/2;
% design filter in zeros, poles, gain format
[z,p,k] = butter(filtOrder,[f1 f2]/fNyquist, 'stop');
% convert it to the second order sections (used for biquads) format
[sos] = zp2sos(z,p,k);

% compute biquad coefficients
coeffs = sos(:,[1 2 3 5 6]);
% negate a1 and a2 coeffs (CMSIS expects them negated)
coeffs(:,4) = -coeffs(:,4);
coeffs(:,5) = -coeffs(:,5);

% make a linear array of it
coeffs = coeffs';
coeffs = coeffs(:);

if (plot_results == true)
	iir_designer_plot(filtOrder, f1, f2, fs, 'bandstop_butter');
end

% print the coefficients as expected by CMSIS
coeffs
end
