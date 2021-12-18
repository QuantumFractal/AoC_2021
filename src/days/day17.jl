module day17

using AoC_2021
using Base.Iterators


function solve(input::String = getRawInput(17))

    # x=20..30, y=-10..-5

    x_rng = (240,292)
    y_rng = (-90,-57)

    x_range = max(abs.(x_rng)...)
    y_range = max(abs.(y_rng)...)

    highest = 0
    unique = 0
    for j in -y_range:y_range+1
        for i in -x_range:x_range+1
            pos = [0, 0]
            vel = [i, j]
            height = 0
            while pos[1] <= x_rng[2] && pos[2] >= y_rng[1]
                pos += vel

                vel[1] += -1 * sign(vel[1])
                vel[2] -= 1
                height = max(height, pos[2])
                if (x_rng[1] <= pos[1] <= x_rng[2] && y_rng[1] <= pos[2] <= y_rng[2])
                    highest = max(highest, height)
                    unique += 1
                    break
                end
            end
        end
    end
    return (highest, unique)
end





end # module
# what do you get if you add up the version numbers in all packets?