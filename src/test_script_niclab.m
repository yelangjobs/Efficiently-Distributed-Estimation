clear;

addpath('../lib/');

%N = 1:20;         % Number of Groups
S = 200:100:1000   % Group Size
N = [5 10 15 20]
d = 1;            % Data Dimension

m       = 20;
itr     = 5000;
lambda  = 2;
epsilon = 0.01;

T = zeros(size(N,2),size(S,2));

for i = 1:size(N,2)
    for j = 1:size(S,2)
        T_itr = zeros(1,itr)
        n = N(i)
        s = S(j)
        fprintf('%d groups with %d elements',n,s)
        for h = 1:itr
            % Initialize Data
            data  = random('Poisson',m, [s,n])
            T_tmp = zeros(1,n)
            for a = 1:n
                T_tmp(a) = sample_and_aggregate(data(:,a), epsilon, lambda, @mean);
            end
            T_itr(h) = mean(T_tmp)
            fprintf('itr = %d',h)
        end
        T(i,j) = mean(T_itr)
    end
end

save('../data/exp160526_S1000_itr5000.mat')

