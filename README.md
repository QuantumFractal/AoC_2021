# Look! Another Advent of Code Repo!

## DISCLAIMER

```
   This place is not a place of honor... no highly esteemed deed is commemorated here... nothing valued is here.
    What is here was dangerous and repulsive to us. This message is a warning about danger.
    The danger is in a particular location... it increases towards a center... the center of danger is here... of a particular size and shape, and below us.
    The danger is still present, in your time, as it was in ours.
    The danger is to the body, and it can kill.
    The form of the danger is an emanation of energy.
    The danger is unleashed only if you substantially disturb this place physically. This place is best shunned and left uninhabited.
```


## Wait, what's Advent of Code?
For the uninitiated, [Advent of Code](https://adventofcode.com/2021) is a yearly, holiday coding puzzle which releases
new problems daily leading up to Christmas. The problems cover a wide range of computer science problems, and it's a 
great way to learn a new language. I'm doing the problems this year in Julia.


## Wait, what's Julia?

Julia is a high-performance, dynamically typed, LLVM-backed language. It's extremely fast while providing high level
language features making it also extremely expressive. It should be familiar to anyone who's worked in R / Python before, as
well as more strictly typed langs such as Java or C++. Currently, it's main application is in the scientific computing world,
accelerating research across the world.

## What to Expect

Each day has my _annotated_ solution for your enjoyment/education/horror!

I tried to make this Julia package _kind of_ easy to read, by no means best practices.
I'll _try_ to leave some comments explaining some of the fancier Julia stuff
and I might even try to finish all the challenges this year!


## Benchmarks

Finished days (both stars): 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

Using `BenchmarkTools.jl` solving both parts of each day:

Run on Julia 1.6.1 + Ryzen 9 5900X 12-Core (~4Ghz)
| Day | Time | Allocated memory |
|----:|-----:|-----------------:|
| 1 | 249.800 ??s | 124.92 KiB |  
| 2 | 475.200 ??s | 290.09 KiB |  
| 3 | 1.311 ms | 1.45 MiB |      
| 4 | 2.816 ms | 2.68 MiB |
| 5 | 4.482 ms | 33.20 MiB |
| 6 | 98.000 ??s | 107.92 KiB |
| 7 | 151.100 ??s | 95.48 KiB |
| 8 | 2.551 ms | 3.30 MiB |
| 9 | 4.695 ms | 8.27 MiB |
| 10 | 455.800 ??s | 286.03 KiB |

## Usage

```
echo "<your session token>" >> .session
julia --project=.
julia> using AoC2021
```
