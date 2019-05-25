[Sphinx](http://www.sphinx-doc.org/en/master/index.html) is used for generating documentation 
for the project. In particular the [Autodoc](http://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html) 
extension allows the generation of API documentation directly from doc strings 
present within the different files. 

For generating the API, type `make doc` in the [`src`](../blob/master/src) folder. This will generate HTML 
documentation within the `docs/` folder. Finally, you may wish to enable the website within your 
`Settings > Github Pages` to point to the `master branch /docs folder`. This will allow your API 
documentation to be viewed within the sites event page.

You are highly encouraged to generate proper doc strings for all your code. Please remember to add documentation 
of new modules and libraries in the `__init__.py` functions within each folder.