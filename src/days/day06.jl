module day06

using AoC_2021
using StatsBase

function solve(input::String = getRawInput(6))
    fish = parse.(Int, split(input, ","))
    
    """ As most will discover, keeping track of 26984457539 fish
        is kind of memory intensive. Since each fish is interchangable
        with one another, we can just keep track of the fish per age
        bracket. We'll need 9 brackets (0 - 8), and I'm using Int128
        just in case we need the extra range. Then we'll build
        a histogram from the initial input fish.
    """
    fish_histo = zeros(Int128, 9)
    for (age, count) in countmap(fish)
        # Julia's arrays are 1-indexed, so offset by 1 :)
        fish_histo[age+1] = count
    end

    return [part1(fish_histo), part2(fish_histo)]
end



""" Since we're dealing with a histogram, each value in
    `age_map` represents the number of fish for that age
    (or index). We'll take all the fish of age zero (index 1)
    and add them to the 6 day old bucket (index 7), then
    age all the other fish like normal.

    We also need to add all the new fish, so where's that line?
    Well the `circshift(age_map, -1)` just wraps the 0-day fish
    to the end of the histogram at age 8. Neat!
"""
function step(age_map)
    spawning_fish = age_map[1]
    age_map = circshift(age_map, -1)
    age_map[7] += spawning_fish
    return age_map
end

""" Then parts 1 and 2 become trivial, just iterate through 
    the required days, stepping the histogram as we go.
"""
function part1(fish_histo::Vector{Int128})
    for _ in 1:80
        fish_histo = step(fish_histo)
    end
    return sum(fish_histo)
end

function part2(fish_histo::Vector{Int128})
    for _ in 1:256
        fish_histo = step(fish_histo)
    end
    return sum(fish_histo)
end


""" I'm also including my naive first solution to get part1, for the 
    sake of completeness.
    
    This is a pretty literal solution, go through all our fish,
    check which ones are ready to spawn a new fish, and update 
    the list.

    It also nearly crashed my computer because I was using Int128's to 
    track each fish :)
"""
function part1_naive(fish)
    for _ in 1:80
        new_fish = 0
        for i in 1:length(fish)
            if fish[i] == 0
                new_fish += 1
                fish[i] = 6
            else
                fish[i] -= 1
            end
        end
    
        append!(fish, fill(NEW_FISH_DAYS, new_fish))
    end

    return length(fish)
end

end #module