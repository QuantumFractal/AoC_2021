# Look! Another Advent of Code Repo!

This time written in Julia.

Well folks, it's that time of year again.
Time for the Advent of Code.

Each day has my _annotated_ solution for your enjoyment/education/horror!

I tried to make this Julia package _kind of_ easy to read, by no means best practices.
I'll _try_ to leave some comments explaining some of the fancier Julia stuff
and I might even try to finish all the challenges this year!

## Updates

Finished days (both stars): 1, 2, 3, 4, 5, 6, 7, 8, 9

## Benchmarks


Using `BenchmarkTools.jl` solving both parts of each day:

Run on Julia 1.6.1 + Ryzen 9 5900X 12-Core (~4Ghz)
| Day | Time | Allocated memory |
|----:|-----:|-----------------:|
| 1 | 245.900 μs | 124.92 KiB |
| 2 | 472.900 μs | 290.09 KiB |
| 3 | 1.308 ms | 1.45 MiB |
| 4 | 2.901 ms | 2.68 MiB |
| 5 | 4.400 ms | 33.20 MiB |
| 6 | 97.500 μs | 107.92 KiB |
| 7 | 150.700 μs | 95.48 KiB |
| 8 | 2.524 ms | 3.30 MiB |
| 9 | 17.522 ms | 7.55 MiB |

## Usage

```
echo "<your session token>" >> .session
julia --project=.
julia> using AoC2021
```
