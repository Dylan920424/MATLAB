function [solution] = sirhd(steps,s_init,param, variant)

% check if all three input exists
if ~exist('steps','var')||~exist('s_init','var')||~exist('param','var')
    error("missing inputs")
end

% check if the variant input exists, if not set default to all ones
if ~exist('variant', 'var')
    variant = ones(1,steps)
end

% check if the param list has the correct dimensions
if size(param,1)~=1||size(param,2)~=6
    error("param input size is wrong")
end

% check if all the param values are within the range of 0 and 1
if size(param(param<0|param>1),2)>0
    error("param values are not within range")
end

% initialize an empty matrix for the solution with size 5 x steps
solution = zeros(5, steps)

% set param names and state names
param_names = ["p_SI","p_IR","p_IH","p_HR","p_RS","p_HD"]
state_names = ["S", "I", "R", "H", "D"]

% print the values or the params and the initial state probabilities
fprintf("The parameters are: \n")
fprintf("%s: %f\n", [param_names;param])

fprintf("The intial state probabilities are: \n")
fprintf("%s: %f\n", [state_names;s_init])

% initialize the Probability matrix with the given param and initial state
% values
P = [(1-param(1)*s_init(2)), (param(1)*s_init(2)), 0, 0, 0; ...
    0, (1-param(2)-param(3)), param(2), param(3) 0; ...
    param(5), 0, 1-param(5), 0 0; ...
    0, 0, param(4), (1-param(4)-param(6)), param(6);...
    0, 0, 0, 0, 1]

% check the orientation of the given intial states
if size(s_init,1)==1&&size(s_init,2)==5
    s_init = s_init'
end

% set the first column of the solution set to the initial state
current = s_init;
solution(:,1) = s_init;

% set the varying param P_SI
P_SI = param(1)*variant

% loop for step times and use the formula s(k+1) = P's(k) to redefine each
% column with its previous column
for ii = 2:steps
    % calibrate P_SI with the variant vector
    
    P = [(1-P_SI(ii)*s_init(2)), (P_SI(ii)*s_init(2)), 0, 0, 0; ...
    0, (1-param(2)-param(3)), param(2), param(3) 0; ...
    param(5), 0, 1-param(5), 0 0; ...
    0, 0, param(4), (1-param(4)-param(6)), param(6);...
    0, 0, 0, 0, 1];
    current = P'*current;
    solution(:,ii) = current;
end

% plot the values in two separate plots, one for IHD the other for SR with
% according title and legends
subplot(2,1,1);
plot(solution(2,:)); hold on;
plot(solution(4,:))
plot(solution(5,:))
legend(state_names([2,4,5]))
title("I,H,D")
ylabel("probability")
xlabel("days")

subplot(2,1,2);
plot(solution(1,:)); hold on;
plot(solution(3,:));
legend(state_names([1,3]))
title("S,R")
ylabel("probability")
xlabel("days")


% sirhd(500, s_init, param)
% with
% param = [0.0500    0.0200    0.0100    0.1000   0    0.0020]
% s_init = [0.95 0.05 0 0 0]

% What is the maximum percentage of the population that is hospitalized? Give a brief qualitative
% explanation (no more than 3 sentences) why the infection and hospitalized states have the hump-
% shaped trajectories shown.

% 0.00668384. Infection and hospitalized both have hump-shaped
% trajectories since they both have higher outputs then input, given that
% the recovered state is inescapable. The recovered state rises and the
% infection and hospitalized starts to fall.

% Why is sD always increasing? Explain in terms of the properties of the Markov chain (one sentence).
%
% Since the possible paths for the death stage is to only stay within
% itself (inescapable), the value sD is always increasing

% Rerun the example increasing pSI to 0.1 and observe the change in the asymptotic values of sS and
% sR. Explain briefly why increasing pSI keeping other parameters fixed has this effect. Is there a similar
% effect on sS and sR when increasing pIR keeping other parameters fixed?
%
% It increases the gap between the two values at the end (static value)
% since it increased the possibilty of getting infected, so the whole
% process of infection and recovery became more fast paced compared to when
% the value was 0.05, hence resulting in a larger difference at the
% end. There is not a similar effect changing pIR

% As an example, plot the trajectories of the state variables where the variant appears
% at time 200 and ramps up over 50 periods. For this example, explain qualitatively the shape of the infection
% and hospitalization curves in terms of the input parameters. What may help to mitigate the second wave
% shown that is not captured in the model?
%
% variable = ones(1, 500); variable(201:250) = (1+1/50):1/50:2
% starting at time T (200) the infection curve which was decreasing spiked
% up and after 50 days slowly returned to its original trajectory, a
% similar but not as severe effect was had on the hospitilization curve.
% The change in recovery rate due to vaccines and or immune systems are not captured in this model.

end


