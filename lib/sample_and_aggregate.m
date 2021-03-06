%% Sample and Aggregate Method 
%% 
%{
  --------------------------------------------------------
  -                                                      -
  -  Author : Wei-Ning Chen                              -
  -  Date   : 2016/04/28                                 -
  -  Usage  : Perfom the sample and aggregate method     -
  -           provided by A. Smith08 with estmato.m      -    
  --------------------------------------------------------
%}



function [T_star] = sample_and_aggregate(x, epsilon, Lambda, estimator, k);

%{
  x:  database with size n
  epsilon:  privacy parameter
  Lambda: range of estimator
  estimtor: the estimato
%}

if nargin > 5
  error('Too many arguments');
end



switch nargin 
  case 2 
      Lambda = 1;
      estimator = @default_estimator; %%Default estimator
      k = 0;
  case 3
      estimator = @default_estimator;
      k = 0;
  case 4 
      k = 0;
end

%% Compute k
[n, d] = size(x);
if k==0
    if Lambda==0
        k = 1
    else
        k = floor(n^0.6*Lambda^0.4/(epsilon^0.4))
    end
end
t = floor(n/k) %% At most k+1 blocks


%% Random permute x
p = randperm(n);
y = x;
for i = 1:n
  x(i,:) = y(p(i),:);
end

%% Find mean of each bias-corrected estimator
z = [];
for i = 0:k-1
  z = [z ; estimator(x(i*t+1:i*t+t,:))];
end
if mod(n,k) ~= 0
    z = [z; estimator(x(t*k+1:end,:))];
end
z_mean = mean(z);

%% Privatize the estimation mean
noise_sd = 2^(1/2)*Lambda/(k*epsilon);
[~,d_estimator] = size(z_mean);
Y = laprnd(1, d_estimator, 0, noise_sd);
T_star = z_mean+Y;


