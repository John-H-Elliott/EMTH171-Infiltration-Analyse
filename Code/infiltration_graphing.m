% EMTH-171 WEEK-6
% John Elliott and Samuel Vallance
% Using Newtons-Method to find the infiltration of water and therefore the
% runoff of water when rain occurs

% Reset vital environment
clear
clc
close all


% ==============================| Plotting |==============================


timearray = [0, 15, 30, 45, 60, 75, 90, 105, 120];
infiltration = [11.07, 6.10, 4.61, 4.12, 3.93, 3.87, 3.85, 3.84];
cumInfiltration = [0.00, 0.50, 1.30, 2.50, 3.58, 4.28, 4.58, 4.68, 4.78];
runoff = [0, 0, 0, 0, 0.42, 0, 0, 0, 0];
incremental = [0.0, 0.5, 0.8, 1.2, 1.5, 0.7, 0.3, 0.1, 0.1];

figure(1)
plot(timearray(2:end), infiltration)
ylabel('Infiltration Rate, f (cm/h)')
xlabel('Times, t (minutes)')
yyaxis right

hold on
plot(timearray, cumInfiltration) 
ylabel('Cumulative Rate, F(cm)')
legend('Infiltration Rate, f (cm/h)','Cumulative Infiltration, F(cm)')
hold off
ylim([0,12])
xlim([0,140])

figure(2)
plot(timearray, incremental)
ylabel('Incremental (cm)')
xlabel('Times (minutes)')

hold on
plot(timearray, runoff) 
legend('Rainfall Incremental, (cm)','Runoff Incremental,(cm)')
hold off
ylim([0,1.6])
xlim([0,140])

