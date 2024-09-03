# This is a simple Ruby program that translates English text to Braille and vice versa.
# Author: Michael Palummieri
# Date: 2024-09-02
# For Shopify internship application


# Method to detect input language
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
    number_mode = false

    input.chars.each do |char|
        if number_mode
            if char == " "
                number_mode = false # Exit number mode if space is encountered
                output << braille_map[" "]
            else
                output << num_braille_map[char]
            end
        elsif char =~ /[0-9]/
            # Add number indicator if not already in number mode
            output << braille_map["num"]
            number_mode = true
            output << num_braille_map[char]

        elsif char =~ /[A-Z]/
            output << braille_map["cap"]
            output << braille_map[char.downcase]
            
        elsif char =~ /[[:punct:]]/
            output << braille_map["dec"] unless output.last == braille_map["dec"]
            output << dec_braille_map[char]
        else
            output << braille_map[char]
        end
    end
    output.join
end

# This method takes a string of Braille characters and returns a string of English text.
def braille_to_eng(input, braille_map, num_braille_map, dec_braille_map)
    reversed_map = braille_map.invert
    reversed_num_map = num_braille_map.invert
    reversed_dec_map = dec_braille_map.invert
    output = []
    cap_next = false
    num_mode = false
    dec_next = false

    # Split input into 6-character chunks for reading braille characters
    input.scan(/.{1,6}/).each do |braille_char|
        case braille_char
        when braille_map["cap"]
            cap_next = true
        when braille_map["num"]
            num_mode = true
        when braille_map["dec"]
            dec_next = true
        else
            if num_mode
                if braille_char == braille_map[" "]
                    num_mode = false # Exit number mode if space is encountered
                else
                    output << reversed_num_map[braille_char]
                end
            elsif dec_next
                output << reversed_dec_map[braille_char]
                dec_next = false
            elsif cap_next
                output << reversed_map[braille_char].upcase
                cap_next = false
            else
                output << reversed_map[braille_char]
            end
            num_mode = false if reversed_map[braille_char] == " "
        end
    end
    output.join
end

def main
    # Map of English characters to Braille characters + special cases
    braille_map = {
        # Lowercase letters
        "a" => "O.....", 
        "b" => "O.O...", 
        "c" => "OO....", 
        "d" => "OO.O..", 
        "e" => "O..O..", 
        "f" => "OOO...", 
        "g" => "OOOO..", 
        "h" => "O.OO..", 
        "i" => ".OO...", 
        "j" => ".OOO..", 
        "k" => "O...O.", 
        "l" => "O.O.O.", 
        "m" => "OO..O.", 
        "n" => "OO.OO.", 
        "o" => "O..OO.", 
        "p" => "OOO.O.", 
        "q" => "OOOOO.", 
        "r" => "O.OOO.", 
        "s" => ".OO.O.", 
        "t" => ".OOOO.", 
        "u" => "O...OO", 
        "v" => "O.O.OO", 
        "w" => ".OOO.O", 
        "x" => "OO..OO", 
        "y" => "OO.OOO", 
        "z" => "O..OOO", 
        " " => "......",
        # Special cases
        "cap" => ".....O",
        "dec" => ".O...O",
        "num" => ".O.OOO"
    }
    # Map of Numbers to Braille characters
    num_braille_map = {
        # Numbers
        "1" => "O.....",
        "2" => "O.O...",
        "3" => "OO....",
        "4" => "OO.O..",
        "5" => "O..O..",
        "6" => "OOO...",
        "7" => "OOOO..",
        "8" => "O.OO..",
        "9" => ".OO...",
        "0" => ".OOO..",
}
    # Map of Punctuation to Braille characters
    dec_braille_map = {
        # Punctuation
        "." => "..OO.O",
        "," => "..O...",
        "?" => "..O.OO",
        "!" => "..OOO.",
        ":" => "..OO..",
        ";" => "..O.O.",
        "-" => "....OO",
        "/" => ".O..O.",
        "<" => ".OO..O",
        ">" => "O..OO.",
        "(" => "O.O..O",
        ")" => ".O.OO.",
}
    # Get input from command line arguments
    input = ARGV.join(" ") 

    # Get input if none is provided
    if input.empty?
        puts "Enter text to translate:"
        input = gets.chomp
    end

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
main 