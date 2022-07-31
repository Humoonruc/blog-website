

[TOC]

## Estimation

- [ ] dist_etc 改名 common_barrier
- [ ] EU 改名 both_in_EEC，EFTA 改名 both_in_EFTA，同理有 share_border, share_langugage
- [ ] 距离变量只保留一个，后面计算时再 transform



## Section 6.4 Tariff

### 关税的影响

从价税率矩阵：
$$
\boldsymbol{t}=\begin{bmatrix}
t_{11} & t_{12} & \cdots & t_{1N} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
t_{N1} & t_{N2} & \cdots & t_{NN}
\end{bmatrix}
$$

其中 $t_{ii}=0$



贸易障碍增加了一个税率成分
$$
\boldsymbol{DT} = \begin{bmatrix}
(1+t_{11})^{-\theta} & (1+t_{12})^{-\theta} & \cdots & (1+t_{1N})^{-\theta} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
(1+t_{N1})^{-\theta} & (1+t_{N2})^{-\theta} & \cdots & (1+t_{NN})^{-\theta}
\end{bmatrix} \circ \boldsymbol{D}
$$



出口国的出口收入也不再与进口国的进口支出相等，(18) 式变为
$$
\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix} =\beta \left( \begin{bmatrix}
\frac{1}{1+t_{11}} & \frac{1}{1+t_{12}} & \cdots & \frac{1}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{1}{1+t_{N1}} & \frac{1}{1+t_{N2}} & \cdots & \frac{1}{1+t_{NN}}
\end{bmatrix}' \circ \boldsymbol{\Pi}' \right) \begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} \tag{18'}
$$


(16) 式变为
$$
\boldsymbol{DT}^{-1}\begin{bmatrix}
 P_1 \\ \vdots \\ P_N
\end{bmatrix} - g \cdot \begin{bmatrix}
 T_1 \\ \vdots \\ T_N
\end{bmatrix}  \circ \begin{bmatrix}
 w_1^{-\beta\theta} \\ \vdots \\ w_N^{-\beta\theta}
\end{bmatrix} \circ \begin{bmatrix}
 P_1^{1-\beta} \\ \vdots \\ P_N^{1-\beta}
\end{bmatrix} = \boldsymbol{0} \tag{16'}
$$
(17) 式变为
$$
\boldsymbol{\Pi}=\boldsymbol{DT} \circ \left(  \begin{bmatrix}
 1/P_1 \\ \cdots \\ 1/P_N
\end{bmatrix}\otimes \left( g \cdot \begin{bmatrix}
 T_1 \\ \vdots \\ T_N
\end{bmatrix}  \circ \begin{bmatrix}
 w_1^{-\beta\theta} \\ \vdots \\ w_N^{-\beta\theta}
\end{bmatrix} \circ \begin{bmatrix}
 P_1^{1-\beta} \\ \vdots \\ P_N^{1-\beta}
\end{bmatrix}\right)'\right) \tag{17'}
$$
同时知
$$
\boldsymbol{X} \equiv \begin{bmatrix}
X_{11} & X_{12} & \cdots & X_{1N} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
X_{N1} & X_{N2} & \cdots & X_{NN}
\end{bmatrix}=\boldsymbol{\Pi} \circ \left(\begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} \otimes [1 \cdots 1] \right)
$$



#### Mobile labor

由 (16’) 可解出各国价格，再由 (17’) 可知 $\pi_{ni}$



(19) 式变为
$$
\begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} =\begin{bmatrix}
 w_1 \\ \vdots \\ w_N
\end{bmatrix} \circ \begin{bmatrix}
 L_1 \\ \vdots \\ L_N
\end{bmatrix} *(1-\beta)/\beta+\alpha \left(\begin{bmatrix}
Y_1 \\ \vdots \\ Y_N
\end{bmatrix}+\boldsymbol{TR}\right) \tag{19-1}
$$



