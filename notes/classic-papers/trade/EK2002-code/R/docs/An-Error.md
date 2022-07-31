### EK2002 中的一个计量错误

#### 1

作者推导出 $(28)$ 式 
$$
\ln \frac{X'_{ni}}{X'_{nn}}=-\theta \ln d_{ni} + S_i-S_n \tag{28}
$$
以后，如果要用此式估计 $\theta$，虚拟变量 $S_i$ 和 $S_n$ 应该都是来源国（技术和工资）效应，而非目的地国的贸易壁垒效应。也就是说，无论有多少行数据，右边的虚拟变量最多有 $19-1=18$ 列。

在 <span style='color: blue'>**Section 5.1**</span> 中，虽然他将 $\ln d_{ni}$ 再细化为一堆变量，做了两阶段最小二乘法，但看 Table III 的最终结果，左下方 Source Country 那一栏里，就是只有 $S_1$~$S_{19}$.



#### 2

然后在 <span style='color: blue'>**Section 5.3**</span> 中，作者试图不再拆解 $\ln d_{ni}$，而直接用 $(28)$ 式估计 $\theta$. 

本来，可以用 $\max 2_{j}\left\{r_{n i}(j)\right\}$ 作为 $d_{ni}$ 的代理变量，前面也明明算出来了。但作者偏偏不用，而非要跟 <span style='color: blue'>**Section 3**</span> 一样，用 $D_{ni}$ 作为 $\ln \left(p_{i} d_{n i} / p_{n}\right)$ 的代理变量。于是，$(28)$ 式似乎就变成了这个样子：
$$
\ln \frac{X'_{ni}}{X'_{nn}}= -\theta \ln d_{ni} + S_i-S_n= -\theta D_{ni} + (S_i+\theta\ln p_i)-(S_n+\theta \ln p_n)  \tag{28'}
$$
假如记 $R_i \equiv S_i+\theta\ln p_i$，上式就可以写为
$$
\ln \frac{X'_{ni}}{X'_{nn}}=-\theta \ln D_{ni} + R_i-R_n \tag{28''}
$$
然后就能估计 $\theta$ 和新的虚拟变量系数——$R_i$ 了，其中不仅包含了来源国的技术和工资，还包含了价格水平因素，用作者的原话说就是：

> The coefficient on $D_{ni}$ provides yet another estimate of $\theta$. (The estimated source effects reflect the price level terms in $D_{ni}$ as well as technology and wages, making them harder to interpret.)

这样做不是不可以，但 $R_i$ 和 $R_n$ 也都仅和一国的特征有关，都是来源国效应，则 $(28'')$ 式右边的虚拟变量同样最多是 $19-1=18$ 列。

可是，作者莫名其妙地在此处区分了来源国效应和目的地国效应，除了 $\ln D_{ni}$ 以外，还设置了 $18\times 2=36$ 个虚拟变量。然后左边的因变量对这 $37$ 个自变量作 OLS 回归，最后才得出了他论文中的 $\theta$ 值: $-2.44(0.49)$.

我用作者的数据也跑了一下回归，的确是加入了 $36$ 个虚拟变量，才能跑出这个 $\theta$ 值。如果只加入代表来源国效应的 $18$ 个虚拟变量，$\theta$ 的估计值应该是 $-4.04(0.48)$，要比那个错误的估计方法更接近其他模型的估计值。

作者犯这个错误，从 source code 来看，是因为他先做的 Table III （也就是 $(30)$ 式）中的回归，那里面需要来源国效应和目的地国效应共 $36$ 个虚拟变量，然后才做的 $(28'')$ 式的回归——但他<span style='color: red'>**直接复制了上一次所用的虚拟变量矩阵**</span>，忘记这个矩阵里面含有目的地国效应了。
