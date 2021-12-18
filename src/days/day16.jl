module day16

using AoC_2021
using Base.Iterators

to_bits(hex_str) = reverse(digits(parse(Int, hex_str, base = 16), base=2))
HEX_MAP = Dict((uppercase(string(i, base=16)) => string(i, base=2, pad=4) for i in 0:15))

# I gave up and wrote an absolutely horrific python version of this script. I'll come back and make it more "julian" later.
function scan_input(input_string)
    bit_string = ""
    for char in split(input_string, "")
        bit_string *= HEX_MAP[char]
    end
    return bit_string
end

function solve(input::String = getRawInput(16))
    bits = scan_input(input)

    parse_bits(bits)
end


function parse_bits(bits)
    if length(bits) < 6
        return 
    end

    version, type = parse.(Int, [bits[1:3], bits[4:6]], base=2)

    #println(bits)

    if type == 4
        #println("Got literal!")
        
        chunk = []
        literal_bits = []
        start = 7
        scan = true
        while scan
            chunk = bits[start:start+4]
            scan = chunk[1] == '1'
            literal_bits = vcat(literal_bits, chunk[2:end])
            start += 5
        end
        
        literal = parse(Int, join(literal_bits), base=2)
        if checkbounds(Bool, bits, start) && length(bits[start:end]) > 7
            return vcat(literal, parse_bits(bits[start:end]))
        else
            return literal
        end
    else
        # NOT A LITERAL OPERATOR!
        l_type = bits[7]
        if l_type == '0'
            # Subpackets by length
            l_packet = parse(Int, bits[8:22], base=2)
            return parse_bits(bits[23:23+l_packet])
        else
            # Subpackets by count
            l_packet = parse(Int, bits[8:19], base=2)

            println("l_type: $l_type")
        end
    end
end



end # module
# what do you get if you add up the version numbers in all packets?