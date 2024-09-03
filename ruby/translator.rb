# This is a simple Ruby program that translates English text to Braille and vice versa.

# Detect input language
def detect_language(input)
    if input =~ /^[\.o\s]+$/i
        return "braille"
    else
        return "english"
    end
end

# This method takes a string of English text and returns a string of Braille characters.
def braille_to_eng(input)


def main
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
        # Special cases
        "cap" => ".....0",
        "dec" => ".o...o",
        "num" => ".o.ooo"
    }



