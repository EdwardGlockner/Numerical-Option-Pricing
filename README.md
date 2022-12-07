<!-- Table of Contents -->
# Table of Contents
- [About the Project](#about-the-project)
  * [Description](#description)
  * [European options using monte-carlo methods](#european-options-using-monte-carlo-methods)
  * [European options using finite difference methods](#european-options-using-finite-difference-methods)
  * [Comparison of monte-carlo method vs finite difference methods](#comparison-of-monte-carlo-method-vs-finite-difference-methods)
  * [Chooser options using monte-carlo methods](#chooser-options-using-monte-carlo-methods)
  * [American options using finite difference methods, PSOR and operator splittings](#american-options-using-finite-difference-methods-psor-and-operator-splittings)
  * [Screenshots](#screenshots)

- [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Run Locally](#run-locally)

- [Usage](#usage)
- [Contact](#contact)
- [Links](#links)
  

<!-- About the Project -->
## About the Project

<!-- Description -->
### Description

This project is based on the course: "Computational Finance: Pricing and Valuation 1TD186 12010 HT2022" given by Uppsala University. The course is divided into five different assignments. In each assignment a different variation of either the finite difference scheme, or the Monte-Carlo method is used to price different types of financial options.

The project is divided into five folders containing one assignment each. Every folder contains the assignment description named: "Assignment{x}.pdf", a solution to the assignment named "Solution{x}.pdf" or "Solution{x}.mlx" (for MATLAB live scripts), aswell as all the helper functions used in the assignment.

<!-- European options using monte-carlo methods -->
### European options using monte-carlo methods

Here we implement a Monte-Carlo method using Euler's scheme to price a European call option assuming the underlying stock follows a constant elasticity of variance model (CEV model), see: https://en.wikipedia.org/wiki/Constant_elasticity_of_variance_model.

The experiment includes: how the error converges with respect to discretization error and sample error, implementing antithetic variates and how the option price and gamma are related.

<!-- European options using finite difference methods -->
### European options using finite difference methods

Here we implement a (both explicit and implicit) finite difference method to price a European call option, when the underlying stock follows a CEV model.

The experiment includes: how the error converges with respect to spatial and time step, stability analysis of the explicit and implicit finite difference method, analysis of the time complexity and how the option price and gamma are related.

<!-- Comparison of monte-carlo method vs finite difference methods -->
### Comparison of monte-carlo method vs finite difference methods

Here we compare the Monte-Carlo method with the finite difference methods. The analysis includes comparison of convergence, time complexity and computations of the greeks (delta), see https://en.wikipedia.org/wiki/Greeks_(finance).

<!-- Chooser options using monte-carlo methods -->
### Chooser options using monte-carlo methods

Here we modify the previous Monte-Carlo code to price a simple chooser option. We also implement a quasi Monte-Carlo using both the low discrepancy Halton and the Sobol sequence to increase the convergence rate.

The experiment includes: convergence analysis of both the pseudo and the quasi Monte-Carlo method and computations of the greeks (delta).

<!-- American options using finite difference methods, PSOR and operator splittings -->
### American options using finite difference methods, PSOR and operator splittings

Here we implement a finite difference solver to price American options. We also implement both the PSOR and the operator splitting method, see http://www.homepages.ucl.ac.uk/~ucahwts/lgsnotes/AmericanPSOR.pdf, and https://core.ac.uk/download/pdf/82462918.pdf.

<!-- Screenshots -->
### Screenshots

<div align="center"> 
  <img src="https://placehold.co/600x400?text=Your+Screenshot+here" alt="screenshot" />
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

and navigate to one of the assignment folders. Open the folder in MATLAB, and run the .mlx live scripts. If you don't have the ability to run MATLAB, you can see the .pdf-files.

<!-- Usage -->
## Usage

Use this space to tell a little more about your project and how it can be used. Show additional screenshots, code samples, demos or link to other resources.


```javascript
import Component from 'my-project'

function App() {
  return <Component />
}
```


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

