% @author Matteo Scordino
% @date 2018-08-04
% @version 1.0.0
%
% @brief M file to design a bandpass Elliptical filter and get the coefficients for CMSIS DSP
%

function design_iir_bandpass_cmsis_elliptical (requested_order, ripple, att, f1, f2, fs, plot_results)
% it's a bandpass filter, so if we want a 4th filtOrder, we need to compute a
% 2nd filtOrder (because it's actually 2 filters in one, so the final filtOrder will be double)
filtOrder = requested_order/2;
% Nyquist frequency, for convenience
fNyquist=fs/2;
% design filter in zeros, poles, gain format
[z,p,k] = ellip(filtOrder,ripple,att,[f1 f2]/fNyquist);
% convert it to the second filtOrder sections (used for biquads) format
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
    iir_designer_plot(filtOrder, f1, f2, fs, 'bandpass_elliptical', ripple, att);
end

% print the coefficients as expected by CMSIS
coeffs
end
