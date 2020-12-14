function st = sinetone(freq, rate, sec, ampl)
    dt = 1/rate;
    t = dt:dt:sec;
    st = ampl * sin(2*pi*freq*t)';
end