关税收入向量
$$
\begin{aligned} 
\boldsymbol{TR} &\equiv \left(\begin{bmatrix}
\frac{t_{11}}{1+t_{11}} & \frac{t_{12}}{1+t_{12}} & \cdots & \frac{t_{1N}}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{t_{N1}}{1+t_{N1}} & \frac{t_{N2}}{1+t_{N2}} & \cdots & \frac{t_{NN}}{1+t_{NN}}
\end{bmatrix} \circ \boldsymbol{X}\right) \begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix} \\ &=\left(\begin{bmatrix}
\frac{t_{11}}{1+t_{11}} & \frac{t_{12}}{1+t_{12}} & \cdots & \frac{t_{1N}}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{t_{N1}}{1+t_{N1}} & \frac{t_{N2}}{1+t_{N2}} & \cdots & \frac{t_{NN}}{1+t_{NN}}
\end{bmatrix} \circ \boldsymbol{\Pi} \circ \left(\begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} \otimes [1 \cdots 1] \right) \right) \begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix} \\
& = \left(\begin{bmatrix}
\frac{t_{11}}{1+t_{11}} & \frac{t_{12}}{1+t_{12}} & \cdots & \frac{t_{1N}}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{t_{N1}}{1+t_{N1}} & \frac{t_{N2}}{1+t_{N2}} & \cdots & \frac{t_{NN}}{1+t_{NN}}
\end{bmatrix} \circ \boldsymbol{\Pi} \right)\begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix} \circ \begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix}
\end{aligned}
$$
定义 average tariff 系数
$$
\boldsymbol{at} \equiv \left(\begin{bmatrix}
\frac{t_{11}}{1+t_{11}} & \frac{t_{12}}{1+t_{12}} & \cdots & \frac{t_{1N}}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{t_{N1}}{1+t_{N1}} & \frac{t_{N2}}{1+t_{N2}} & \cdots & \frac{t_{NN}}{1+t_{NN}}
\end{bmatrix} \circ \boldsymbol{\Pi} \right)\begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix}
$$
则有
$$
\boldsymbol{TR} = \boldsymbol{at} \circ \begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix}
$$
将 $\boldsymbol{TR}$ 带入 (19-1)，可得
$$
\left(\begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix}-\alpha \cdot \boldsymbol{at} \right) \circ \begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} =\begin{bmatrix}
 w_1 \\ \vdots \\ w_N
\end{bmatrix} \circ \begin{bmatrix}
 L_1 \\ \vdots \\ L_N
\end{bmatrix} *(1-\beta)/\beta+\alpha\begin{bmatrix}
Y_1 \\ \vdots \\ Y_N
\end{bmatrix} \tag{19-2}
$$
必有 $\boldsymbol{s} \circ \left(\begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix}-\alpha \cdot \boldsymbol{at} \right)=\begin{bmatrix}
1 \\ \vdots \\ 1
\end{bmatrix}$，从而 (19-2) 可写为
$$
\begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} =\boldsymbol{s} \circ \left(\frac{1-\beta}{\beta}\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix}+\alpha\begin{bmatrix}
Y_1 \\ \vdots \\ Y_N
\end{bmatrix}\right) \tag{19-3}
$$


 (19-3) 式给出了支出与收入的关系，将其带入 (18’) 可得
$$
\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix} =\beta \left( \begin{bmatrix}
\frac{1}{1+t_{11}} & \frac{1}{1+t_{12}} & \cdots & \frac{1}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{1}{1+t_{N1}} & \frac{1}{1+t_{N2}} & \cdots & \frac{1}{1+t_{NN}}
\end{bmatrix}' \circ \boldsymbol{\Pi}' \right) \left(\boldsymbol{s} \circ \left(\frac{1-\beta}{\beta}\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix}+\alpha\begin{bmatrix}
Y_1 \\ \vdots \\ Y_N
\end{bmatrix}\right)\right) \tag{18''}
$$

只需移项、合并同类项、数乘，即可算出 $L_n$

