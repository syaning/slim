---
layout: post
title:  "the_variational_fair_autoencoder--doing_the_math"
date: 2018-02-09
comments: true
categories: ML
---
<!-- ![vfae-graph]({{site.url}}/images/vfae-graph.png) -->
In this post, I derive some of the key mathematical formulas found in the [variational
fair autoencoder paper](https://arxiv.org/pdf/1511.00830.pdf) (see also my summary
of this paper [here]({{ site.baseurl }}{% post_url 2018-02-02-zemel-et-al-2016 %})).


#### Equation (1)
This equation provides the expected lower bound of the conditional log-likelihood
(i.e., conditioned on the nuisance/sensitive variables $$\textbf{s}$$).

By considering the joint distribution $$p(x_n,z_n |s_n)$$ and applying the law
of total probability; and subsequently applying Jensen's inequality, we obtain

$$
\begin{align}
\sum_{n=1}^N \log p(x_n | s_n) &= \sum_{n=1}^N \log \int_{z_n} \frac{p(x_n,z_n | s_n)}
{q(z_n | x_n, s_n)} q(z_n | x_n,s_n)\,\mathrm{d}z_n \\
&\geq \sum_{n=1} \int_{z_n} \log\left(\frac{p(x_n,z_n | s_n)}{q(z_n | x_n, s_n)}\right)
  q(z_n | x_n,s_n)\,\mathrm{d}z_n\\
&= \sum_{n=1}^N E_{q(z_n|x_n,s_n)} \log\left(\frac{p(x_n,z_n | s_n)}{q(z_n | x_n, s_n)}\right)
\end{align}
$$

###### Since $$p(x_n,z_n | s_n) = p(z_n|x_n,s_n)p(x_n|s_n) $$, we get

\begin{align}
\sum_{n=1}^N \log p(x_n | s_n) \geq
\sum_{n=1}^N E_{q(z_n|x_n,s_n)} \left[
\log p(z_n | x_n, s_n) - \log q(z_n | x_n, s_n)
\right] + \log p(x_n | s_n).
\end{align}

Next, it follows from the assumption of independence between the random variables
$$s_n$$ and $$z_n$$ that $$p(z_n|x_n,s_n)=\frac{p(x_n|z_n,s_n)p(z_n|s_n)}{p(x_n|s_n)}
=\frac{p(x_n|z_n,s_n)p(z_n)}{p(x_n|s_n)}$$, so
that

$$
\begin{align}
\sum_{n=1}^N \log p(x_n | s_n) &\geq \sum_{n=1}^N E_{q(z_n|x_n,s_n)} \left[
\log p(x_n | z_n, s_n) + \log p(z_n) - \log p(x_n|s_n) - \log q(z_n | x_n, s_n)
\right] + \log p(x_n | s_n)\\
&= \sum_{n=1}^N E_{q(z_n|x_n,s_n)} \left[ \log p(x_n|z_n,s_n) - \log q(z_n | x_n, s_n) + \log p(z_n) \right] \\
&= \sum_{n=1}^N E_{q(z_n|x_n,s_n)} \left[ \log p(x_n|z_n,s_n)\right] - KL(q(z_n | x_n, s_n) || p(z_n))
\end{align}
$$

\\(\blacksquare\\)

#### Equation (2)
This equation provides an expected lower bound for the log likelihood of $$x$$ in the supervised case.
Similar to the proof of Equation (1), apply the law of total probability and
Jensen's inequality to get a lower bound for the log likelihood of $$x$$:

$$
\begin{align}
\sum_{n=1}^N \log p(x_n | s_n) &=
\sum_{n=1}^N \log \int_{(y,z2,z1)} \frac{p(y_n,z_{2n})p(z_{1n} | y_n, z_{2n})p(x_n|s_n, z_{1n})}
{q(z_{1n},z_{2n},y_n | x_n,s_n)} q(z_{1n},z_{2n},y_n | x_n,s_n) \,\mathrm{d}(y,z_{1n},z_{2n})\\
&\geq \sum_{n=1}^N E_{q(z_{1n},z_{2n},y_n | x_n,s_n)} \left[
\log p(y_n) +
\log p(z_{2n}) +
\log p(z_{1n} | y_n, z_{2n}) +
\log p(x_n|s_n, z_{1n}) -
\log q(z_{1n},z_{2n},y_n | x_n,s_n)
\right]
\end{align}
$$

###### Note that

$$
\begin{align}
p(x_n | s_n ) & = \int_{(y,z2,z1)} p(y_n,z_{2n})p(z_{1n} | y_n, z_{2n})p(x_n|s_n, z_{1n})\,\,\mathrm{d}(y,z_{1n},z_{2n}) \\
&= \int_{z_{1n}} \int_{z_{2n}} \int_{y_n} p(z_{1n},z_{2n},y_n)p(x_n | s_n, z_{1n}) \,\mathrm{d}y\,\mathrm{d}z_{2n}\,
\mathrm{d}z_{1n} \\
&= \int_{z_{1n}} p(z_{1n})p(x_n | s_n, z_{1n})\, \mathrm{d}z_{1n} \\
&= \frac{1}{p(s_n)} \int_{z_{1n}} p(x_n,s_n,z_{1n}) \, \mathrm{d}z_{1n}
\quad [\text{since } p(s_n,z_{1n}) = p(s_n)p(z_{1n})]\\
&= \frac{p(x_n,s_n)}{p(s_n)}
\end{align}
$$

\\(\blacksquare\\)

#### Factorization of $$q(z_{1n},z_{2n},y_n | x_n,s_n)$$
The authors assume that $$q(z_{1n},z_{2n},y_n | x_n,s_n) = q(z_{1n}|x_n,s_n)
q(y_n|z_{1n})q(z_{2n}|z_{1n},y_n)$$. In fact, the underlying assumption is that
$$q(x_n,s_n,z_{2n},y_n | z_{1n})= q(x_n,s_n | z_{1n})q(z_{2n},y_n|z_{1n})$$.

$$
\begin{align}
q(z_{1n},z_{2n},y_n | x_n,s_n) &= \frac{q(z_{1n},z_{2n},y_n, x_n,s_n)}{q(x_n,s_n)}\\
&= \frac{q(z_{2n},y_n, x_n,s_n | z_{1n})q(z_{1n})}{q(x_n,s_n)}\\
&= \frac{q(x_n,s_n | z_{1n})q(z_{2n},y_n|z_{1n})q(z_{1n})}{q(x_n,s_n)} \quad
[\text{by underlying assumption}]\\
&= \frac{q(x_n,s_n,z_{1n})q(z_{2n},y_n|z_{1n})}{q(x_n,s_n)}\\
&= q(z_{1n}|x_n,s_n)q(z_{2n},y_n|z_{1n})\\
&= q(z_{1n}|x_n,s_n)q(y_n|z_{1n})q(z_{2n}|z_{1n},y_n)
\end{align}
$$

\\(\blacksquare\\)

#### Equations (3) and (4)
To verify these equations, one simply substitutes the factorization of $$q(z_{1n},z_{2n},y_n | x_n,s_n)$$
into Equation (2) and follows the triple integration in order to match all of terms.
