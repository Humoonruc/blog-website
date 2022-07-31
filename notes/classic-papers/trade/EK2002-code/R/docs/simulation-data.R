## data transformation for simulation

rm(list = ls(all = TRUE))
source("./docs/necessary-libraries.R")

############################################
# read data
############################################

# 一些标量常数
scalar <- jsonlite::fromJSON("./data/scalar.json")

# 国家代码表
country_table <- fread("./data/country_code.csv")

# 国别原始数据
nominal_variables <- fread("./data/nominal_variable.csv")

# TABLE III 中所有虚拟变量的系数估计值
load("./data/estimation-output.rda")


############################################
# data transformation
############################################

## 1. scalars
beta <- scalar$beta
N <- scalar$N
theta <- scalar$theta[2]


## 2. exchange rate
exchange_rate <- nominal_variables$exchange_rate
exchange_rate_matrix <- kronecker(exchange_rate, t(rep(1, N)))


## 3. trade data

# nominal bilateral trade
Xni_nominal <- nominal_variables[, -1:-6] %>%
  as.matrix() %>%
  `*`(10^6) %>%
  set_colnames(rep("", N))

# real bilateral trade
Xni <- Xni_nominal / exchange_rate_matrix
Xnn <- diag(Xni) # vector

# expenditure on manufacturing goods
Xn <- Xni %>% apply(1, sum) # vector

imports <- Xn - Xnn
exports <- Xni %>% apply(2, sum) - Xnn


## 4. manufacturing labor and wage
industrial_labor <- nominal_variables$industrial_labor
nominal_wage <- nominal_variables$nominal_wage # 已经以美元计价
edu_year <- nominal_variables$edu_year

effective_labor <- industrial_labor * exp(0.06 * edu_year)
effective_wage <- nominal_wage * exp(-0.06 * edu_year)


## 5. income/expenditure

# read gdp
Y <- nominal_variables$gdp * 1000000 / exchange_rate

# manufacturing labor income
Y_l <- effective_wage * effective_labor

# nonmanufacturing income
Y_o <- Y - Y_l


## 6. beta and alpha

# beta = manufacturing labor income / manufacturing output
beta_vector <- Y_l / (Xnn + exports)
beta_vector
# 不知作者如何加权得出了 beta=0.21221 这个数值

# alpha = manufacturing expenditure / total expenditure
alpha_vector <- (Y_l + imports - exports) / Y
alpha_vector

# 各国按GDP加权求一个总的 alpha
alpha <- (alpha_vector * Y / sum(Y)) %>% sum()
alpha

## 7. technology
# 表示技术的 T 来源于 (27) 式
# 计算所需的 source dummies 的估计系数见 TABLE VI
source_estimate <- table3_estimate[11:29]

# 这个 tech 使用的都是绝对数据
# 用绝对数据，保持准确量纲，便于 wL 直接与 Y/Y_o 相比
absolute_tech <- log(effective_wage) %>%
  `*`(theta) %>%
  `+`(source_estimate) %>%
  `*`(beta) %>%
  exp()


## 8. geography barrier
# dni^{-theta} 矩阵
Dni <- exp(barrier_measure)
# barrier_measure 来源于 (28) 式，为 -theta ln(dni)
# 用 (30) 式计算 -theta ln(dni) 时，所需的 barrier dummies 的估计系数见 TABLE VII


## 9. gamma constant
gamma <- beta^(beta) * (1 - beta)^(1 - beta)
# 不知为何 gamma 可以由 beta 推出
g <- gamma^(-theta)


############################################
# save all variables as R binary file
############################################
save.image("./data/simulation-data.rda")