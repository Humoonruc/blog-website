# Influence Sphere of the Three Trade Superpowers



#### 数据源

1. 各国与中、美、德的双边进出口数据
2. 世界地图

#### 数据处理

1. 各国与美、中、德三国的贸易总量，做标准化处理。
2. 美国蓝色`rgb(0,0,255)`，中国红色`rgb(255,0,0)`，德国绿色`rgb(0,255,0)`，为三个向量。各国颜色按贸易占比，数乘三国颜色向量再加总，便可得各国的颜色向量，即 255*[对华贸易占比, 对德贸易占比, 对美贸易占比]
3. 因此每条数据作为一个对象，有3个属性，即 id/code/name，year，color
4. 对各国着色。
5. 随时间变化（d3自动对颜色插值）。
