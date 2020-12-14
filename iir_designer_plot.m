function iir_designer_plot(filtOrder, f1, f2, fs, filtType, ripple, att)
fNyquist = fs/2;
axVals = [0,1,-10,0];
switch filtType
    case 'bandpass_butter'
        [b,a] = butter(filtOrder,[f1 f2]/fNyquist, 'bandpass');
        [h, w] = freqz(b,a);
        data = [[1;zeros(fs-1,1)],ones(fs,1),sinetone(f1/2,fs,1,1),sinetone((f1+f2)/2,fs,1,1),sinetone(f2*2,fs,1,1)];
    case 'bandstop_butter'
        [b,a] = butter(filtOrder,[f1 f2]/fNyquist, 'stop');
        [h, w] = freqz(b,a);
        data = [[1;zeros(fs-1,1)],ones(fs,1),sinetone(f1/2,fs,1,1),sinetone((f1+f2)/2,fs,1,1),sinetone(f2*2,fs,1,1)];
    case 'highpass_butter'
        [b,a] = butter(filtOrder,f1/fNyquist, 'high');
        [h, w] = freqz(b,a);
        data = [[1;zeros(fs-1,1)],ones(fs,1),sinetone(f1/2,fs,1,1),sinetone(f1,fs,1,1),sinetone(f1*2,fs,1,1)];
    case 'lowpass_butter'
        [b,a] = butter(filtOrder,f1/fNyquist, 'low');
        [h, w] = freqz(b,a);
        data = [[1;zeros(fs-1,1)],ones(fs,1),sinetone(f1/2,fs,1,1),sinetone(f1,fs,1,1),sinetone(f1*2,fs,1,1)];
        axVals = [0,1,-40,0];
    case 'bandpass_elliptical'
        [b,a] = ellip(filtOrder,ripple,att,[f1 f2]/fNyquist);
        [h, w] = freqz(b,a);
        data = [[1;zeros(fs-1,1)],ones(fs,1),sinetone(f1/2,fs,1,1),sinetone((f1+f2)/2,fs,1,1),sinetone(f2*2,fs,1,1)];
    otherwise
        warning('Unexpected filter type.')
end
filtered = filter(b,a,data);

figure('position',[0,0,1200,800]);
set(gcf,'color','w');
subplot(columns(filtered)+1,1,1);
plot(w./pi,20*log10(abs(h)),'k');
xlabel("Frequency");
ylabel("abs(H[w])[dB]");
title(strrep(filtType,'_',' '));
axis(axVals);

% plot the filtered result of 3 sample sines
subplot(columns(filtered)+1, 1, 2);
plot(filtered(:,1),'k');
xlim([0,size(filtered,1)]);
title("Impulse response");

subplot(columns(filtered)+1, 1, 3);
plot(filtered(:,2),'k');
xlim([0,size(filtered,1)]);
title("DC response");

subplot(columns(filtered)+1, 1, 4);
plot(filtered(:,3),'k');
xlim([0,size(filtered,1)]);
title("f1/2 Hz response");

subplot(columns(filtered)+1, 1, 5);
plot(filtered(:,4),'k');
xlim([0,size(filtered,1)]);
title("f1 response");

subplot(columns(filtered)+1, 1, 6);
plot(filtered(:,5),'k');
xlim([0,size(filtered,1)]);
title("f1*2 response");
end

function c = columns(v)
    c = size(v,2);
end