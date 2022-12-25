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

The lecture Overview and Resources can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/pages/ax-b-and-the-four-subspaces/the-geometry-of-linear-equations/). The lecture summary can be found [here](https://ocw.mit.edu/courses/18-06sc-linear-algebra-fall-2011/resources/mit18_06scf11_ses1-1sum/).

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

- Now, moving on to three equations, $2x-y+0z=0, -x+2y-z=-1, 0x-3y+4z=4$. Remember the matrix form which gives us a "row picture": 

$$ A=\begin{bmatrix} 2 & -1 & 0\\ -1 & 2 & -1\\ 0 & -3 & 4\\ \end{bmatrix} \space \space b=\begin{bmatrix} 0\\ -1 \\4 \end{bmatrix} $$

- Using the "row picture", instead of two lines intersecting, it will be three planes intersecting and they meet at one point, which is the solution to the system. The "row picture" gets more complicated and harder for us humans to see as the number of equations increase. 
- Using the "column picture", we can rewrite the system as 

$$ x\begin{bmatrix} 2\\ -1 \\0 \end{bmatrix} + y\begin{bmatrix} -1\\ 2\\ -3 \end{bmatrix} + z\begin{bmatrix} 0\\ -1 \\4 \end{bmatrix} = \begin{bmatrix} 0\\ -1\\ 4 \end{bmatrix} $$

- We're finding a linear combination of the first three vectors which produces the final, fourth, vector. 
- We can visualize this as vectors in a 3-dimensional space. We need to find the "right" combination of the three vectors which produces the fourth vectors. As we can easily see here through the "column picture", $x=0, y=0, z=1$ would be the solution to the system. 
 
### The Big Picture

In the column picture, we're essentially "stacking" vectors on top of each other, producing a linear combination which results in the "right hand side" vector. 

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
> ==$Ax$ is a combination of the columns of $A$.== 



## An Overview of Key Ideas

## Elimination with Matrices

## Multiplication and Inverse Matrices

## Factorization into A=LU