[Home](./) | [Structure of the repo](./Structure-of-the-repo)
<hr>

Software Engineering comprises of a number of standard methods that allow you to write reliable code. Typically there are four main aspects of software engineering that will be covered here:

- logging
- Unit Testing
- API Generation
- Virtual Environment maintenance 

Each of these will be detailed in the following paragraphs

## 1. Logging

Logging is an essential feature of long-running programs. This abstraction comes with a library that makes logging very easy. This system uses the standard system [logger](https://docs.python.org/3/library/logging.html), which is converted into a set of decorators for meaningful use. The library is located in [`src\logs\logDecorator.py`](../blob/master/src/logs/logDecorator.py) file and comprises of two decorators. You will typically only need one of these called [`log(base)`](../blob/35f4cdaeed427e723d06371894b460c93aae4d07/src/logs/logDecorator.py#L7).

### 1.1. Logger Configuration

The logging module will allow you too preconfigure logs so that they can either go to the standard output, or to an auto-generated log file, or to a preconfigured [logstash](https://www.elastic.co/products/logstash) server which can later be organized through the [ELK stack](https://www.elastic.co/).

In its default configuration, it is going to save logs into a newly generated log file within the [`src\logs`](../blob/master/src/logs) folder. 

Details of the configuration may be found [here](./Logging-Configuration).

### 1.2. Using the logger

A simple example of its use is shown in the snippet below. It is used by decorating a function that you would want to log by providing a string to the function. The logger adds information about the fact that the function has been called at what time and passes a `logging.logger` instance into the function as the first element of the function, which can be used for logging other events within the function. 

```python
from logs import logDecorator as lD
import json

config = json.load(open('../config/config.json'))
logBase = config['logging']['logBase'] + '.lib.testLib.simpleLib'

@lD.log(logBase + '.simpleTestFunction')
def simpleTestFunction(logger, a, b):
    try:
        result = a+b
    except Exception as e:
        logger.error(f'Unable to add the two values [{a}] and [{b}]:\n{e}')
        raise

    return result
```
For calling this function, simply call it like `simpleTestFunction(4, 3)`. You do not need to bother passing  the logger as it will be supplied by the decorator.

### 1.3. Checking Logs

In its most basic configuration, logs are generated within log files within the [`src/logs`](../blob/master/src/logs) folder in the with filenames generated from the timestamp in the format `YYYY-mm-dd--HH-MM-SS.log`. Hence, the log for the last run will correspond to the latest date. You can always get this file with `ls logs/*.log 2> /dev/null | sort | tail -n1`, and `cat` this file. Alternatively, within the `src` folder, type `make checkLog`. This will `cat` the contents of the latest log file, from which you can `grep` meaningful items. 

## 2. Unit Testing

Unit testing is useful for making sure that changes to one part of the program does not affect another part of the program. Unit testing is supported in this framework using [`pytest`](https://docs.pytest.org/en/latest/). 

### 2.1. Running tests
Unit testing routines should be placed in the [`tests`](../blob/master/tests) folder. An example is provided in the [`tests/lib/test_simpleLib.py`](../blob/master/tests/lib/test_simpleLib.py) file. They have a couple of very simple rules.  

1. The name of a test file should start with `test_`, and 
2. The name of a testing function should start with `test_`

Refer to the [pytest](https://docs.pytest.org/en/latest/contents.html#toc) ducumentation for further details of generating tests. 

### 2.2. Running tests

The framework comes built with a single test file [`tests/lib/test_simpleLib.py`](../blob/master/tests/lib/test_simpleLib.py) with two test functions within it. For running the tests, go to the [`src`](../blob/master/src) folder and run the command `make test`. You will see that two tests would have run successfully.

```bash
$ make test
python3 -m pytest ../tests
========================================= test session starts ==========================================
platform linux -- Python 3.6.7, pytest-4.4.1, py-1.8.0, pluggy-0.9.0
rootdir: </path/to/root/foldler>
plugins: cov-2.6.1, celery-4.3.0
collected 2 items                                                                                      

../tests/lib/test_simpleLib.py ..                                                                [100%]

======================================= 2 passed in 0.05 seconds =======================================
```
## 3. API Generation

[Sphinx](http://www.sphinx-doc.org/en/master/index.html) is used for generating documentation for the project. In particular the [Autodoc](http://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html) extension allows the generation of API documentation directly from doc strings present within the different files. 

For generating the API, type `make doc` in the [`src`](../blob/master/src) folder. This will generate HTML documentation within the `docs/_build/html` folder.

You are highly encouraged to generate proper doc strings for all your code. Please remember to add documentation of new modules and libraries in the `__init__.py` functions within each folder.

## 4. Virtual Environment maintenance 

This project framework uses [`venv`](https://docs.python.org/3/library/venv.html) for maintaining virtual environments. Please familiarize yourself with [`venv`](https://docs.python.org/3/library/venv.html) before working with this repository. You do not want to contaminate your system python while working with this repository.

> Note: 
>  - For activating your virtual environment, type `source env/bin/activate` in [bash](https://www.gnu.org/software/bash/) or `source env/bin/activate.fish` if you are using the [fish](https://fishshell.com/) shell.
>  - For deactivating, just type `deactivate` in your shell

Git commits will typically not push the virtual  environment to Github. You will be required to generate a fresh copy of the virtual environment on every machine on which this repository is cloned. This is especially true for CUDA related issues wherein the installation of CUDA drivers varies significantly between machines. 

For generating a fresh copy of the virtual environment, type `make firstRun` on the home folder. This will generate the `\env` folder within your project folder and install the required libraries based upon your system. On an Apple computer, it is practically impossible to install the GPU versions of TensorFlow and PyTorch and for these, please consider uninstalling these and installing the CPU versions. 

Current library requirements are present within the file `requirements.txt`. Each time a new library is installed within this virtual environment, consider updating the `requirements.txt` file. 