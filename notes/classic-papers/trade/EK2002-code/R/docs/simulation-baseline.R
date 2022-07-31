
rm(list = ls(all = TRUE))
source("./docs/necessary-libraries.R")
load("./data/simulation-data.Rdata")

############################################
# Section 4 General Equilibrium
# 求一般均衡模型（非线性方程组）在两种情境下各变量值的 baseline 水平
############################################

# 令 k = gTw^(-beta*theta)
# 而由 (27) 知 Tw^(-beta*theta)=exp(beta*S)
# 所以 k = g*exp(beta*S)
k <- g * exp(beta * source_estimate)

# 设定P的迭代初值
P_low <- k^(1 / beta)
P_high <- rep(sum(k)^(1 / beta), N)
P_start <- (P_low + P_high) / 2

############################################
# 情境一：劳动力可以跨部门流动
############################################

model_mobile <- function(tech, Dni) {
  # 不变参数
  w <- effective_wage
  Y <- Y

  # 可变参数
  T <- tech
  D <- Dni
  k <- g * T * w^(-beta * theta)

  equations <- function(P) {
    solve(D) %*% P - k * P^(1 - beta)
  }

  if (identical(D, matrix(rep(1, N^2), nrow = N))) {
    P <- P_high
  } else {
    P <- rootSolve::multiroot(
      f = equations, start = P_start,
      rtol = 1e-10, positive = TRUE
    )$root
  }

  Pi <- D * kronecker(1 / P, t(k * P^(1 - beta)))

  L <- alpha * beta * (1 / w) *
    (solve(diag(N) - (1 - beta) * t(Pi)) %*% t(Pi) %*% Y)

  Xn <- w * L * (1 - beta) / beta + alpha * Y

  Xni <- Pi * kronecker(Xn, rep(1, N) %>% t())

  trade_volumn <- sum(Xni) - diag(Xni) %>% sum()

  W <- Y * P^(alpha / theta)

  list(
    p = P^(-1 / theta), L = L %>% as.vector(), W = W,
    Xni = Xni, trade_volumn = trade_volumn
  )
}

baseline_mobile <- model_mobile(absolute_tech, Dni)


############################################
# 情境二：劳动力不能跨部门流动
############################################

model_immobile <- function(tech, Dni) {
  # 不变参数
  L <- effective_labor
  Y_o <- Y_o

  # 可变参数
  T <- tech
  D <- Dni

  # w 初始值
  w <- effective_wage

  for (i in 1:1000) {
    k <- g * T * w^(-beta * theta)

    equations <- function(P) {
      solve(D) %*% P - k * P^(1 - beta)
    }

    P <- rootSolve::multiroot(
      f = equations, start = P_start,
      rtol = 1e-10, positive = TRUE
    )$root

    Pi <- D * kronecker(1 / P, t(k * P^(1 - beta)))

    # 用 (21) 式计算制造业收入(世界市场对各国制造业产品的需求)
    Y_l <- (1 - beta + alpha * beta) * t(Pi) %*% (w * L) +
      alpha * beta * t(Pi) %*% Y_o

    # 超额劳动引致需求
    excess_labor_ratio <- (as.vector(Y_l) / w - L) / L

    tolerance <- sum(excess_labor_ratio^2) %>% sqrt()

    if (tolerance < 1e-9) {
      Xn <- w * L * (alpha + (1 - beta) / beta) + alpha * Y_o
      Xni <- Pi * kronecker(Xn, rep(1, N) %>% t())
      trade_volumn <- sum(Xni) - diag(Xni) %>% sum()
      W <- (w * L + Y_o) * P^(alpha / theta)

      return(list(
        p = P^(-1 / theta), w = w, W = W,
        Xni = Xni, trade_volumn = trade_volumn
      ))
    } else {
      w <- w + excess_labor_ratio * 0.3 * w
      print(str_c("iterator: ", i))
    }
  }

  print("not convergent")
}

baseline_immobile <- model_immobile(absolute_tech, Dni)


##

save(
  model_mobile, baseline_mobile,
  model_immobile, baseline_immobile,
  P_low, P_high, P_start,
  file = "./data/simulation-model.rda"
)
