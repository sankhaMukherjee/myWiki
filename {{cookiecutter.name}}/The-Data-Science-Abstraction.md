[Home](./) | [Structure of the repo](./Structure-of-the-repo)
<hr>

## Overview

The function form is what empowers the user in generating various tests, and deploying them quickly. The most important of the functional forms revolves around the idea of `modules`. These are *functionally independent* units of code that should be executed at any one time. Examples of such functional abstractions are:

- downloading data
- cleaning data
- Database ETL for a particular task
- training a particular model
- visualizing the results of a particular model
- plotting comparative results of many models
- generating graphs for reports

Notice that not only are these tasks independent, they are typically something that you would not want to repeat every single time you run a particular program. Some units might take a long time to execute. Hence it is important that one performs them once, and not every time a particular operation is performed. This is especially true when certain operations might take several days to complete. 

## Overall Project Structure

For this reason a `module` system is generated within the code. This will allow the use to generate free-standing modules which may be independently run without interference. The module system comprises of the following parts:

- A module folder
- A python file within the folder that will be dynamically loaded if necessary
- A `main()` function within this file that will be called after loading the module
- A [`config\module.json`](../blob/master/config/modules.json) config file that will be used to determine which modules should be run. Optionally, the modules to be run can be specified by command line parameters. More on this later. 

Overall, within the project, the module system comprises of the following files/folder structure. Here one can see three modules: `module1`, `anotherModule`, and `yetAnotherModule`. Of course, you would want to provide meaningful names to the different modules.

In this structure

```
├── config
│   ├── modules.json          # configuration specifying which module(s) to run
│   └── modules               # <== Module specific configurations
│       ├── module1.json
│       ├── anotherModule.json
│       └── yetAnotherModule.json
└── src
    ├── Makefile
    ├── <mainProgram>.py      # <== Main program (Here, RLalgos.py)
    └── modules
        ├── module1
        │   ├── __init__.py
        │   └── module1.py
        ├── anotherModule
        │   ├── __init__.py
        │   └── anotherModule.py
        └── yetAnotherModule
            ├── __init__.py
            └── yetAnotherModule.py
```

## Structure of [`modules.json`](../blob/master/config/modules.json)

[`config/modules.json`](../blob/master/config/modules.json) comprises of the list of modules that are available. This JSON file needs to be updated every time a new module is created. For the folder structure shown above, the module structure will look like the following:

```javascript
[
    {
        "moduleName" : "module1",
        "path"       : "modules/module1/module1.py",
        "execute"    : false,
        "description": "",
        "owner"      : ""
    },{
        "moduleName" : "anotherModule",
        "path"       : "modules/anotherModule/anotherModule.py",
        "execute"    : false,
        "description": "",
        "owner"      : ""
    },{
        "moduleName" : "yetAnotherModule",
        "path"       : "modules/yetAnotherModule/yetAnotherModule.py",
        "execute"    : false,
        "description": "",
        "owner"      : ""
    }
]
```

This is a list of modules available, along with their names. The `moduleName` is used for generating the name of the module with which it will be referred. This is generic and is independent of the actual location of the files associated with the module. 

The `path` of the module corresponds to the Python file that will be dynamically loaded when wee want this module to execute. 

The `execute` flag determines whether the module is going to be loaded and executed or not.

You are welcome to put any other key-value pairs within the dictionary, and they will be neglected. In larger projects, it is recommended that the owner of the module be specified, and also a short description of the module. 

## Example of a simple module: [`module1`](../blob/master/src/modules/module1)

A stripped-down version of the code for [`module1.py`](../blob/master/src/modules/module1/module1.py) is shown. 

```python
from logs import logDecorator as lD 
import json, pprint

config = json.load(open('../config/config.json'))
logBase = config['logging']['logBase'] + '.modules.module1.module1'

@lD.log(logBase + '.doSomething')
def doSomething(logger):
    print('We are in module 1')
    return

@lD.log(logBase + '.main')
def main(logger, resultsDict):
    print('We get a copy of the result dictionary over here ...')
    pprint.pprint(resultsDict)

    doSomething()

    print('Getting out of Module 1')
    return
```

Note that this function has a [`main()`](../blob/31720d7f6fead7d918711e51f95776565b125832/src/modules/module1/module1.py#L25) function that is called when the module is executed. It has access to a dictionary that parses various command line arguments and passes it inside the module as `resultsDict`. In this particular moodule, the [`main()`](../blob/31720d7f6fead7d918711e51f95776565b125832/src/modules/module1/module1.py#L25) function calls a single function. However, in a more realistic situation, the module will be used for completing a more meaningful task, such as downloading data, doing some form if ETL, etc.

## Executing [`module1`](../blob/master/src/modules/module1):
[`module1`](../blob/master/src/modules/module1) comes prepackaged with the project structure so that one can simply activate the virtual environment, turn on `module1` and run `module1`. To do this, first make sure that the `execute` is set to `true` for `module1` within the [`config\modules.json`](../blob/master/config/modules.json) file. Then, turn on the virtual environment for the project (see [here](Software-Engineering-abstraction) for details), change to the `src` folder, and type `make run`.

You should see the following result:

```bash
(env) $ make run                                                           
../bin/run.sh
Logging level taking from the config file: INFO
We get a copy of the result dictionary over here ...
{'config': {'logging': {'specs': {'file': {},
                                  'logstash': {'todo': False},
                                  'stdout': {'todo': False}}}},
 'dqnAgent': {}}
We are in module 1
Getting out of Module 1
------------------------------
Errors:
```