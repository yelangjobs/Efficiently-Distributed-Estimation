clear;

addpath('../lib/');

GLM_mean = 20;
n = 1000;
n_Lambda = 1000;
n_k = 1000;
itr = 1000;

Lambda = linspace(0,20,n_Lambda);
k = 0:1:n_k;
T_temp = zeros(1,itr);
T = zeros(n_Lambda,n_k);

for i = 1:n_Lambda
    for j = 1:n_k+1
        for h = 1:itr
            x = GLM_mean + wgn(n, 1, 4); %% GLM with mean 20, n = 1000, power = 4
            T_temp(h) =  sample_and_aggregate(x, 0.1, Lambda(i), @mean, k(j)); %% choose epsilon = 0.1, Lambda = 5, estimator = sample mean
        end
        T(i,j) = mean(T_temp)
    end
end

save('../data/exp160511_n1000_itr1000.mat')

