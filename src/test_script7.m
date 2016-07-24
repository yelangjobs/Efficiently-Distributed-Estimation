clear;

addpath('../lib/');

GLM_mean = 20;
n = 100:10:2000;
n_Lambda = 5;
n_k = 50;
itr = 1000;

Lambda = linspace(0,10,n_Lambda);
k = 0:5:n_k;
T_temp = zeros(1,itr);
T_mean = zeros(size(n,2),size(Lambda,2),size(k,2));
T_error = zeros(size(n,2),size(Lambda,2),size(k,2));

for p = 1:size(n,2)
    for i = 1:size(Lambda,2)
        for j = 1:size(k,2)
            for h = 1:itr
                x = GLM_mean + wgn(n(p), 1, 4); %% GLM with mean 20, n = 1000, power = 4
                T_temp(h) =  sample_and_aggregate(x, 0.1, Lambda(i), @mean, k(j)); %% choose epsilon = 0.1, Lambda = 5, estimator = sample mean
            end
            T_mean(p,i,j) = mean(T_temp)
            T_error(p,i,j) = sum((T_temp-20).^2)
        end
    end
end

save('../data/exp160519_4.mat')

