clear;

addpath('../lib/');

GLM_mean = 20;
n = 100:100:2000;
n_Lambda = 100;
n_k = 200;
itr = 10000;

Lambda = linspace(0,20,n_Lambda);
k = 0:5:n_k;
T_temp = zeros(1,itr);
T = zeros(size(n,2),size(Lambda,2),size(k,2));


for p = 1:size(n,2)
    for i = 1:size(Lambda,2)
        for j = 1:size(k,2)
            for h = 1:itr
                x = GLM_mean + wgn(n(p), 1, 4); %% GLM with mean 20, n = 1000, power = 4
                T_temp(h) =  sample_and_aggregate(x, 0.1, Lambda(i), @mean, k(j)); %% choose epsilon = 0.1, Lambda = 5, estimator = sample mean
            end
            T(p,i,j) = mean(T_temp)
        end
    end
end

save('../data/exp160518.mat')

