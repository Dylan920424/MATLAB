function [pulse_train] = gen_pulse_train(off,on,cycles)

temp_pulse = [zeros(1,off),ones(1,on),zeros(1,off)];
pulse_train = repmat(temp_pulse, 1, cycles);

end

