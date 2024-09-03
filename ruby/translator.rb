# This is a simple Ruby program that translates English text to Braille and vice versa.

# Detect input language
def detect_language(input)
    if input =~ /^[\.o\s]+$/i
        return :braille
    else
        return :english
    end
end

# This method takes a string of English text and returns a string of Braille characters.
def eng_to_braille(input, braille_map, num_braille_map, dec_braille_map)
    output = []
    input.chars.each do |char|
        if char =~ /[A-Z]/
            output << braille_map["cap"]
            output << braille_map[char.downcase]
        elsif char =~ /[0-9]/
            output << braille_map["num"] unless output.last == braille_map["num"]
            output << num_braille_map[char]
        elsif char =~ /[[:punct:]]/
            output << braille_map["dec"] unless output.last == braille_map["dec"]
            output << dec_braille_map[char]
        else
            output << braille_map[char]
        end
    end
    output.join(" ")
end

# This method takes a string of Braille characters and returns a string of English text.
def braille_to_eng(input, braille_map, num_braille_map, dec_braille_map)
    reversed_map = braille_map.invert
    output = []
    cap_next = false
    num_mode = false
    dec_next = false

    input.split(" ").each do |braille_char|
        case braille_char
        when braille_map["cap"]
            cap_next = true
        when braille_map["num"]
            num_mode = true
        when braille_map["dec"]
            dec_next = true
        else
            if num_mode
                output << num_braille_map[braille_char]
                num_mode = false
            elsif dec_next
                output << dec_braille_map[braille_char]
                dec_next = false
            elsif cap_next
                output << reversed_map[braille_char].upcase
                cap_next = false
            else
                output << reversed_map[braille_char]
            end
        end
    end
    output.join
end

def main
    # Map of English characters to Braille characters + special cases
    braille_map = {
        # Lowercase letters
        "a" => "o.....", 
        "b" => "o.o...", 
        "c" => "oo....", 
        "d" => "oo.o..", 
        "e" => "o..o..", 
        "f" => "ooo...", 
        "g" => "oooo..", 
        "h" => "o.oo..", 
        "i" => ".oo...", 
        "j" => ".ooo..", 
        "k" => "o...o.", 
        "l" => "o.o.o.", 
        "m" => "oo..o.", 
        "n" => "oo.oo.", 
        "o" => "o..oo.", 
        "p" => "ooo.o.", 
        "q" => "ooooo.", 
        "r" => "o.ooo.", 
        "s" => ".oo.o.", 
        "t" => ".oooo.", 
        "u" => "o...oo", 
        "v" => "o.o.oo", 
        "w" => ".ooo.o", 
        "x" => "oo..oo", 
        "y" => "oo.ooo", 
        "z" => "o..ooo", 
        
        # Special cases
        "cap" => ".....0",
        "dec" => ".o...o",
        "num" => ".o.ooo"
    }
    # Map of Numbers to Braille characters
    num_braille_map = {
        # Numbers
        "1" => "o.....",
        "2" => "o.o...",
        "3" => "oo....",
        "4" => "oo.o..",
        "5" => "o..o..",
        "6" => "ooo...",
        "7" => "oooo..",
        "8" => "o.oo..",
        "9" => ".oo...",
        "0" => ".ooo..",
}
    # Map of Punctuation to Braille characters
    dec_braille_map = {
        # Punctuation
        "." => "..oo.o",
        "," => "..o...",
        "?" => "..o.oo",
        "!" => "..ooo.",
        ":" => "..oo..",
        ";" => "..o.o.",
        "-" => "....oo",
        "/" => ".o..o.",
        "<" => ".oo..o",
        ">" => "o..oo.",
        "(" => "o.o..o",
        ")" => ".o.oo.",
        " " => "......"
}
    # Get user input
    puts "Enter text to translate:"
    input = gets.chomp

    # Detect input language
    input_lang = detect_language(input)

    # Translate input
    case input_lang
    when :english
        output = eng_to_braille(input, braille_map, num_braille_map, dec_braille_map)
    when :braille
        output = braille_to_eng(input, braille_map, num_braille_map, dec_braille_map)
    end

    # Display output
    puts output

end
