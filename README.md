# REPINS2

This repository contains the model as well as the data for the REPINS2 project.
For the details about the data consult the subfolder REPINSDataFig and the README therein.

Below follows a description and explanation of the the Julia code presented in this repository.
We numerically solve a system of REPINS and RAYTS.

## Getting Started with the model

THe bacterial population can be split up into three compartments

 - 0 RAYTS
 - 1 RAYT
 - 2 RAYTS

The total number of REPINS possible within each state are given by the parameter combinations delta and gamma.

### Prerequisites

To run the code all that is required is to install Julia.
Plottign can be done optionally in any other program of user choice.
We provide a Mathematica file which does the plotting using the provided csv files.

### Installing

A step by step guide for installing and running Julia can be found 

```
https://julialang.org
```

## Running the code

There are two basic initial conditions which are explored for different parameter settings.

- One where the initial number of REPINS in close to extinction
- another where the initial number of REPINS is close to fixation

The basic parameters (explained further in the manuscript) are 

δ = 10^-3

γ = 0.95

λ = 10^-2

#Benefit parameters

α = 10^-2#0.0

ω = 0.985


### Calculations without RAYT states

As a null model we begin with a bacterial population without different RAYT states.
Hence \epsilon = 0 and the population stays in 1 RAYT state.

#### Without benefits

Without benefits \alpha = 0 we can recover the simulation outcomes:

- Raytssol2_withoutbenefits.csv
- Raytssol3_withoutbenefits.csv



#### Adding benefits

By setting \alpha = 10^{-2} we incorporate the effects of benefits into the REPIN systems.
This leads us to 

- Raytssol2_withoutbenefits.csv
- Raytssol3_withoutbenefits.csv


### Calculations with RAYT states

Together with benefits we include multiple RAYT states when \epsilon is positive (\epsilon = 0.2)

The bacterial population can now spill over into the 0 RAYT and 2 RAYT states.

The results are given in

- Raytssol2_withRAYTS.csv
- Raytssol3_withRAYTS.csv

## Built With

* [Julia](https://julialang.org) - the core code language
* [Mathematica](https://www.wolfram.com/mathematica/) - Only for plotting

## Contributing

Please feel free to fork the project for extensions and any queries are welcome

## Authors

See also the list of [contributors](https://github.com/tecoevo/REPINS2/contributors) who participated in this project.

## License

This project as [LICENSE.md](LICENSE.md)
