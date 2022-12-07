<!-- Table of Contents -->
# Table of Contents
- [About the Project](#about-the-project)
  * [Description](#description)
  * [Assignment 1 European options using monte-carlo methods](#assignment-1-european-options-using-monte-carlo-methods)
  * [Assignment 2 European options using finite difference methods](#assignment-2-european-options-using-finite-difference-methods)
  * [Assignment 3 Comparison of monte-carlo method vs finite difference methods](#assignment-3-comparison-of-monte-carlo-method-vs-finite-difference-methods)
  * [Assignment 4 Chooser options using monte-carlo methods](#assignment-4-chooser-options-using-monte-carlo-methods)
  * [Assignment 5 American options using finite difference methods, PSOR and operator splittings](#assignment-5-american-options-using-finite-difference-methods-psor-and-operator-splittings)

- [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Run Locally](#run-locally)

- [Contact](#contact)
- [Links](#links)
  

<!-- About the Project -->
## About the Project

<!-- Description -->
### Description

This project is based on the course: "Computational Finance: Pricing and Valuation 1TD186 12010 HT2022" given by Uppsala University. The course is divided into five different assignments. In each assignment a different variation of either the finite difference scheme, or the Monte-Carlo method is used to price different types of financial options.

The project is divided into five folders containing one assignment each. Every folder contains the assignment description named: "Assignment{x}.pdf", a solution to the assignment named "Solution{x}.pdf" or "Solution{x}.mlx" (for MATLAB live scripts), aswell as all the helper functions used in the assignment.

-----------
<!-- Assignment 1 European options using monte-carlo methods -->
### Assignment 1 European options using monte-carlo methods

Here we implement a Monte-Carlo method using Euler's scheme to price a European call option assuming the underlying stock follows a constant elasticity of variance model (CEV model), see: https://en.wikipedia.org/wiki/Constant_elasticity_of_variance_model.

The experiment includes: how the error converges with respect to discretization error and sample error, implementing antithetic variates and how the option price and gamma are related.

-----------
<!-- Assignment 2 European options using finite difference methods -->
### Assignment 2 European options using finite difference methods

Here we implement a (both explicit and implicit) finite difference method to price a European call option, when the underlying stock follows a CEV model.

The experiment includes: how the error converges with respect to spatial and time step, stability analysis of the explicit and implicit finite difference method, analysis of the time complexity and how the option price and gamma are related.

Below are plots of the implicit solver, stability analysis of the implicit solver and time complexity of the finite difference methods: (in that order from left to right):

<div class="align-center"> 
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%202/Images/implicit.png" width="270" height="230"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%202/Images/unstable.png" width="270" height="230"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%202/Images/Complexity.png" width="270" height="230"/>
</div>

-----------
<!-- Assignment 3 Comparison of monte-carlo method vs finite difference methods -->
### Assignment 3 Comparison of monte-carlo method vs finite difference methods

Here we compare the Monte-Carlo method with the finite difference methods. The analysis includes comparison of convergence, time complexity and computations of the greeks (delta), see https://en.wikipedia.org/wiki/Greeks_(finance).

Below are images of the computed deltas using implicit finite difference method and monte-carlo method (in that order from left to right):

<div class="align-center"> 
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%203/Images/Implicit_Delta.png" width="410" height="350"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%203/Images/MC_Delta.png" width="410" height="350"/>
</div>

-----------
<!-- Assignment 4 Chooser options using monte-carlo methods -->
### Assignment 4 Chooser options using monte-carlo methods

Here we modify the previous Monte-Carlo code to price a simple chooser option. We also implement a quasi Monte-Carlo using both the low discrepancy Halton and the Sobol sequence to increase the convergence rate.

The experiment includes: convergence analysis of both the pseudo and the quasi Monte-Carlo method and computations of the greeks (delta).

Below are images of the error analysis using pseudo and quasi random numbers, and of computations of the delta (in that order from left to right):

<div class="align-center"> 
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%204/Images/all.png" width="410" height="330"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%204/Images/delta.png" width="410" height="330"/>
</div>

-----------
<!-- Assignment 5 American options using finite difference methods, PSOR and operator splittings -->
### Assignment 5 American options using finite difference methods, PSOR and operator splittings

Here we implement a finite difference solver to price American options. We also implement both the projected successive overrelaxation method (PSOR) and the operator splitting method (OS), see http://www.homepages.ucl.ac.uk/~ucahwts/lgsnotes/AmericanPSOR.pdf, and https://core.ac.uk/download/pdf/82462918.pdf.

Below are images of the solution using both the PSOR and the OS method, aswell as the early exercise curve (in that order from left to right):

<div class="align-center"> 
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%205/Images/psor.png" width="270" height="230"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%205/Images/call.png" width="270" height="230"/>
  <img src="https://github.com/EdwardGlockner/Pricing-of-Financial-Options/blob/main/Assignment%205/Images/early.png" width="270" height="230"/>
</div>

<!-- Getting Started -->
## Getting Started

<!-- Prerequisites -->
### Prerequisites

Since this project is a MATLAB project, an active MathWorks license is needed to compile the code. See: https://se.mathworks.com/pricing-licensing.html.  

<!-- Run Locally -->
### Run Locally

Clone the project

```bash
  git clone https://github.com/EdwardGlockner/Pricing-of-Financial-Options.git
```

Go to the project directory

```bash
  cd my-project
```

and navigate to one of the assignment folders. Open the folder in MATLAB. Drag the helper functions to the same directory as the .mlx file and run the live script. If you don't have the ability to run MATLAB, you can see the .pdf-files.


<!-- Contact -->
## Contact

Edward Glöckner - [@linkedin](https://www.linkedin.com/in/edwardglockner/) - edward.glockner5@gmail.com

Project Link: [https://github.com/EdwardGlockner/Pricing-of-Financial-Options](https://github.com/EdwardGlockner/Pricing-of-Financial-Options)


<!-- Links -->
## Links

Here are some helpful links:

 - [CEV-model](https://en.wikipedia.org/wiki/Constant_elasticity_of_variance_model)
 - [The Greeks](https://en.wikipedia.org/wiki/Greeks_(finance))
 - [Monte-Carlo method](https://en.wikipedia.org/wiki/Monte_Carlo_methods_for_option_pricing)
 - [Finite Difference method](https://en.wikipedia.org/wiki/Finite_difference_methods_for_option_pricing)
 - [PSOR](http://www.homepages.ucl.ac.uk/~ucahwts/lgsnotes/AmericanPSOR.pdf)
 - [Operator Splittings](https://core.ac.uk/download/pdf/82462918.pdf)

