# EEHT - Efficient and Effective Implementation of Hottopixx Methods
This is a MATLAB code for the algoithm EEHT, presented in the paper "Tomohiko Mizutani, Implementing Hottopixx Methods for Endmember Extraction in Hyperspectral Images, arXiv, 2024".

## Prerequisites
You need to install CPLEX and enter the path of the installation directory to the file 'setPara.m'.
In addition, optimization toolbox is needed when reproducing the experiments in Sections VI (b) and (c) by using 'expExtnPerf.m' and 'expUnmixUrban.m'.

## Quick Start
The following command runs EEHT for a noisy separable matrix  $A = W H + N$ of size $d \times n$ with factorization rank $r$.

```bash
$ run_eeht
```

### Input 
- ``d`` : Number of columns  
- ``n`` : Number of rows
- ``r`` : Factorization rank
- ``delta`` : Noise intensity, i.e, delta = $||N||_1$
- ``dataType`` : Choose 'normal' or 'ill-conditioned'
- ``cVal`` : Parameter for generating $\alpha$ such that 
                     $\alpha^{(\text{r}-1)} = 10^{(-\text{cVal})}$
- ``seed`` : Seed number for generating random numbers
- ``flag_dispMatPara`` : Choose 1 if you display kappa, omega, beta, and condNum (condition number), of input matrix; otherwise, 0

The input matrices are the same as those of RHHP; see the [webpage](https://github.com/tomohiko-mizutani/RHHP) for the details.


### Output
- Recovery rates by EEHT-A, -B, -C

### Parameters

## Experiments in Sections VI(b)
The experiments in Section VI(b) can be reproduced by using 'expExtnPerf.m'. Before running it,
you should set $(\lambda, \mu) = (10,100)$ by editing the file 'setPara.m' as follows.

> lambda = 10;  
> mu = 100;

In addition, you need to choose datasets 1 or 2 for which EEHT is applied. 
To do so, open the file 'expExtnPerf.m' and set the option value of the variable 'dataset' to 1 or 2. 
For instance, when applying EEHT for dataset 1, please edit the file as follows.

> dataset = 1;

Note that dataset 1 was constructed from Jasper Ridge and dataset 2 from Samson.
Then, type the command for starting the experiments.
```bash
$ expExtnPerf
```
After the code has finished running, you get the output file 'rsltExtnPerf_dataset1.mat'.
You can display the graph showing the results by using 'dispRsltExtnPerf.m'.
When EEHT was applied for dataset 1, please edit the file as follows.

> dataset = 1;

Type the command
```bash
$ dispRsltExtnPerf
```
and then the graph is shown.
Below is the graphs obtained for datasets 1 and 2.
![Results for dataset 1]("Results for dataset 1")

## Experiments in Sections VI(c)

---
Contact: Tomohiko Mizutani [(mizutani.t@shizuoka.ac.jp)](mailto:mizutani.t@shizuoka.ac.jp)



[def]: Rslt/rsltExtnPerf_dataset1.eps
