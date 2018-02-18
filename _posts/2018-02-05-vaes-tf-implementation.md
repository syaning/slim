---
layout: post
title:  "VAE_tensorflow_implementation"
date: 2018-02-05
comments: true
categories: ML
---
Links to some VAE material:

- [the original paper](https://arxiv.org/pdf/1312.6114.pdf)
- [a previous post summarizing the paper]({{ site.baseurl }}{% post_url 2018-02-01-kingma-and-welling-2014 %})

I'll start off by saying that I first learned about autoencoders as well as
variational autoencoders through Aurélien Géron's fabulous textbook:
[Hands-On Machine Learning with Scikit-Learn and TensorFlow](http://shop.oreilly.com/product/0636920052289.do).
Evidently, my [tensorflow implementation](https://github.com/vafajardo/research/tree/master/autoencoders)
closely resembles that by Aurélien; however, since in my example I try to
encode-decode the [Frey faces dataset](https://cs.nyu.edu/~roweis/data.html),
my "reconstruction error" is based on the Gaussian distribution
(i.e., $$\log p_\theta(x|z) \sim \mathcal{N}(\mu = f_\theta^\mu(z),
\sigma = f_\theta^\sigma(z))$$).

### Graph from tensorboard

![vae-graph]({{site.url}}/images/vae-graph.png)

Traversing the VAE graph:
1. **X_encoder**: Takes as input, $$x$$ and outputs the function approximations
for the parameters $$\{\mu_\phi,\sigma_\phi^2\}$$ for the variational
poster $$q_\phi(z|x)$$
2. **re-parametrization trick**: This trick is used to sample from the variational
posterior in a fashion that facilitates backpropogation through the network. Under
the normal assumption of $$q_\phi(z|x)$$, this is done by first sampling an
$$\epsilon$$ from the standard normal distribution (i.e., the random normal node
in the graph above) and applying the transformation $$z = \mu_\phi + \epsilon
\times \sigma_\phi$$.
3. **X_decoder**: Takes as input, the randomly sampled $$z$$ and outputs the
function approximation for the model parameters $$\theta$$, which depends on
the assumed functional form of the generative distribution $$p_\theta(x | z)$$.
4. **ELB**: Stands for Expected Lower Bound and is given by the right-hand side
of the inequality below:
\begin{align}
\log p(x) \geq E_{q_\phi(z|x)}[\log p_\theta(x|z)] - KL(q_\phi(z|x) || p(z))
\end{align}
The goal is to find the model parameters $$\theta$$ and variational parameters
$$\phi$$ which maximize this ELB. In VAEs, this is carried out by SGD. Note that the
KL divergence term may be expressed analytically under certain assumptions
on the parametric forms of the involved distributions; and so, only the first
term needs to be estimated. We estimate this expecation using Monte Carlo methods:
\begin{align}
E_{q_\phi(z|x)}[\log p_\theta(x|z)] \approx \frac{1}{L}\sum_{\ell = 1}^L \log p_\theta(x|z_\ell),
\end{align}
where $$\{z_\ell\}_{\ell=1}^L$$ is an iid sample from $$q_\phi(z|x)$$.

### Generated Frey faces
For the Frey faces dataset, we assume that $$p_\theta(x|z)\sim\mathcal{N}
(\mu = f_\theta^\mu(z),\sigma = f_\theta^\sigma(z))$$. A VAE was trained with the
following assumptions and specifications:
- **latent prior**: $$p(z)\sim \mathcal{N}(\mathbf{0},\mathbf{I})$$
- **recognition model**: $$q_\phi(z|x)\sim\mathcal{N}(\mathbf{\mu}_\phi,
  \mathbf{\sigma}_\phi^2\mathbf{I})$$
- **generative model**: $$p_\theta(x|z)\sim\mathcal{N}(\mathbf{\mu}_\theta,
  \mathbf{\sigma}_\theta^2\mathbf{I})$$
- **Coding dimension**: twenty (i.e., $$\mathbf{z}_\ell=\{z_{\ell,1},\ldots,z_{\ell,20}\}$$)
- **X_encoder**: two MLPs sharing two hidden layers are used to estimate
$$\{\mu_\phi,\sigma_\phi^2\}$$
- **X_decoder**: similarly, two MLPs sharing two hidden layers are also used to
esimtate $$\{\mu_\theta,\sigma_\theta^2\}$$

The VAE was trained using 10,000 epochs and with a learning rate of 0.001. After
training, I took a random sample of size 100 from the $$\mathcal{N}(\mathbf{0},\mathbf{I}_{20})$$
distribution and passed it through the generative model. The image below represents
the 100 generated faces.

![frey-faces-random-generation]({{site.url}}/images/generated_frey_faces.png)
