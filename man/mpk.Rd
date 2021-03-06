% Generated by roxygen2 (4.0.2): do not edit by hand
\name{mpk}
\alias{mpk}
\title{Fit Mixtures of Perturbed Kernels}
\usage{
mpk(Y, C, prior = NULL, mcmc = NULL, state = NULL)
}
\arguments{
\item{Y}{Matrix of the data. Each row represents an observation.}

\item{C}{Vector of the group label of each observation. Labels are integers starting from 1.}

\item{prior}{A list giving the prior information. If unspecified, a default prior is used.
The list includes the following hyparameters:
\code{K} Number of mixture components.
\code{merge_step} Introduce step to merge mixture components with small KL divergence. Default is \code{merge_step = TRUE}.
\code{merge_par} Parameter controlling merging radius. Default is \code{merge_par = 0.1}.}

\item{mcmc}{A list giving the MCMC parameters. If unspecified, default parameters are used.
The list includes the following parameters: \code{nburn} indicates the number of burn-in scans,
\code{nsave} indicates the number of scans to be saved,
\code{nskip} indicates the thinning interval,
\code{ndisplay} indicates the number of scans to be displayed on screen.
The total number of scans is equal to  \code{nburn + nsave*nskip}.}

\item{state}{Initial state of the chain.}
}
\value{
A \code{MPK} object.
}
\description{
This function generates draws from the posterior of Mixtures of Perturbed Kernels.
}
\details{
For \eqn{i = 1, \ldots, n_j} and \eqn{j = 1, \ldots, J}:
\deqn{y_{i,j} = \sum_{k=1}^{K}\pi_{j,k}N(y_{i,j} | \mu_{j,k}, \Sigma_k ),  }
where
\deqn{(w_{j,1}, \ldots, w_{j,K}) | \alpha \sim Dirichlet(\alpha/K) }
\deqn{ \mu_{j,k} | \mu_{0,k} \epsilon_k, \Sigma_k \sim Normal(\mu_{0,k}, \epsilon_k \Sigma_k)}
\deqn{\epsilon_k | \epsilon_0  \sim Inv-Gamma( \tau_{\epsilon} + 1, \epsilon_0 \tau_{\epsilon}  ) }
\deqn{ \mu_{0,k} | \Sigma_k, k_0 \sim Normal(m_1, \Sigma_k / k_0)  }
\deqn{\Sigma_{k}^{-1}| \Psi_1 \sim Wishart(\Psi_1, \nu_1).}
In addition, there are the following hyperpriors:
\deqn{\alpha \sim Gamma(\tau_{\alpha, 1}, \tau_{\alpha, 2} ) }
\deqn{ \epsilon_0 \sim Beta(\tau_{\epsilon_0,1}, \tau_{\epsilon_0,2}  ) }
\deqn{ m_1 \sim Normal(m_2, S_2) }
\deqn{k_0 \sim Gamma(\tau_{\gamma,1}/2, \tau_{\gamma,2}/2 )}
\deqn{ \Psi_1 \sim Inv-Wishart(\Psi_2, \nu_2)  }
}
\examples{
n = c(250, 250)
p = 4

Y1 = rbind( matrix( rnorm( n[1]*p), ncol = p), matrix( rnorm(n[2]*p) + 3, ncol = p))
Y2 = rbind( matrix( rnorm( n[1]*p), ncol = p), matrix( rnorm(n[2]*p) + 4, ncol = p))
Y = rbind(Y1, Y2)
C = c( rep(1,sum(n)), rep(2,sum(n)))

ans = mpk(Y, C)
}

