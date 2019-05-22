[Home](./)
<hr>
# Overall folder structure

- [Background](#background)
- [Overview](#overview)
- [The functional abstraction](#the-functional-abstraction)
    - [Data Science abstraction](https://github.com/sankhaMukherjee/RLalgos/wiki/The-Data-Science-Abstraction)
    - [Software Engineering abstraction](#software-engineering-abstraction)

## Background

The repository is divided into an overall folder structure. It might be a little confusing in the beginning. However, once one has understood the overall structure of how the code is arranged, it will be significantly easier for a user to generate and test programs in a reliable manner. This is created using the [myCutter](https://github.com/sankhaMukherjee/myCutter) cookiecutter. Inspiration was obtained from several other [cookiecutters](https://github.com/audreyr/cookiecutter) within the original project.

## Overview

The overall folder structure is shown below. Each section will be expounded upon within their own subsections. However, we would like to begin by looking into how the program is structured in general. 

```
├── bin
├── config
│   └── modules
├── docs
├── env
├── installers
├── models
├── notebooks
├── results
├── Makefile
├── src
│   ├── Makefile
│   ├── RLalgos.py
│   ├── lib
│   ├── logs
│   └── modules
└── tests
```

One line descriptions of the programming structure is as follows:

- `bin` contains any shell commands that 
- `config` contains json configuration files to be used by other parts of the program
- `docs` contains API automatically generated using Sphinx
- `env` is the default location of the virtual environment that will be generated for this program
- `installers` contains specific installers that are needed for this program. These will be installed through the `pip` installer within the current virtual environment
- `models` contains saved models for distribution
- `results` contains all results that will be generated
- `src` is the location where all your code is located. It is also the location from where you will fun various tests
   - `Makefile` allows you to specify different ways of running code
   - `RLalgos.py` is the main program that can deploy any module of your choosing
   - `lib` contains libraries used by other parts of the program
   - `logs` contains libraries for logging, and also all log files are rendered here
   - `modules` contains modules which can be run independently on one another. You should put different types if optimization code here
- `tests` contains unit tests for various purposes

## The functional abstraction

The folder structure revolves around a set of functional abstractions. These are discussed next. Functional abstractions encompass two disparate areas:

- software engineering abstractions, and 
- data science abstractions

### Data Science Abstraction

Details of the Data Science abstraction lie in their [own page](./The-Data-Science-Abstraction). 

The Data Science abstraction is what empowers the user in generating various tests, and deploying them quickly, and yet maintain a reasonable structure that will allow multiple users to meaningfully collaborate using different tests of their own. The most important of the functional forms revolves around the idea of `modules`. These are *functionally independent* units of code that should be executed at any one time. Examples of such functional abstractions are:

- downloading data
- cleaning data
- Database ETL for a particular task
- training a particular model
- visualizing the results of a particular model
- plotting comparative results of many models
- generating graphs for reports

Notice that not only are these tasks independent, they are typically something that you would not want to repeat every single time you run a particular program. 

### Software Engineering abstraction

Details of the Software Engineering abstractions may be found in their [own page](./Software-Engineering-abstraction).

Software Engineering comprises of a number of standard methods that allow you to write reliable code. Typically there are four main aspects of software engineering that will be covered here:

- logging
- Unit testing
- API generation
- Virtual Environment maintenance 

