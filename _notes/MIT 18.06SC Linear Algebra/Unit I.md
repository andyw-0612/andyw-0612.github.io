---
title: "Unit I"
has_parent: "MIT 18.06SC Linear Algebra"
---
<header>
Ax = b, and the Four Subspaces
</header>

Unit 1 of [[MIT 18.06SC Linear Algebra]]

<hr>
## Table of Contents
{:.no_toc .toc-heading}
1. 
{:toc}

<hr>

## The Geometry of Linear Equations

The lecture overview and resources can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/pages/ax-b-and-the-four-subspaces/the-geometry-of-linear-equations/). The lecture summary can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/resources/mit18_06scf11_ses1-1sum/).

### Objectives

- _n_ linear equations, _n_ unknowns
- Row picture
- ==Column picture==
- Matrix form

### Lecture

Take $2x-y=0, -x+2y=3$, its matrix form with its coefficients would be 

$$ \begin{bmatrix} 2 & -1\\ -1 & 2 \end{bmatrix} \begin{bmatrix} x\\ y \end{bmatrix} = \begin{bmatrix} 0\\ 3 \end{bmatrix} $$

Let the first matrix be $A$, the vector of unknown be $X$, while the right hand side vector be $b$. Sometimes $b$ will be referred to as the "right hand side" vector.

-  The "Row Picture": Imagine plotting the two equations (which are represented by the rows of the matrices) in a cartesian coordinate plane; their intersection would be the solution to the system. In the above example, the solution to the system would be $x=1, y=2$. 

- The "Column Picture":  We can interpret the matrices above as 
 
$$ x\begin{bmatrix} 2\\ -1 \end{bmatrix} + y\begin{bmatrix} -1\\ 2 \end{bmatrix} = \begin{bmatrix} 0\\ 3 \end{bmatrix} $$

- The above equation is essentially telling us to find the "right" linear combination of the first and second vector which produces the resulting vector. We want to find the right $x$ and $y$ which "make" the two vectors combine together to get the third vector.

- We can imagine projecting the first two vectors into a Cartesian coordinate plane. Since we know the correct solution to the system, we can imagine taking "one" of the first vector, then at the tip of the vector, "tucking" two of the second vector on top of it. The end result will be the third vector. 

![[../notes-media/unit1-figure1.png]]

- Now, moving on to three equations, $2x-y+0z=0, -x+2y-z=-1, 0x-3y+4z=4$. Remember the matrix form, which gives us a "row picture": 

$$ A=\begin{bmatrix} 2 & -1 & 0\\ -1 & 2 & -1\\ 0 & -3 & 4\\ \end{bmatrix} \space \space b=\begin{bmatrix} 0\\ -1 \\4 \end{bmatrix} $$

- Using the "row picture", instead of two lines intersecting, it will be three planes intersecting, and they meet at one point, which is the solution to the system. The "row picture" gets more complicated and harder for us humans to see as the number of equations increases. 
- Using the "column picture", we can rewrite the system as 

$$ x\begin{bmatrix} 2\\ -1 \\0 \end{bmatrix} + y\begin{bmatrix} -1\\ 2\\ -3 \end{bmatrix} + z\begin{bmatrix} 0\\ -1 \\4 \end{bmatrix} = \begin{bmatrix} 0\\ -1\\ 4 \end{bmatrix} $$

- We're finding a linear combination of the first three vectors, which produces the final fourth vector. 
- We can visualize this as vectors in a 3-dimensional space. We need to find the "right" combination of the three vectors which produce the fourth vector. As we can easily see here through the "column picture", $x=0, y=0, z=1$ would be the solution to the system. 
 
### The Big Picture

In the column picture, we're essentially "stacking" vectors on top of each other, producing a linear combination that results in the "right-hand side" vector. 

- Can I solve $Ax=b$ for every $b$ ?
- Or, do the linear combinations of the columns fill the entire 3-D space?
	- For the above matrix and columns, the answer is YES.
	- It's a non singular matrix, an invertible matrix. 
