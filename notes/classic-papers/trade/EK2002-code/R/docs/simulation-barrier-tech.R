# Section 6.1-6.3

rm(list = ls(all = TRUE))
source("./docs/necessary-libraries.R")
load("./data/simulation-data.rda")
load("./data/simulation-model.rda")


############################################
# 改变贸易障碍，贸易障碍可以定义为 dni-1
############################################

# TABLE IX

D_autarky <- diag(19)

autarky_mobile <- model_mobile(absolute_tech, D_autarky)
100 * log(autarky_mobile$W / baseline_mobile$W)
100 * log(autarky_mobile$p / baseline_mobile$p)
100 * log(autarky_mobile$L / baseline_mobile$L)

autarky_immobile <- model_immobile(absolute_tech, D_autarky)
100 * log(autarky_immobile$W / baseline_immobile$W)
100 * log(autarky_immobile$p / baseline_immobile$p)
100 * log(autarky_immobile$w / baseline_immobile$w)


# TABLE X
D_zero_barrier <- kronecker(rep(1, N), rep(1, N) %>% t())
zero_barrier_mobile <- model_mobile(absolute_tech, D_zero_barrier)
100 * log(zero_barrier_mobile$W / baseline_mobile$W)
100 * log(zero_barrier_mobile$p / baseline_mobile$p)
100 * log(zero_barrier_mobile$L / baseline_mobile$L)
zero_barrier_mobile$trade_volumn / baseline_mobile$trade_volumn


D_double_trade <- (Dni^(-1 / theta)) %>% # dni
  `-`(1) %>% # dni-1，可以认为这是贸易障碍（加价程度）
  `*`(0.667) %>% # 贸易障碍变为实际水平的 66.7%
  `+`(1) %>% # 新的 dni
  `^`(-theta)
double_trade_mobile <- model_mobile(absolute_tech, D_double_trade)
double_trade_mobile$trade_volumn / baseline_mobile$trade_volumn
# 此时为两倍贸易量


# FIGURE 3

# 按一定倍率放缩地理障碍 dni-1
scale <- 2^seq(from = -4, to = 4, by = 0.25)

scale %>%
  map( # 返回的列表的每个元素都是一个经过放缩的 Dni 矩阵
    ~ (Dni^(-1 / theta)) %>%
      `-`(1) %>% # dni-1 是贸易障碍
      `*`(.x) %>% # 放缩倍数
      `+`(1) %>%
      `^`(-theta)
  ) %>%
  map_dfc( # 返回的数据框的每列都是各国制造业的就业占比
    ~ alpha * model_mobile(absolute_tech, .x)$L / autarky_mobile$L
  )

# 技术和地理的各自作用：
# 零障碍时，制造业就业占比（反映国际需求和一国的绝对优势）完全由技术和工资决定
# 但贸易障碍非零时，影响制造业就业占比的还有地理因素
# 德国、美国等大国目前（对贸易障碍的放缩程度为1）的制造业就业占比要比零障碍时高
# 表明它们现在的制造业规模受益于地理因素
# 而小国在当前的阶段受害于地理因素
# 地理因素就是 TABLE VII 中的29个虚拟变量，包括区位、语言、贸易协定、


############################################
# 改变技术
############################################

# TABLE XI

# 美国技术进步
tech_US <- inset(rep(1, N), N, 1.2) * absolute_tech

tech_US_mobile <- model_mobile(tech_US, Dni)
benefits_mobile <- 100 * log(tech_US_mobile$W / baseline_mobile$W)
normalized_benefits_mobile <- 100 * benefits_mobile / benefits_mobile[N] # 除以美国
normalized_benefits_mobile

tech_US_immobile <- model_immobile(tech_US, Dni)
benefits_immobile <- 100 * log(tech_US_immobile$W / baseline_immobile$W)
normalized_benefits_immobile <- 100 * benefits_immobile / benefits_immobile[N] # 除以美国
normalized_benefits_immobile

# 德国技术进步
tech_GE <- inset(rep(1, N), 8, 1.2) * absolute_tech

tech_GE_mobile <- model_mobile(tech_GE, Dni)
benefits_mobile <- 100 * log(tech_GE_mobile$W / baseline_mobile$W)
normalized_benefits_mobile <- 100 * benefits_mobile / benefits_mobile[8] # 除以德国
normalized_benefits_mobile

tech_GE_immobile <- model_immobile(tech_GE, Dni)
benefits_immobile <- 100 * log(tech_GE_immobile$W / baseline_immobile$W)
normalized_benefits_immobile <- 100 * benefits_immobile / benefits_immobile[8] # 除以美国
normalized_benefits_immobile