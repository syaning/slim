---
layout: post
title:  "wu-et-al-2017_bolt-on_dp_sgd"
date: 2018-01-02
comments: true
categories: DP_ps
---
#### **Reference paper**:
[Wu, Xi, et al. "Bolt-on Differential Privacy for Scalable Stochastic Gradient Descent-based Analytics." Proceedings of the 2017 ACM International Conference on Management of Data. ACM, 2017.](https://arxiv.org/abs/1606.04722)

#### **_Why_:**
There are two common issues with differentially private machine learning algorithms,
namely:
1. low model accuracy due to the injection of noise (i.e., tradeoff between privacy
  and model accuracy); and
2. high development and runtime overhead.

Thus, the main objective of this paper is to address both of these issues for scalable
ML systems, which implement SGD to minimize convex loss functions.

#### **_How_:**
At a high level, the way in which the authors address the two issues of private-preserving
mechanisms (to date) is by reverting back to the classical *output perturbation*
technique for SGD systems. With output perturbation we can treat the SGD
mechanism as a "black box" and inject noise to its output (e.g., see the image
below). While output perturbation certainly addresses the second issue, the authors'
L2-sensitivity analysis of SGD based on convex loss functions permits a small variance on the
Laplacian noise needed to obtain a certain level of privacy (i.e., $$\epsilon$$-differential privacy).
This ultimately implies that the tradeoff between privacy and model accuracy
is lessened due to a better understanding of the growth of SGD updates.
![how-dp-works]({{site.url}}/images/how-dp-works.png)

##### **_A brief discussion on the mathematics_:**

Preamble:
- $$\ell_{t}(\cdot)$$ is the loss function
- $$\eta_t$$ is the learning rate parameter
- $$w_{t+1} = w_t - \eta_t \ell_t'(w_t)$$ is the weight update rule using SGD
- $$G: \mathcal{W} \to \mathcal{W}$$ is the mathematical operator of SGD updates, i.e.,
$$G_{\ell_t,\eta_t}(w_t) \equiv w_{t+1}$$.

Key Definitions/Terms:
- **L2-sensitivity of a deterministic function $$f$$:** $$\Delta_2(f) = \max_{S\sim S'}\|f(S)-f(S')\|$$,
where $$S$$ and $$S'$$ are neighbouring datasets, which differ by at most one record.
- **PSGD**: stands for permutation-based SGD (i.e., apply a random permutation
  of the dataset before training via SGD)

Important Lemmas:
- **Lemma 4**: Provides bounds for the 2-norm between two sequences of SGD updates,
$$\delta_t = ||w_t - w_t'||$$.
- **Lemma 5** (defining L2-sensitivity for PSGD): Asserts that for a non-adaptive (i.e., random choices are independent
  of the data inputs) randomized algorithm whose L2-sensitivity is bounded by some
  constant $$\Delta$$, then publishing the result of that algorithm plus some noise $$\kappa$$
  with density $$p(\kappa)\propto exp(-\epsilon \|\kappa\| / \Delta)$$ ensures
  $$\epsilon$$-differential privacy.

#### **_What_:**
- **Theorems 4 and 5**: Both use Lemmas 4 and 5 to stipulate that
the algorithms found in Algorithms 1 and 2 both ensure $$\epsilon$$-differential
privacy.


#### **_After reading this paper, I want to learn about:_**
