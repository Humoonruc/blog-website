[TOC]

## 运算符

[R 基础运算 | 菜鸟教程 (runoob.com)](https://www.runoob.com/r/r-basic-operators.html)

### 赋值运算符

`<-` 不能修改作用域以外的变量，赋值**有返回值**

`<<-` **可以修改作用域以外的变量**，赋值**有返回值**

`=`，赋值没有返回值

### 数学运算符

`+`

`-`

`*`

`/`

`^`/`**` 乘方

`%/%` 整除

`%%` 取余



### 关系运算符

### 逻辑运算符

`&` 向量化与

`|` 向量化或

`!`

`&&` 单值与，短路运算，只要前一个表达式为 FALSE，后面的表达式就不会再计算，直接返回 FALSE

```R
# 替代 if 表达式：
num < 0 && return(FALSE) # 只有 num<0 时才会返回，否则 do nothing
```

`||` 单值或

### 包含运算符

`%in%`



