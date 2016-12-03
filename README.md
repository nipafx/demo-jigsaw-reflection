# Jigsaw vs Reflection

To demonstrate how Jigsaw interacts with reflection, this repository creates two modules:

* _owner_, which contains `Owner` with one method for each visibility
* _intruder_, which contains `Intruder`, breaking into `Owner` via reflection

The script `execute.sh` creates the modular JARs for both modules, using different module descriptors for _owner_ and switching between class and module path.
