module day20

using AoC_2021
using Base.Iterators

# LMAO this soluton halfway works, I didn't originally decompose! If you're seeing this, tweet @ me. @tmoll :)

get_val(image, x, y) = parse(Int, join(reshape(image[x-1:x+1, y-1:y+1], 1, 9)), base=2)

function print(img)
    w, h = size(img)
    for i in 1:w
        for j in 1:h
            Base.print(img[j, i] == 1 ? '#' : '.')
        end
    println()
    end
end

function solve(input::String = getRawInput(20))
    algo_input, image_input = split(input, "\n\n")
    
    algo = map(c -> c == "#" ? 1 : 0, split(algo_input, ""))
    initial = map(c -> c == '#' ? 1 : 0, hcat(collect.(split(image_input))...))

    b_sz = size(initial)[1]*6
    image = zeros(Int, b_sz, b_sz)
    buffer = zeros(Int, b_sz, b_sz)

    w, h = size(initial)

    println("w: $w, h: $h")
    mid = b_sz ÷ 2

    x_rng, y_rng = mid-(w÷2):mid+(w÷2), mid-(h÷2):mid+(h÷2)
    if w % 2 == 0
        x_rng, y_rng = mid-(w÷2):mid+(w÷2)-1, mid-(h÷2):mid+(h÷2)-1
    end

    println("x_rng: $x_rng, y_rng:$y_rng")
    println("$(size(image[x_rng, y_rng])) == $(size(initial))")
    
    image[x_rng, y_rng] .= initial

    for i in 1:50
        image = ENHANCE(image, algo)
    end

    return image
end

function ENHANCE(image, algo)
    println("Processing image of size $(size(image))")
    buffer = zeros(Int, size(image))
    width, height = size(image)

    for j in 2:width-1
        for i in 2:height-1
            idx = get_val(image, i, j)
            buffer[i, j] = algo[idx+1]
        end
    end

    return buffer
end

end # module