令 $\boldsymbol{E} =  \begin{bmatrix}
\frac{1}{1+t_{11}} & \frac{1}{1+t_{12}} & \cdots & \frac{1}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{1}{1+t_{N1}} & \frac{1}{1+t_{N2}} & \cdots & \frac{1}{1+t_{NN}}
\end{bmatrix}' \circ \boldsymbol{\Pi}' $，则有
$$
L=\alpha\beta \begin{bmatrix}
\frac{1}{s_1w_1} \\ \vdots \\ \frac{1}{s_Nw_N}
\end{bmatrix} \left(\begin{bmatrix}
1/s_1 & 0 & \cdots & 0 \\ 
\vdots & \vdots & \vdots & \vdots \\ 
0 & 0 & \cdots & 1/s_N
\end{bmatrix}-(1-\beta)\boldsymbol{E}\right)^{-1}\boldsymbol{E}\begin{bmatrix}
s_1Y_1 \\ \vdots \\ s_NY_N
\end{bmatrix}
$$


代回 (19-3) 可得支出向量，继而可计算关税收入向量 $\boldsymbol{TR}$ 和双边贸易矩阵 $\boldsymbol{X}$

福利水平
$$
\begin{bmatrix}
W_1 \\ \vdots \\ W_N
\end{bmatrix} =\left(\begin{bmatrix}
Y_1 \\ \vdots \\ Y_N
\end{bmatrix}+ \boldsymbol{TR}\right) \circ \begin{bmatrix}
P_1^{\alpha/\theta} \\ \vdots \\ P_N^{\alpha/\theta}
\end{bmatrix}
$$



#### Immobile labor

(19) 式变为
$$
\begin{bmatrix}
X_1 \\ \vdots \\ X_N
\end{bmatrix} =\boldsymbol{s} \circ \left(\left(\frac{1-\beta}{\beta}+\alpha\right)\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix}+\alpha\begin{bmatrix}
Y_1^o \\ \vdots \\ Y_N^o
\end{bmatrix}\right) \tag{19-4}
$$
将其带入 (18’)，得
$$
\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix} =\beta \left( \begin{bmatrix}
\frac{1}{1+t_{11}} & \frac{1}{1+t_{12}} & \cdots & \frac{1}{1+t_{1N}} \\ 
\vdots & \vdots & \vdots & \vdots \\ 
\frac{1}{1+t_{N1}} & \frac{1}{1+t_{N2}} & \cdots & \frac{1}{1+t_{NN}}
\end{bmatrix}' \circ \boldsymbol{\Pi}' \right) \left(\boldsymbol{s} \circ \left(\left(\frac{1-\beta}{\beta}+\alpha\right)\begin{bmatrix}
 w_1L_1 \\ \vdots \\ w_NL_N
\end{bmatrix}+\alpha\begin{bmatrix}
Y_1^o \\ \vdots \\ Y_N^o
\end{bmatrix}\right)\right) \tag{18-2}
$$
其中非制造业收入 $Y_n^o$、制造业劳动力 $L_n$ 为常量。但这 $N$ 个方程无法解出工资向量 $w_n$，因为 $\boldsymbol{\Pi}$ 中不仅含有 $w_n$，还含有 $P_n$

(18-2) 这 $N$ 个方程需要与 (16’) 式代表的 $N$ 个方程联立，才能解出 $w_n$ 和 $P_n$. 

然后依次推导其余变量，如 (19-4)  式得支出向量、双边贸易矩阵 $\boldsymbol{X}$ 和福利：
$$
\begin{bmatrix}
W_1 \\ \vdots \\ W_N
\end{bmatrix} = \left( \begin{bmatrix}
 w_1 \\ \vdots \\ w_N
\end{bmatrix} \circ \begin{bmatrix}
 L_1 \\ \vdots \\ L_N
\end{bmatrix} + \begin{bmatrix}
Y_1^o \\ \vdots \\ Y_N^o
\end{bmatrix}+ \boldsymbol{TR} \right) \circ \begin{bmatrix}
P_1^{\alpha/\theta} \\ \vdots \\ P_N^{\alpha/\theta}
\end{bmatrix}
$$





