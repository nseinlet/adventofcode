WITH input AS (VALUES('C Z'),('B Y'),('C X'),('B Z'),('C Y'),('B Y'),('C Z'),('C Z'),('B Y'),('B X'),('C Y'),('B Y'),('B Z'),('A Z'),('A Y'),('B X'),('C Y'),('C Z'),('B Z'),('A Y'),('C Y'),('C Z'),('A Y'),('C Z'),('B X'),('B Y'),('B Y'),('A Y'),('C Z'),('B Y'),('B Y'),('B Y'),('C Z'),('C Y'),('B X'),('C Y'),('A Z'),('C Y'),('B X'),('B Z'),('C Z'),('C Z'),('B X'),('A Y'),('A Y'),('C Z'),('C Z'),('C Z'),('B Y'),('C Y'),('B Y'),('C Z'),('C Z'),('A Z'),('B Y'),('C Y'),('B X'),('A Y'),('C Y'),('B Y'),('C Z'),('A Y'),('B Y'),('B Y'),('B Y'),('B Z'),('C Y'),('A X'),('C Y'),('B Y'),('C Z'),('A Z'),('B X'),('C Z'),('C X'),('A Y'),('C Y'),('B Z'),('C Y'),('C Z'),('B X'),('C Z'),('C Y'),('B Y'),('B Y'),('B Y'),('B Y'),('A Y'),('C Z'),('C Z'),('B Y'),('B Y'),('C Z'),('B Z'),('B Y'),('B Y'),('B Y'),('A Y'),('B Z'),('B Y'),('C Y'),('B X'),('B Y'),('B X'),('C Z'),('B X'),('C Y'),('B Z'),('C Z'),('C Z'),('B Y'),('B Z'),('C Z'),('B X'),('C Y'),('B Y'),('C Y'),('C Z'),('C Y'),('B Z'),('C Z'),('B X'),('B Y'),('C Y'),('B X'),('B Z'),('B Y'),('C Y'),('B X'),('C Y'),('C Z'),('B Y'),('B Y'),('B X'),('C Y'),('C Z'),('C Z'),('B X'),('C Y'),('C Z'),('B Y'),('B Z'),('C Y'),('C Y'),('C Z'),('C Y'),('C Z'),('B Y'),('B Y'),('C Z'),('C Y'),('C Y'),('C Y'),('B Y'),('B Y'),('A Y'),('C Z'),('B X'),('B Y'),('C Z'),('C Z'),('C Z'),('B Y'),('B Z'),('C Y'),('C X'),('B Y'),('C Z'),('C Z'),('B Y'),('C Z'),('C Z'),('C Z'),('B Z'),('C Y'),('B Y'),('B X'),('C Z'),('B X'),('B X'),('B Y'),('C Z'),('B X'),('C Z'),('B Z'),('C Z'),('B X'),('A Y'),('B X'),('A Y'),('A Y'),('A Z'),('C Y'),('B Z'),('B Z'),('B X'),('C Y'),('C Y'),('B Y'),('C Z'),('B X'),('C Z'),('B Y'),('B Z'),('C Z'),('C Z'),('B Y'),('C Y'),('B Y'),('C Y'),('A Y'),('C Z'),('C Y'),('C Y'),('B Y'),('B Z'),('C Y'),('B X'),('B Z'),('A Z'),('C Y'),('B X'),('B Y'),('B Y'),('B Y'),('B Z'),('C Z'),('A X'),('B Z'),('B X'),('C Y'),('B Z'),('B Y'),('A Y'),('C Z'),('B X'),('C Z'),('B Z'),('C Z'),('B Y'),('C Z'),('C Y'),('B X'),('C Z'),('C Y'),('B Y'),('C Z'),('C Y'),('C Z'),('C Y'),('B Z'),('A Y'),('B Y'),('B X'),('C Y'),('A X'),('C Z'),('A Y'),('C Z'),('B Y'),('C Z'),('B Y'),('C Z'),('B Y'),('B Y'),('B Y'),('B Y'),('A Y'),('C Z'),('B Y'),('A Z'),('B Z'),('C Y'),('B Y'),('B Z'),('A Y'),('C Z'),('B Y'),('B Y'),('C Z'),('A Z'),('B X'),('A Y'),('C Z'),('B Z'),('B Z'),('B Y'),('B X'),('A Y'),('B Y'),('A X'),('C X'),('B Z'),('B Y'),('C Y'),('C Z'),('C Y'),('C Z'),('B Y'),('B Z'),('C Y'),('A Z'),('C Y'),('C Y'),('C Y'),('A Z'),('C Y'),('C Z'),('C Z'),('C Z'),('C X'),('B Y'),('B Y'),('C Y'),('C Z'),('C Y'),('B Y'),('C Y'),('C Z'),('C Z'),('B Z'),('B Y'),('B Y'),('B Y'),('C Z'),('C Y'),('B X'),('C Y'),('B Z'),('B Y'),('B Y'),('B Y'),('C Y'),('C Y'),('C Z'),('C Z'),('C Y'),('B X'),('C Y'),('B Y'),('B Z'),('B Z'),('B Z'),('C Z'),('B X'),('C Y'),('C X'),('C Y'),('B X'),('C Z'),('A Y'),('A Y'),('B X'),('C Z'),('A Z'),('C Y'),('C Z'),('A Y'),('C Z'),('B Y'),('B Y'),('C Y'),('B Y'),('C Y'),('B Y'),('C Y'),('B Y'),('C Y'),('C Y'),('B Y'),('C Z'),('B Z'),('C Y'),('A Y'),('C Y'),('A Y'),('B X'),('C Y'),('A Y'),('B Z'),('B Y'),('C Y'),('B Y'),('C Y'),('B Y'),('C Y'),('C Z'),('C Y'),('C Z'),('B Y'),('C Y'),('C Z'),('B Y'),('B Z'),('C Y'),('A Y'),('C Z'),('C Z'),('C Z'),('B Z'),('C Y'),('A Y'),('B Z'),('A Y'),('B Y'),('C Y'),('C Z'),('C Y'),('A Y'),('B X'),('A Z'),('C Z'),('C Y'),('B X'),('C Z'),('A X'),('C Z'),('C Y'),('C Z'),('B Y'),('C Y'),('C Y'),('B Y'),('C Y'),('C Z'),('C Y'),('C Y'),('C Y'),('A Y'),('C Z'),('C Y'),('C Z'),('C Z'),('B X'),('A Y'),('B X'),('B Y'),('A Y'),('B Y'),('A Y'),('C Z'),('A Y'),('C Y'),('C Y'),('B Y'),('C Y'),('B Z'),('C Y'),('C Z'),('B Z'),('B Y'),('B X'),('B Y'),('B Y'),('C Y'),('C Y'),('B Y'),('B X'),('C Z'),('B X'),('B X'),('A Y'),('B Z'),('B X'),('A Y'),('C Y'),('C Y'),('B X'),('B Z'),('C Y'),('B Y'),('B X'),('B X'),('C Y'),('C Z'),('B Y'),('B Y'),('B Y'),('A Y'),('A Y'),('C Z'),('C Z'),('C Y'),('B X'),('C Y'),('C Y'),('B Z'),('B Z'),('A X'),('C Y'),('C Y'),('A Z'),('A Y'),('B X'),('B Y'),('C Y'),('B Y'),('C Z'),('B Y'),('C Y'),('B Y'),('C Z'),('C X'),('C Z'),('A Z'),('B X'),('A Z'),('C Z'),('B Y'),('C Y'),('B Z'),('C Y'),('B X'),('C Y'),('C Z'),('B Y'),('A Y'),('C Y'),('C Y'),('B Z'),('B Y'),('B X'),('C Z'),('B Y'),('C Y'),('C Y'),('C Y'),('A Z'),('B Y'),('B Y'),('C Y'),('B Y'),('C Z'),('B Y'),('C Y'),('B Y'),('C Z'),('B X'),('C Y'),('B Y'),('B X'),('C Y'),('C Z'),('C Y'),('B X'),('B Y'),('C Y'),('B Z'),('B X'),('C Y'),('B X'),('B Y'),('B Z'),('C Y'),('B Y'),('C Y'),('B Y'),('B Y'),('C Y'),('B Z'),('B Y'),('C Z'),('C Z'),('B X'),('A X'),('C Z'),('B Z'),('B Y'),('B X'),('C Z'),('C Z'),('B Z'),('A Z'),('B Y'),('C Y'),('C Z'),('C Y'),('C Y'),('C Y'),('C Z'),('B Y'),('B Y'),('C Y'),('C Z'),('C Z'),('C Y'),('C Y'),('C Z'),('B Y'),('C Y'),('B Y'),('B Y'),('A Y'),('C Y'),('A Y'),('C Z'),('C Y'),('C Z'),('C X'),('B X'),('C Z'),('A Y'),('B X'),('C Z'),('C Z'),('C Y'),('B Z'),('B Y'),('A Y'),('C Z'),('B X'),('B Y'),('B Z'),('B X'),('C Y'),('B Y'),('C Z'),('C Z'),('C Z'),('C Y'),('A Y'),('C Z'),('C Z'),('B Y'),('B Y'),('B Y'),('C Y'),('C Y'),('C Z'),('B X'),('C Y'),('C Y'),('C Y'),('B Y'),('C X'),('B Y'),('B Y'),('C Y'),('A Z'),('C Y'),('C Z'),('A Y'),('C Y'),('B Z'),('C Y'),('C Z'),('A X'),('B X'),('C Z'),('C Y'),('B Y'),('C Y'),('C Y'),('B Y'),('C Z'),('C X'),('C Y'),('C Y'),('B X'),('C Y'),('B Y'),('C Y'),('C Z'),('A Z'),('B X'),('B X'),('C Z'),('C Y'),('B Y'),('B Z'),('B Y'),('B Z'),('A X'),('B X'),('B X'),('B X'),('C Y'),('A X'),('C Z'),('C Z'),('B Y'),('B X'),('B Y'),('B Y'),('C Z'),('B Z'),('C Y'),('C Y'),('B X'),('B Z'),('C X'),('A X'),('B Y'),('C X'),('C X'),('B Y'),('C Z'),('C Z'),('C Z'),('B X'),('B Z'),('C Y'),('B Y'),('A Y'),('C Z'),('B Z'),('A Z'),('B X'),('B X'),('B X'),('B Y'),('B X'),('B X'),('B X'),('B Y'),('C Z'),('C Y'),('C Y'),('C Y'),('A Y'),('C Z'),('C Y'),('C Z'),('C Y'),('B Y'),('A X'),('A Z'),('A Z'),('C Z'),('B Z'),('B Z'),('B Y'),('C Z'),('B Y'),('B X'),('B Y'),('B Z'),('A Y'),('B Y'),('B Y'),('B Z'),('C Y'),('B Y'),('C Y'),('B Y'),('C Y'),('B Z'),('C Z'),('B Z'),('C Y'),('B Z'),('B Y'),('B Y'),('A Y'),('C Z'),('B Y'),('B X'),('B Y'),('B X'),('C Z'),('C Y'),('B Z'),('C Z'),('C Z'),('A Z'),('C Z'),('B X'),('C Z'),('C Z'),('C Z'),('C Y'),('B Y'),('B X'),('C Y'),('C Y'),('C Z'),('C Z'),('B X'),('C Y'),('C Z'),('B Z'),('A Y'),('A Y'),('B Y'),('C Y'),('B Z'),('A X'),('C X'),('C Y'),('A Y'),('B Z'),('B X'),('C Z'),('C Y'),('B Y'),('C Z'),('C Y'),('B Z'),('C Z'),('C Z'),('C Y'),('B X'),('C Z'),('C Y'),('B Y'),('C Y'),('C Y'),('C Z'),('B X'),('C Y'),('C Z'),('C Z'),('C Y'),('C Y'),('B Y'),('C Y'),('B X'),('C Z'),('B Z'),('B X'),('A Z'),('C Z'),('B Z'),('C Z'),('C Y'),('B X'),('C Z'),('A Z'),('A Y'),('A Y'),('C Y'),('B Y'),('B X'),('C Y'),('C Z'),('B X'),('A Y'),('B Y'),('B X'),('B X'),('C Y'),('B Y'),('C Y'),('C Z'),('B Y'),('B X'),('C Y'),('B Y'),('B X'),('A Y'),('B Y'),('B Y'),('C Y'),('A Y'),('B Y'),('A Z'),('C Z'),('A X'),('C Z'),('C X'),('C Z'),('C Z'),('C Y'),('B Z'),('B Z'),('A Z'),('A Y'),('B Y'),('B Y'),('C X'),('C Z'),('C Z'),('B Z'),('A X'),('C Y'),('C Z'),('A Y'),('A Y'),('B X'),('C Z'),('B Z'),('A X'),('C Z'),('C Y'),('B X'),('C Y'),('C Y'),('C Z'),('C Z'),('B X'),('C Z'),('A Y'),('B Y'),('B X'),('B Y'),('C Y'),('B X'),('C Y'),('B Y'),('A X'),('C Z'),('C Y'),('C Z'),('B Z'),('C Y'),('C Y'),('C Z'),('C Z'),('A Y'),('C Z'),('B Y'),('C Z'),('C Y'),('B Y'),('C Y'),('A Y'),('C Y'),('A Z'),('C Y'),('A Z'),('C Z'),('C Z'),('B Y'),('C Z'),('C Y'),('A Y'),('C Y'),('A Y'),('C Z'),('B Z'),('B Y'),('B Z'),('C Z'),('B Y'),('A Z'),('B Y'),('C Z'),('A Y'),('B Y'),('A Z'),('B X'),('B Z'),('B X'),('B Y'),('B Y'),('B Y'),('C Y'),('C Z'),('B Y'),('C X'),('B Y'),('A X'),('B Y'),('B Y'),('C Z'),('C Z'),('A X'),('C Z'),('C Y'),('C Z'),('B Y'),('B Y'),('B X'),('B X'),('A X'),('B X'),('B Y'),('B Y'),('C Z'),('B Z'),('B Y'),('B Y'),('B Z'),('B Y'),('C Z'),('C Z'),('B X'),('B Z'),('A Z'),('B Z'),('C Z'),('B Z'),('C Y'),('C Z'),('C Z'),('B X'),('C Y'),('C Y'),('B X'),('B Y'),('C Y'),('B Y'),('C Z'),('C Y'),('B Y'),('B X'),('A Z'),('C Z'),('C Y'),('C Y'),('B Z'),('B X'),('A Z'),('B Z'),('C Z'),('C Z'),('B X'),('B X'),('C Z'),('C Y'),('B Z'),('C Z'),('C Z'),('B X'),('C Y'),('C Y'),('B Y'),('C Y'),('B Z'),('C Z'),('A Y'),('B X'),('C Y'),('C Z'),('B Y'),('B X'),('B X'),('A Z'),('B Y'),('B Y'),('C Z'),('B X'),('A Y'),('A X'),('C Y'),('B Z'),('B X'),('A Y'),('B Y'),('B X'),('C Z'),('C Z'),('C Z'),('C Z'),('C Z'),('A Y'),('C Y'),('C Z'),('C Y'),('C Z'),('C Y'),('A Y'),('B Y'),('C Y'),('C Y'),('B Y'),('C Z'),('A X'),('B Y'),('C Y'),('C Z'),('B Y'),('C Z'),('B Y'),('A Z'),('B X'),('B X'),('A Y'),('B X'),('C Y'),('B Z'),('B Y'),('B Z'),('C Y'),('A Y'),('C Z'),('A Y'),('A Y'),('C Z'),('C Z'),('C Y'),('B X'),('A Y'),('C X'),('C Y'),('C X'),('C Z'),('B Y'),('B Y'),('C Z'),('B X'),('B Y'),('C Z'),('B X'),('C Z'),('C Z'),('B Y'),('A Y'),('B X'),('B Y'),('C Z'),('B Y'),('C Z'),('A Y'),('B X'),('C Z'),('C Y'),('A Y'),('C Z'),('A Y'),('C Y'),('A Y'),('C Z'),('B X'),('B Y'),('B Z'),('A Y'),('C Z'),('C Y'),('C Z'),('B Z'),('C Z'),('C Y'),('C Y'),('B Z'),('C Z'),('C Y'),('B X'),('B Y'),('A Y'),('A Y'),('B X'),('C Y'),('C Y'),('C Z'),('B Y'),('B Z'),('B X'),('B Y'),('B Y'),('B Z'),('B Y'),('B Y'),('B Z'),('B Y'),('B X'),('C Y'),('C Y'),('C Z'),('B X'),('C Z'),('C Y'),('A Y'),('C Y'),('C Z'),('B Y'),('A Z'),('C Y'),('C Z'),('B X'),('A Y'),('C Y'),('C Y'),('C Y'),('A Y'),('A Y'),('C Y'),('B X'),('C Z'),('A Y'),('C X'),('B Y'),('C Y'),('B Y'),('C Y'),('B Z'),('C Y'),('A Z'),('B Y'),('A Y'),('A Y'),('B X'),('B Y'),('B Y'),('B Y'),('C Y'),('B Z'),('C Z'),('B X'),('B X'),('B X'),('C Y'),('B X'),('C Z'),('B Z'),('C Z'),('B Y'),('C Y'),('C Z'),('C Y'),('C Y'),('B Y'),('B Y'),('B Z'),('B Y'),('C Z'),('B Y'),('B X'),('C Z'),('A Z'),('C Y'),('C Y'),('C Z'),('B Y'),('A Y'),('C Z'),('C Y'),('B Z'),('C Z'),('B Y'),('B Z'),('B X'),('C Y'),('B X'),('C Z'),('B Z'),('C Z'),('C Z'),('B Y'),('B X'),('B X'),('C X'),('C Z'),('C Z'),('A Y'),('C Z'),('C Y'),('C Y'),('C Y'),('C Z'),('C Y'),('B X'),('B X'),('B X'),('C X'),('C Y'),('B X'),('B X'),('B X'),('B Z'),('A Z'),('B X'),('C Y'),('B Y'),('C Z'),('A Z'),('B Y'),('B X'),('B Z'),('C Y'),('B Z'),('B Y'),('A Z'),('C Z'),('B Y'),('C Y'),('B Y'),('B X'),('C Y'),('A Z'),('C Z'),('C Y'),('B Y'),('B X'),('C Y'),('C Z'),('C Y'),('C Z'),('B Y'),('A Z'),('B Y'),('B X'),('C Y'),('C Y'),('A X'),('B X'),('C Y'),('C Z'),('A Z'),('C Z'),('C Y'),('C Z'),('B Y'),('B Y'),('C Z'),('A Y'),('C Z'),('B X'),('B X'),('B Y'),('B Y'),('B X'),('B X'),('B X'),('B Z'),('B X'),('A X'),('A Y'),('C Z'),('C Y'),('A Y'),('C Y'),('C Z'),('C Y'),('B Y'),('C Z'),('A Y'),('B X'),('B X'),('C Y'),('C Y'),('B Z'),('B Z'),('B Z'),('B Y'),('B Y'),('B Y'),('B Y'),('C Y'),('C Z'),('B Z'),('A Y'),('B Z'),('C Y'),('C Y'),('C Z'),('B X'),('A Y'),('C Y'),('B X'),('B Z'),('A Y'),('C Y'),('C Z'),('A X'),('C Z'),('B X'),('B X'),('B Z'),('A Y'),('C Z'),('B Z'),('C Z'),('A Y'),('A Y'),('B Y'),('B Y'),('A Y'),('C Y'),('A Y'),('B X'),('C Y'),('C Z'),('B Y'),('B Z'),('C Z'),('C Y'),('B Y'),('C Y'),('C Z'),('B Y'),('C Z'),('C Y'),('A Y'),('C Y'),('C Y'),('B X'),('C Y'),('B Y'),('B Y'),('B X'),('C Z'),('B Y'),('C Y'),('C Y'),('B Y'),('B Y'),('B Z'),('C Y'),('C Z'),('A X'),('C Z'),('C Y'),('C Y'),('C Y'),('B Z'),('C Y'),('C Y'),('C Y'),('A Y'),('C Y'),('A Y'),('C Y'),('C Y'),('C Y'),('C Y'),('C Y'),('C Y'),('A Z'),('B Z'),('B Y'),('C Z'),('B Y'),('C Z'),('B Y'),('C Z'),('B Y'),('C Z'),('C Z'),('C Z'),('C Y'),('C Z'),('B Y'),('B Y'),('C Y'),('C Z'),('B Z'),('C Y'),('A Y'),('C Y'),('C Z'),('C Y'),('C Y'),('A Z'),('B Y'),('C Y'),('B X'),('B Y'),('C Y'),('C Z'),('B Y'),('C Y'),('B X'),('B X'),('B Y'),('C Y'),('B Z'),('B Y'),('A Y'),('B Y'),('B Y'),('B X'),('C Z'),('B Z'),('B X'),('C Z'),('A Z'),('B Z'),('C Y'),('C Z'),('C Y'),('B X'),('C Y'),('C X'),('B Z'),('C Y'),('C Y'),('B Y'),('C X'),('B Y'),('C Z'),('A Z'),('C X'),('A Y'),('B Y'),('B Y'),('C Z'),('C Z'),('B Y'),('B Y'),('B Z'),('C Z'),('C Y'),('C Z'),('B X'),('A Z'),('C Y'),('C Y'),('B Z'),('B X'),('B Y'),('B X'),('A Z'),('C Y'),('B Y'),('C Z'),('A Y'),('B Z'),('C Y'),('B X'),('B X'),('B Y'),('B Y'),('B Z'),('B X'),('C Z'),('C Y'),('B X'),('B X'),('B X'),('B Y'),('B X'),('B X'),('B Y'),('B Y'),('B Y'),('C Y'),('A Z'),('C Z'),('C Y'),('B Y'),('B Y'),('B Z'),('C Z'),('C Y'),('C X'),('B Z'),('A X'),('C Y'),('B X'),('B Y'),('C Y'),('A X'),('C Y'),('C Y'),('B Y'),('B Y'),('B Y'),('A Z'),('C Y'),('C Y'),('A X'),('C Y'),('A Z'),('C Z'),('B X'),('A Y'),('C Z'),('B Z'),('B Y'),('B Y'),('C Y'),('B Y'),('C Z'),('B X'),('C Z'),('B X'),('A Y'),('C Z'),('C Y'),('B X'),('B Z'),('B Y'),('B X'),('C Y'),('C Z'),('C Z'),('A Z'),('B Z'),('B Z'),('C Z'),('C Y'),('C Z'),('C Y'),('B Z'),('B Y'),('B Y'),('C Y'),('C Z'),('C Y'),('C Y'),('C Z'),('A Y'),('B Y'),('A Z'),('B Z'),('C Z'),('B X'),('A Y'),('B Y'),('C Y'),('C Z'),('A Y'),('C Y'),('B Y'),('B X'),('C Y'),('B Y'),('C Y'),('A Y'),('C Y'),('B Y'),('B Z'),('C Z'),('B X'),('B X'),('C Z'),('C Y'),('C Z'),('B Y'),('C Y'),('B Y'),('B Y'),('C Z'),('C Y'),('A Z'),('B Z'),('B X'),('C Z'),('C X'),('C Z'),('B X'),('C Z'),('C Y'),('B X'),('B Y'),('B Y'),('C Z'),('C Z'),('C Z'),('B Y'),('B Y'),('A X'),('B X'),('C Z'),('C Y'),('C Z'),('B Y'),('C Y'),('B Y'),('C Y'),('C Z'),('C Z'),('C Y'),('C Y'),('B X'),('B Y'),('B Y'),('C Y'),('B Y'),('A Y'),('B Y'),('B Z'),('C Z'),('C Z'),('A Z'),('C Z'),('B Z'),('B Y'),('C Z'),('B Y'),('B X'),('B Y'),('A Y'),('A Y'),('B Y'),('C Y'),('B Z'),('B Y'),('B Y'),('B Y'),('B X'),('B X'),('B X'),('B Z'),('B Z'),('C Z'),('A X'),('C Z'),('B Y'),('C Z'),('A Y'),('C Z'),('C Y'),('C Y'),('A Y'),('B Z'),('B Y'),('C Z'),('B Y'),('B X'),('B Z'),('C Z'),('C Z'),('C Y'),('B X'),('B X'),('C Y'),('C Y'),('A Y'),('C Y'),('B Y'),('C Y'),('C Y'),('C Y'),('B X'),('C Z'),('B Y'),('C Z'),('B Y'),('B Y'),('A Y'),('B Y'),('C X'),('B Y'),('C Y'),('B Y'),('C Z'),('C Y'),('B X'),('B Y'),('C Y'),('B Y'),('B Z'),('B X'),('C Z'),('A X'),('C Y'),('C Y'),('B X'),('B Z'),('B X'),('C Y'),('C Y'),('A Y'),('B Y'),('C Y'),('C Z'),('B Y'),('B Y'),('B Z'),('A Y'),('B Z'),('B X'),('B Z'),('C Y'),('B Y'),('C Y'),('C Y'),('B X'),('B Y'),('A Y'),('C Y'),('C Z'),('C Y'),('B X'),('B X'),('C Y'),('B Y'),('A Z'),('C X'),('C Z'),('B Y'),('C Z'),('C Y'),('C Z'),('C Y'),('A Z'),('B Y'),('C Y'),('B Z'),('B Y'),('B X'),('B Y'),('B X'),('C Z'),('C Y'),('B Y'),('C Y'),('C Z'),('C Z'),('B Y'),('B X'),('C Y'),('C Y'),('B Y'),('B X'),('C Z'),('B X'),('C Z'),('C Y'),('B Y'),('C Y'),('C Z'),('C Y'),('B Y'),('C Z'),('A Z'),('A Y'),('C Y'),('A Y'),('C Y'),('B Y'),('B Y'),('B Y'),('C Y'),('C Z'),('C Y'),('C Y'),('B X'),('B X'),('C Y'),('B X'),('C Y'),('A Y'),('B Y'),('B Y'),('C Z'),('C Z'),('B X'),('C Z'),('C Z'),('B Y'),('C Z'),('C Z'),('B Z'),('B Z'),('C Y'),('A Z'),('C Z'),('C Z'),('B X'),('C Z'),('B Z'),('B Y'),('A Y'),('B X'),('B Z'),('A Y'),('B Y'),('B Y'),('B X'),('B Y'),('C Y'),('A Z'),('B Y'),('C Y'),('A Y'),('C Y'),('B Y'),('C Y'),('C Y'),('A Y'),('C Y'),('B Y'),('B Y'),('B Z'),('C Z'),('C Z'),('C Y'),('B Y'),('C Y'),('B Z'),('B X'),('C Y'),('C Y'),('B Y'),('B Z'),('B Y'),('A Y'),('A Y'),('A Z'),('C Y'),('B Y'),('B Y'),('C Z'),('C Z'),('C Y'),('C Z'),('C Y'),('B X'),('C Z'),('C Y'),('C Y'),('A Y'),('B Z'),('C Z'),('A Y'),('B Z'),('B Y'),('B Y'),('B Y'),('B Y'),('C Y'),('C Y'),('A Y'),('C Z'),('C Z'),('A Z'),('B Y'),('B X'),('B Z'),('A Z'),('C Z'),('B X'),('B Y'),('A X'),('C Y'),('B Z'),('A Y'),('C Z'),('C Y'),('A Y'),('B X'),('C Y'),('B X'),('C Z'),('B X'),('B Y'),('B X'),('A Z'),('B Y'),('C Z'),('C Y'),('B Y'),('A Y'),('B X'),('C Y'),('B Z'),('B X'),('A Z'),('A Y'),('C Y'),('C Z'),('C Y'),('B X'),('C Y'),('C Z'),('B Y'),('A Y'),('C Y'),('C Z'),('C X'),('B Y'),('C Y'),('B X'),('B Z'),('B Y'),('C Z'),('C Z'),('C Y'),('B X'),('C Y'),('B Z'),('C Z'),('C Y'),('C Y'),('C Y'),('C Z'),('C Y'),('B Y'),('C Y'),('A Y'),('C Y'),('B X'),('B Y'),('A X'),('B Y'),('B Y'),('B Y'),('A Y'),('B X'),('B Z'),('B Z'),('C Z'),('A Z'),('C X'),('B Z'),('B Y'),('C Y'),('C Z'),('B Z'),('B Y'),('B X'),('C Y'),('C X'),('C Y'),('C Z'),('A X'),('B X'),('B Y'),('B Y'),('C Z'),('B X'),('B Z'),('B X'),('B X'),('B Y'),('C Y'),('B Y'),('B Z'),('C Y'),('C Y'),('B Z'),('B Y'),('C Y'),('C Y'),('C Z'),('C Z'),('C Z'),('B Y'),('B Z'),('C Y'),('A Z'),('C X'),('B Y'),('C Y'),('C Y'),('B Y'),('C X'),('C Y'),('B Y'),('C Y'),('B Y'),('B Y'),('C Y'),('C Z'),('C Z'),('C Z'),('C Z'),('B X'),('C Z'),('C Z'),('B Y'),('C Y'),('A Z'),('B X'),('C Z'),('B Z'),('C Y'),('C Y'),('B Y'),('B Y'),('B Z'),('C Y'),('B Z'),('C Z'),('B Y'),('C Z'),('C Z'),('B X'),('B Z'),('C Y'),('C Y'),('C Z'),('B X'),('C Z'),('B X'),('C Y'),('C Y'),('B X'),('C Z'),('C Z'),('B Y'),('C Z'),('B Y'),('B Y'),('C Y'),('C Y'),('B Y'),('C Y'),('B Y'),('A Z'),('B Y'),('B Y'),('B Z'),('C Y'),('B Z'),('B Y'),('C Y'),('B X'),('B Z'),('B Z'),('C Y'),('C Z'),('C Z'),('B Z'),('C Y'),('B Y'),('C Z'),('B X'),('B X'),('C Z'),('B X'),('C Y'),('B Y'),('C Y'),('C Z'),('C Z'),('C Y'),('C Z'),('B Z'),('C Y'),('C Z'),('C X'),('B Z'),('B Y'),('A Z'),('C Z'),('A Y'),('C Z'),('B Z'),('B X'),('C Y'),('B X'),('C Y'),('C Z'),('C Z'),('B Y'),('B Y'),('B X'),('C Y'),('C Z'),('B X'),('C Y'),('C X'),('C Y'),('C Y'),('C Z'),('C Z'),('B X'),('C Z'),('B Y'),('C Y'),('B Y'),('B Y'),('B Y'),('B Z'),('C Z'),('A Y'),('B X'),('A X'),('A Z'),('C Z'),('A Z'),('B Z'),('C X'),('B Z'),('B X'),('B Y'),('B X'),('C Y'),('C Z'),('C Y'),('B X'),('B Y'),('B X'),('B Y'),('A Y'),('C Z'),('B Y'),('C X'),('B Y'),('B Y'),('A Z'),('B Y'),('C Z'),('C Z'),('A Z'),('C Y'),('B Z'),('C Y'),('B Y'),('A Y'),('A Z'),('B Y'),('B Z'),('B X'),('B Y'),('B Y'),('C Y'),('C Z'),('A Y'),('C Z'),('A Y'),('C Z'),('C Y'),('C Y'),('B Y'),('B Z'),('C Y'),('C Z'),('B Y'),('C Y'),('C Y'),('B X'),('B Y'),('C Z'),('C Z'),('C Y'),('B Z'),('B Y'),('C Z'),('B X'),('C Z'),('B Z'),('C Y'),('C Y'),('C Y'),('C Z'),('B Y'),('C Y'),('C Y'),('B Y'),('C X'),('C Z'),('B Y'),('C Z'),('A Y'),('C Y'),('C Y'),('C Z'),('C Y'),('C Z'),('B Z'),('B Y'),('C Z'),('C Z'),('C Y'),('B X'),('B Y'),('C Z'),('B Y'),('C Z'),('C Z'),('B Y'),('C Y'),('B X'),('B Y'),('A Y'),('B X'),('C Z'),('B Y'),('C Z'),('C Y'),('C Z'),('B X'),('B Y'),('C Y'),('C Z'),('C Y'),('B Y'),('B Z'),('B X'),('B Y'),('C Z'),('C Z'),('C Z'),('B Z'),('C Y'),('C Z'),('B Z'),('C Z'),('A Y'),('C Z'),('B X'),('B Z'),('C Y'),('C Z'),('C Y'),('B Z'),('B Y'),('C Y'),('B Z'),('A Y'),('B X'),('C Y'),('C Y'),('B Y'),('B Y'),('C Y'),('C X'),('B Z'),('B X'),('C X'),('C Y'),('B Z'),('C Z'),('A Y'),('B Z'),('B Z'),('B Z'),('B X'),('B Y'),('B X'),('C Z'),('C Z'),('A Z'),('B Z'),('C Z'),('C Z'),('B X'),('A Y'),('C Y'),('B Y'),('B Y'),('B Y'),('B Y'),('B Y'),('C Z'),('C Y'),('C X'),('C Y'),('B Y'),('B Y'),('C Y'),('C Z'),('B Y'),('A X'),('A Y'),('B X'),('A X'),('C Y'),('C Z'),('C Z'),('B Y'),('B Z'),('A Y'),('A Y'),('C Y'),('B Z'),('C Z'),('C Y'),('B Y'),('C Y'),('B X'),('B X'),('B X'),('C Z'),('B Y'),('C Y'),('B Z'),('C Z'),('A X'),('A Y'),('C Y'),('B Y'),('B Y'),('A Z'),('B X'),('C Z'),('C Z'),('B X'),('C Z'),('C Z'),('C Z'),('C Y'),('C Z'),('B X'),('B X'),('C Y'),('B Z'),('A Y'),('C Z'),('B Y'),('C Z'),('C Y'),('A Y'),('C Z'),('A Z'),('C Z'),('B Z'),('A Y'),('A Y'),('C Z'),('B Y'),('C Y'),('C Z'),('C Z'),('B Y'),('C Z'),('C Z'),('C Z'),('B Z'),('C Y'),('C Y'),('B Y'),('C Y'),('C Z'),('A X'),('C Z'),('C Z'),('C Y'),('C Z'),('B Y'),('C Y'),('B Y'),('A Y'),('C Y'),('A Y'),('B Y'),('B Y'),('C Z'),('C Z'),('C Z'),('B X'),('B Y'),('B Y'),('C Y'),('C Z'),('C Y'),('B X'),('B Y'),('C Y'),('C Z'),('C Z'),('C Z'),('A Y'),('C Y'),('C Z'),('B X'),('C Y'),('C Z'),('A Y'),('B Y'),('C Y'),('C Y'),('A X'),('C Z'),('B Z'),('B X'),('C Z'),('C Y'),('B Y'),('B Y'),('C Y'),('A Y'),('B Y'),('B Y'),('C Y'),('B X'),('C Z'),('C Z'),('C Y'),('C Y'),('B Y'),('C Z'),('C Y'),('C Z'),('C Z'),('C Z'),('B Y'),('C Z'),('B Y'),('B Y'),('B Y'),('B X'),('A Y'),('C Y'),('C Y'),('B X'),('B X'),('C Z'),('B X'),('C Z'),('B X'),('B Y'),('C Z'),('B X'),('B Y'),('C Z'),('B X'),('B Y'),('C Y'),('B Y'),('B Y'),('C X'),('B Y'),('B Y'),('B X'),('C Y'),('C Y'),('A Z'),('B Y'),('C Y'),('B Z'),('B X'),('B X'),('A Y'),('A Y'),('B Z'),('B X'),('B X'),('C Y'),('C Y'),('C Y'),('B Y'),('C Y'),('B Y'),('A Y')),

VALS as (
    select split_part(column1, ' ', 1) as el,
           split_part(column1, ' ', 2) as me
      FROM input
),
scoring AS (
    SELECT el,
           me,
           CASE el
                WHEN 'A' THEN 1
                WHEN 'B' THEN 2
                WHEN 'C' THEN 3
            END as el0,
            CASE me
                WHEN 'X' THEN 1
                WHEN 'Y' THEN 2
                WHEN 'Z' THEN 3
            END as me1
      FROM VALS
),
playing AS (
    SELECT el,
           me,
           CASE 
                WHEN el0=me1 THEN 3+me1
                WHEN (el0=1 AND me1=2) THEN 6+me1
                WHEN (el0=2 AND me1=3) THEN 6+me1
                WHEN (el0=3 AND me1=1) THEN 6+me1
                ELSE me1
            END as s1
        FROM scoring
)
SELECT sum(s1) FROM playing