- If the three columns of the $A$ matrix lie in the same plane, the linear combination of the three vectors would still be in that plane. So the answer to the above question for this case would be NO. 

Multiplying a matrix by a vector, 

$$ \begin{bmatrix} 2 & 5\\ 1 & 3 \end{bmatrix} \begin{bmatrix} 1\\ 2 \end{bmatrix}$$

think of it as taking "1" of the first column and "2" of the second column and adding them together.

Thinking from the row perspective, you would take the first row of the first matrix, multiply it by the column vector, then take the second row and multiply it by the column vector. (Dot product)

> [!Key Takeaway]
> $Ax$ is a combination of the columns of $A$. 



## An Overview of Key Ideas

The lecture overview and resources can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/pages/ax-b-and-the-four-subspaces/an-overview-of-key-ideas/). The lecture summary can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/resources/mit18_06scf11_ses1-13sum/).

### Objectives

- Vectors
- Matrices

### Lecture 

Vectors $u, v, w$, their linear combination could be $x_{1}u + x_{2}v + x_{3}w = b$.

$$ u=\begin{bmatrix} 1\\ -1\\ 0 \end{bmatrix} \space \space 
v=\begin{bmatrix}0\\1\\-1 \end{bmatrix}$$

Suppose all the possible linear combinations of $u$ and $v$ are taken...you get a plane. 

Let 

$$ w=\begin{bmatrix} 0\\ 0\\ 1 \end{bmatrix} $$

Now let 

$$ Ax = \begin{bmatrix} 1 & 0 & 0\\ -1 & 1 & 0\\ 0 & -1 & 1 \end{bmatrix} \begin{bmatrix} x_{1}\\ x_{2}\\ x_{3} \end{bmatrix} = \begin{bmatrix} x_{1} \\ x_{2}-x_{1}\\ x_{3}-x_{2} \end{bmatrix} = \begin{bmatrix} b_{1}\\ b_{2}\\ b_{3}\\ \end{bmatrix} $$

We can see that 

$$ \begin{bmatrix} x_{1}\\ x_{2}\\ x_{3} \end{bmatrix} = \begin{bmatrix} b_{1}\\ b_{1}+b_{2}\\ b_{1}+b_{2}+b_{3} \end{bmatrix} $$

When you look at the solution that we found, it can be seen as a matrix multiplying $b$ and the matrix will be 

$$ \begin{bmatrix} 1 & 0 & 0\\ 1 & 1 & 0\\ 1 & 1 & 1 \end{bmatrix}\begin{bmatrix} b_{1}\\ b_{2}\\ b_{3}\\ \end{bmatrix} = \begin{bmatrix} b_{1}\\ b_{1}+b_{2}\\ b_{1}+b_{2}+b_{3} \end{bmatrix} = \begin{bmatrix} x_{1}\\ x_{2}\\ x_{3} \end{bmatrix} $$ 

This matrix is called the inverse of $A$, denoted as $A^{-1}$. 

Observe the relationship $Ax=b$, thus $x=A^{-1}b$. 

From the example above, we can call the matrix $A$ as a difference matrix since it takes the differences of the values of $x$. Its inverse, $A^{-1}$, would then take sums. 

<hr>

Instead of $A$, Let

$$ C = \begin{bmatrix} 1 & 0 & -1\\-1 & 1 & 0\\ 0 & -1 & 1 \end{bmatrix} $$ 

then 

$$ Cx = \begin{bmatrix} x_{1}-x_{3} \\ x_{2}-x_{1}\\ x_{3}-x_{2} \end{bmatrix} $$

We see that 

$$\begin{bmatrix} 1 & 0 & -1\\-1 & 1 & 0\\ 0 & -1 & 1 \end{bmatrix} \begin{bmatrix} c\\c\\c \end{bmatrix} = \begin{bmatrix} 0\\0\\0 \end{bmatrix} $$

Which means $C$ has no inverse, there's no linear transformation that can transform a vector of zeros back to some other non zero vector. 

