# Quantum-Adiabatic-Simulator
This code simulates a Quantum Adaibatic Computer annealing of a graph of n logical spins, where each spin is connected to
every other spin. Each logical spin is formed as two physical spins with a strong (relative to the connections between
logical spins) connection energy with value Jf, or J-ferromagnetic. To run the code, you can call main.m with specified values
of the number of logical spins, the T (time length of annealing), Jf, and the file that the graph will be written to. You can 
also call Qcmodel.m, specify those values inside the code, and call the number of simulations you want to run.

The value of logical should be odd. Additiionally, using a value of logical above ~ 15 could crash your computer as the code deals with matrices the size of 2^(2 x logical) by 2^(2 x logical).

To see a rough explanation of Quantum Adiabatic Computing, you can see a presentation I gave as part of Harvard's PRISE program:
https://docs.google.com/presentation/d/10Cn4zziyhO1Dfd0wvOZpdtjDWhzkPacJcy7qMQjjbBg/edit?usp=sharing
