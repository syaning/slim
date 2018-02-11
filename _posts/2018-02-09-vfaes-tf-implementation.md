---
layout: post
title:  "VFAE_tensorflow_implementation"
date: 2018-02-10
comments: true
categories: ML
---
Some links to VFAE material:

- [the original paper](https://arxiv.org/pdf/1511.00830.pdf)
- [a previous post summarizing the paper]({{ site.baseurl }}{% post_url 2018-02-02-zemel-et-al-2016 %})
- [a previous post on the mathematics behind VFAEs]({{ site.baseurl }}{% post_url 2018-02-09-vfaes-math %})

In today's post, I briefly go over my [tensorflow implementation](https://github.com/vafajardo/research/blob/master/autoencoders/vfae.py)
of a VFAE that I use to find a latent representation of the MNIST handwritten digits dataset. I should
note that in my example, I don't have any "actual" nuisance/sensitive variables in mind;
moreover, that I am simply training on this dataset to determine if indeed
the decoder $$p_\theta(x|z_1,s)$$ is able to produce recognizable images given a randomly
sampled $$z_1$$ and true values of the sensitive variables $$s$$.
(A better example would be one in which there was a subsequent classification task,
so that I can compute the resulting discrimination value; and compare it to that
of a similar classifier which learned $$y$$ from the original features instead.)

![vfae-graph]({{site.url}}/images/vfae-graph.png)

The tensorboard graph above depicts the architecture of my VFAE, which I describe in detail
next:

1. **X_encoder**: comprises of two MLPs (that share a common hidden layer)
both of which take $$x\setminus s$$ and $$s$$ as input and produces $$\mu = f_\phi^{\mu,z_1}(x,s)$$
and $$\log \sigma^2 = f_\phi^{\sigma,z_1}(x,s)$$ -- i.e., the mean and variance of the
assumed normally distributed variational posterior, $$q_\phi(z_1 | x,s)$$.
2. **Z1_encoder**: comprises of three MLPS, two of which share a common
hidden layer. The two MLPs that share a hidden layer take as input a randomly
sampled $$z_1$$ (from $$q_\phi(z_1| x,s)$$ via the reparametrization trick) and
the true label $$y$$ to produce $$\mu = f_\phi^{(\mu,z_2)}(z_1,y)$$ and
$$\log \sigma^2 = f_\phi^{\sigma,z_2}(z_1,y)$$ -- i.e., the mean and variance of
the assumed normally distributed $$q_\phi(z_2 | z_1,y)$$. The third MLP takes
the randomly sampled $$z_1$$ and produces the probability vector of the assumed
multinomial distribution of $$y$$, which is appropriate here since $$y \in \{0,1,\ldots,9\}$$ --
i.e., the parameter of the posterior $$q_\phi(y|z_1)$$.
3. **Z1_decoder**: comprises of two MLPs (again sharing a common hidden layer)
that take as input a randomly sampled $$z_2$$ (from $$q_\phi(z_2|z_1,y)$$) and the true
label $$y$$ in order to produce $$\mu = f_\theta^{\mu,z_1}(x,s)$$ and
$$\log \sigma^2 = f_\theta^{\sigma,z_1}(x,s)$$ -- i.e., the mean and variance of
the assumed normally distributed true posterior, $$p_\theta(z_1 | z_2,y)$$
4. **X_decoder**: comprises of one MLP that takes as input a randomly sampled
$$z_1$$ (from $$p_\theta(z_1|z_2,y)$$) as well as the sensitive variables $$s$$
in order to produce $$\mu = f_\theta^{(\mu,x)}(z_1,s)$$ -- i.e., the mean of the
assumed Bernoulli distribution of the final outputs (commonly used for MNIST final
outputs).
5. **ELB**: This tensorflow node computes the expected lower bound of the conditional
log-likelihood (i.e., see equation (5) in the original paper).
6. **random_normal**: These nodes are used to sample $$\epsilon$$ from the standard
normal distribution which are then applied to $$\mu + \sigma\epsilon$$ in order
to sample from the appropriate normal distributions (i.e., $$z_1$$, $$z_2$$,
and $$z_1$$ again) -- this transformation is what allows the facilitation of the
backpropogation technique and is known as the reparametrization trick.

Some important notes:
- If a datapoint is unlabelled, then its $$y$$ is imputed by sampling from the
variational posterior $$q_\phi(y|z_1)$$. In fact, the overall loss function comprises
of the expected lower bound plus a regularization term which forces the learning of
this posterior.
- To produce a test output, I sample $$z_1$$ from the standard normal distribution
and take some true values of $$s$$ from some test images (i.e., recall the
assumption of independence between $$z_1$$ and $$s$$), and pass this pair of
variables to the **Z1_encoder** stage and subsequently onto to next stages that follow.
I also pass in a tensorflow boolean variable so that $$y$$ is imputed from $$$q_\phi(y|z_1)$$.
- In subsequent prediction task, I would supply $$(x\setminus s, s)$$ to $$X_encoder$$
and can either sample from the encoder $$q_\phi(z_1 | x,s)$$ or use the mean
as the latent representation.

#### Results
For my sensitive variables, $$s$$, I take the last $$m$$ pixels of an image. The
plots represent the output of the VFAE with $$m$$ equal to 10, 100, and 350,
respectively.

![vfae-mnist-10]({{site.url}}/images/vfae_generated_digits_plot_s10.png)
![vfae-mnist-100]({{site.url}}/images/vfae_generated_digits_plot_s100.png)
![vfae-mnist-350]({{site.url}}/images/vfae_generated_digits_plot_s350.png)
