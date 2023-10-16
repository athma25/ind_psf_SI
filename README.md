# Codes for demonstrating parameterization of a soil-explicit PSF model from simulated data
## Manuscript titled "Challenges in linking plant-soil feedbacks to community structure" has further details
## Authors: Athmanathan Senthilnathan, Po-Ju Ke, Xinyi Yan, Kerri Crawford, Rafael D'Andrea

## Files
* *fit_gamma_lib.r*: R library with functions to generate simulated data and fit data using nonlinear regression
* *fit_gamma_test.r*: R script to generate simulated data and fit for specific case in Figure 2c
* *d_eq.m*: R script to reproduce Figure 2C. Run *fit_gamma_test.r* before running this
* *fig1.m*: MATLAB script to reproduce last panel in Figure 1B 
* *fig3.m*: MATLAB script to reproduce Figure 3B,C,D 
* *myTxtFmt.m* : MATLAB script to change font size and interpreter
* *printPdf.m*: MATLAB script to print plot as PDF

## Codes tested in wsl2 with Debian 11 and R4.0.4. MATLAB 2022a installed in Windows 11.
