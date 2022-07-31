
rm(list = ls(all = TRUE))
source("./docs/necessary-libraries.R")
load("./data/simulation-data.rda")
load("./data/simulation-model.rda")


# 普遍5%关税
t_start <- rep(0.05, N * N) %>% matrix(nrow = N) - diag(N) * 0.05


model_tariff_mobile <- function(t) {
  # 不变参数
  w <- effective_wage
  Y <- Y
  T <- absolute_tech
  D <- Dni
  k <- g * T * w^(-beta * theta)



  # 可变参数
  t <- rep(0.05, N * N) %>% matrix(nrow = N) - diag(N) * 0.05
  DT <- (t + 1)^(-theta) * Dni %>%
    set_colnames(rep("", N))

  equations <- function(P) {
    DT %*% (k * P^(1 - beta)) - P
  }

  P <- rootSolve::multiroot(
    f = equations, start = P_start,
    rtol = 1e-10, positive = TRUE
  )$root


  Pi <- DT * kronecker(1 / P, t(k * P^(1 - beta)))


  # average tariff 系数
  at <- (Pi * t / (1 + t)) %*% rep(1, N) # 或 %*% apply(1, sum)
  s <- 1 / (1 - alpha * at)
  E <- t(1 / (1 + t)) * t(Pi)

  L <- alpha * beta * (1 / (s * w)) *
    (solve(diag(1 / s) - (1 - beta) * E) %*% E %*% (s * Y))

  Xn <- s * (w * L * (1 - beta) / beta + alpha * Y)
  TR <- at * Xn

  Xni <- Pi * kronecker(Xn, rep(1, N) %>% t())

  trade_volumn <- sum(Xni) - diag(Xni) %>% sum()

  W <- (Y + TR) * P^(alpha / theta)

  list(
    p = P^(-1 / theta), L = L %>% as.vector(), W = W,
    Xni = Xni, trade_volumn = trade_volumn
  )
}

baseline_tariff_mobile <- model_tariff_mobile(t_start)