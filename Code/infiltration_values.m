% EMTH-171 WEEK-6
% John Elliott and Samuel Vallance
% Using Newtons-Method to find the infiltration of water and therefore the
% runoff of water when rain occurs

% Reset vital environment
clear
clc
close all


% =======================| Importing Excel Arrays |=======================


dataFilename = 'cumulative&intensity.csv';
dataArray = load(dataFilename);
start = 3;
intensity = dataArray(start:end,3);
cumulative = dataArray(start:end,2);
incremental = dataArray(:,1);


% ======================| Variables Initialization |======================


% Soil properties and time interval: 
%   These change depending on the soil type.
%   The soil being used, (Loamy Sand).
soilSuction = 21.85;
moistureChange = 0.1815;
con = soilSuction * moistureChange;
conductivity = 0.15;
time = 15/60;

% g is the soil infiltration rate equation and gd is its derivative
% g takes the inputs x and z which are F(t) and F(t-1) respectively.
g = @(x, z) x - z - con*log((con+x)/(con+z)) - conductivity*time;
gd = @(x) (x / (con + x));

% Initialization arrays that store all caculated values to advoid rezising
% a zero array is made to the maxium possible size (endSize).
endSize = length(intensity);
fArray = zeros(1, endSize);
FArray = zeros(1, endSize);
runoffArray = zeros(2, endSize);

% currentVal is is the value of F(t-1) used by the function g
% trialVal is the guess used to started Newtons-Method
currentVal = 0.5;
trialVal = 1;
N = 4;


% =====================| Newtons-Method Calculations |=====================

% Reapeat finding F(t) untill it again becomes less than rainfall intensity 
for ii = 1:endSize
    
    % Iterates through newtons method (N) times to find an approximation of
    % (F(t)).
    for jj = 1:N
        trialVal = trialVal - g(trialVal, currentVal)/gd(trialVal);
    end
    
    currentVal = trialVal;
    FArray(ii) = trialVal;
    runoffArray(1, ii+1) = cumulative(ii) - FArray(ii);
    
    fArray(ii) = conductivity *((con/trialVal) + 1);
    runoffArray(2, ii+1) = runoffArray(1, ii+1) - runoffArray(1, ii);
    
    if fArray(ii) > intensity(ii)
        break
    end
    
end


% ========================| Display Calculations |========================


fprintf("==== F (cm/h) ====\n")
fprintf("%.2f\n",FArray(1, 1:ii))
fprintf("\n==== f (cm/h) ====\n")
fprintf("%.2f\n",fArray(1, 1:ii))
fprintf("\n==== Runoff (cm) ====\n")
disp("Cumulative: Incremental:")
fprintf("%.2f %11.2f\n", runoffArray(1:2, 2:ii+1))
