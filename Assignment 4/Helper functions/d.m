function [d1,d1_star] = d(S, K, r, sigma, T, t_c)
d1 = (log(S./K) + T*(r + sigma^2/2))./(sigma*sqrt(T));
d1_star = (log(S./K) + T*r + t_c*(sigma^2/2))./(sigma*sqrt(t_c));