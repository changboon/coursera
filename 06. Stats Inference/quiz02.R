2.
pnorm(70, mean = 80, sd = 10, lower.tail = TRUE)

3.
qnorm(0.95, mean = 1100, sd = 75)

4.
mean = 1100
n = 100
sd = 75
se = sd/sqrt(n)
mean + (1.65 * se)

5.
1-pbinom(3, size=5, prob=0.5) 

6.
pnorm(16, mean=15, sd=1) - pnorm(14, mean=15, sd=1)

7.
mean = 0.5
sd = sqrt(1/12)
n = 1000
se = sd/sqrt(n)
0.5 + (1.65 * se)

8.
x <- 5
t <- 1/3
lambda <- x/t
ppois(10, lambda = lambda)
