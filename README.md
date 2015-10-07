# Ordered Jobs Exercise

### Compatability
- ruby 2.2.3

#### Usage
To run the specs:
```
    $ bundle install
    $ rspec
```
Navigate to coverage/index.html to view code coverage

Or to run with manual input in the terminal:

```
    $ start.rb
```

#### Approach
I implemented the solution to the exercise using TDD, taking each scenario in turn and writing code to satisfy the expected output of the scenario. I tackled the scenarios in a slighlty different order than they are given in the exercise as I felt I could do the easier scenarios first then worry about the trickier ones such as ordering and detecting cycles.

The first 3 scenarios I covered were:
- Given you’re passed an empty string (no jobs), the result should be an empty sequence.
- Given the following job structure ```a =>```. The result should be a sequence consisting of a single job a.
- Given the following job structure ```a =>``` ```b =>``` ```c =>```. The result should be a sequence containing all three jobs abc in no significant order.
   
I then progressed to satisfy the scenario:
- Given the following job structure ```a =>``` ```b =>``` ```c => c```. The result should be an error stating that jobs can’t depend on themselves.

As creating the ```Job``` class from passing the 3 previous scenarios allowed me to easily put in a check upon the creation of a ```Job``` which throws a ```SelfDependancyError```

I then tackled the problem of ordering by trying to satisy the simplest scenario:
- Given the following job structure ```a =>``` ```b => c``` ```c =>```. The result should be a sequence that positions c before b, containing all three jobs abc.
   
Once I had passed that scenario it turned out the be a simple modification of the logic to get the more complex ordering to work for:
- Given the following job structure ```a =>``` ```b => c``` ```c => f``` ```d => a``` ```e => b``` ```f =>```. The result should be a sequence that positions f before c, c before b, b before e and a before d containing all six jobs abcdef.

Solving the last scenario involved some reading up on graphs and cycle detections where I read about the Union Find algorithm which my implementation was based on. It involves initialising an empty Hash (relying on the fact that a none existant key returns ```nil``` in Ruby) and iterating over all jobs with a dependancy (because we don't need to waste time checking ones without). Each ```Job``` has a ```job_id``` and a ```dependancy_id``` so for each of these id's in turn we check if it has a value in the Hash; the value representing a dependacny. If no value is found (```nil```) we simply return the id that was passed in, otherwise we recursivley call the ```recursive_find``` method with the dependancy found at that key to see if that has a value. If there is a circular dependancy to two results of the ```find_recursive``` method will be the same and a ```CircularDependacyError``` is raised.