

[TOC]

# Basic Grammar

## Variable

### `const` 关键字

声明为常量，不允许重新赋值

一般用于一些全局变量

### 变量名

自定义的 Type 和 Module 首字母大写，驼峰式

变量和函数首字母小写，蛇形

会就地修改参数的函数名后加 `!`



可以用希腊字母、中文等字符为变量命名，这非常 cool 😎

特别是，还接受上标和下标！！！

```julia
aₙ = 3 # \_n TAB
bᵞ = 5 # \^gamma TAB
```



### 变量赋值

Julia 支持解构赋值，一次性赋值多个变量



## Expression & Statement

Julia 的表达式都有返回值

特别是赋值表达式，可以直接作为 return 的对象



## Operator

### 分类

二元 operator 本质上都是二元函数

#### 算数

| operator           |                                                       |
| ------------------ | ----------------------------------------------------- |
| `+`                |                                                       |
| `-`                |                                                       |
| `*`                | 乘法，数乘时可以省略`*`，连写数字与变量；字符串的串联 |
| `/`                | 返回 float                                            |
| `÷` (**\div TAB**) | 取整除法（floor division），返回 int                  |
| `^`                | 幂；字符串的复制                                      |
| `%`                | 取余（modulus）                                       |

#### 赋值

**解构赋值**：左边为元组（可以省略括号），右边为任何类型的序列（string, vector, tuple, …）

交换赋值 `a, b = b, a`

#### 位

#### Logical

- `&&`
- `||`
- `!`

#### Relational

##### 大小

`≠` (**\ne TAB**)

`≥` (**\ge TAB**)

`≤` (**\le TAB**)


大小运算符的链式比较

```julia
julia> 1 < 2 <= 2 < 3 == 3 > 2 >= 1 == 1 < 3 != 5
true
```

这可以避免条件嵌套，如以下两种写法都比较繁冗

```julia
if 0 < x
    if x < 10
        println("x is a positive single-digit number.")
    end
end

if 0 < x && x < 10
    println("x is a positive single-digit number.")
end
```

可以改写为：

```julia
if 0 < x < 10
    println("x is a positive single-digit number.")
end
```

##### 种属

`isa`

##### 包含

`in` `∈` `∉`

##### 集合

`⊆` (**\subseteq TAB**) 特别适合检查字符串和序列

`∩` (**\cap TAB**)

##### 是否同一

指向同一个对象（内存地址）

`≡` (**\equiv TAB**) 或 `===`

相等不一定同一，同一一定相等

```julia
a = "banana" 
b = "banana"
a ≡ b # true，内存中只有一个 banana

c = [1, 2, 3]
d = [1, 2, 3]
c ≡ d # false，内存中有两个 Vector

e = [1, 2, 3]
f = e
e ≡ f # true
```

不可变对象，有别名时不会发生变量拷贝；可变对象，有别名时会有数据拷贝。


特别地，对于 mutable struct，`==` 操作符的默认行为与 `≡`/`===` 一样，因为它不会判断组合类型如何才算相等，只能判断同一。

#### iterator 展开符号

`iterator...` 展开为逗号间隔的参数 args…，再传给其他函数

#### Type Annotation

`::`

```julia
function returnfloat()
    x::Float64 = 100 # 在赋值表达式左边使用`::`，不能用于全局变量
    x
end

returnfloat()
```

### Operator Precedence

小括号 > 幂 > 乘除 > 加减

### Operators Overloading

```julia
import Base.+

function +(p1::Point, p2::Point)
   Point(p1.x + p2.x, p1.y + p2.y) 
end
```



## Comment

单行 `#`

多行 `#= ... =#`



公式用双反引号和 Unicode 字符，形如

```markdown
``α=1``
```