Geometrically, the three vectors that the three columns of $C$ represents lay on the same plane. The linear combinations of $u, v, w$, is a plane. They are ==dependent vectors== while the original $u, v, w$ vectors are ==independent vectors== as all of their possible linear combinations fills the whole space.

<hr>
 
<header>
Understanding the Inverse Geometrically
</header>

<iframe src="https://www.youtube.com/embed/uQhTuRlWMxw"></iframe>

<hr>

## Elimination with Matrices

The lecture overview and resources can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/pages/ax-b-and-the-four-subspaces/elimination-with-matrices/). The lecture summary can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/resources/mit18_06scf11_ses1-2sum/).

### Objectives

- Elimination with Matrices (and cases when it fails)
- Back Substitution 
- Matrix Multiplication

### Lecture

Consider the system of equations:

$$
\begin{align}
x+2y+z=&2 \\
3x+8y+z=&12 \\
0x+4y+z=&2
\end{align}
$$

where 

$$
A=\begin{bmatrix} 1 & 2 & 1\\ 3&8&1\\ 0&4&1 \end{bmatrix} 
\space \space
x=\begin{bmatrix}x\\y\\z\end{bmatrix}
\space \space
b=\begin{bmatrix}2\\12\\2\end{bmatrix}
$$

#### Elimination 

Arrange the system into a matrix by concatenating $A$ and $b$. Let the number in the top left corner be the "pivot". We can multiply the first row by 3 and ==subtract== it from the second row to obtain

$$
A=\begin{bmatrix} 1&2&1&2\\ 0&2&-2&6\\ 0&4&1&2 \end{bmatrix} 
$$

Notice that the "pivot" row does not change. We "eliminated" the element in the second row, first column, element (2, 1). We then eliminate (3, 1), which is already 0. 

We then set the (2, 2) element as the pivot and attempt to eliminate the (3, 2) element, which results in

$$
A=\begin{bmatrix} 1&2&1&2\\ 0&2&-2&6\\ 0&0&5&-10 \end{bmatrix} 
$$

>[!Warning]
>Zero cannot be the "pivot" element!
>If possible, swap rows to allow a nonzero "pivot".

If a zero happens to be a "pivot" element and there's no rows to swap with, we encounter failure. This also indicates that the matrix is non-invertible. 

After elimination, the system then becomes

$$
\begin{align}
x+2y+z=&2\\
2y-2z=&6\\
5z=&-10
\end{align}
$$

Using back substitution, the solution to the system can be determined as $z=2, y=1, z=-2$. 

#### Elimination with Matrices

- A matrix times a column is a column, a row times a matrix is a row. 

- Multiplying a row vector by a matrix is a linear combination of the rows in the matrix using the values of the vector. 

An identity matrix does nothing when multiplied by a matrix.

$$
\begin{bmatrix} 1&0&0\\ 0&1&0\\ 0&0&1 \end{bmatrix}A = \begin{bmatrix} 1*A_{r1}+0*A_{r2}+0*A_{r3}\\ 0*A_{r1}+1*A_{r2}+0*A_{r3}\\ 0*A_{r1}+0*A_{r2}+1*A_{r3} \end{bmatrix}
$$

Recall

$$
A=\begin{bmatrix} 1 & 2 & 1\\ 3&8&1\\ 0&4&1 \end{bmatrix} 
$$

The first step of the elimination can be represented by the following matrix operation

$$
\begin{bmatrix} 1&0&0\\ -3&1&0\\ 0&0&1 \end{bmatrix}\begin{bmatrix} 1&2&1&2\\ 3&8&1&12\\ 0&4&1 &2\end{bmatrix} = \begin{bmatrix} 1&2&1&2\\ 0&2&-2&6\\ 0&4&1&2 \end{bmatrix} 
$$

which is effectively "constructing" the second row of the resulting matrix as 3 times the first row subtracted from the second row then added with 0 times the third row.



## Multiplication and Inverse Matrices

## Factorization into A=LU