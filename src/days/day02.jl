module day02

using AoC_2021

function solve(input::String = getRawInput(2))
    values = split(input, "\n")
    return [part1(values), part2(values)]
end

function part1(values::Vector{SubString{String}})
    depth = 0
    horizontal = 0

    commands = Dict(
        "forward" => x -> horizontal += x,
        "down" => x -> depth += x,
        "up" => x -> depth -= x
    )

    for command in values
        tokens = split(command)
        direction, magnitude = tokens[1], parse(Int, tokens[2])
        commands[direction](magnitude)
    end

    return depth * horizontal
end


function part2(values::Vector{SubString{String}})
    depth = 0
    horizontal = 0
    aim = 0

    for command in values
        direction, magnitude = command[1:2], parse(Int, command[end-1:end])
        if direction == "fo"
            horizontal += magnitude
            depth += aim * magnitude
        elseif direction == "do"
            aim += magnitude
        elseif  direction == "up"
            aim -= magnitude
        end
    end

    return depth * horizontal
end

end # module