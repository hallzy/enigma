module Rotors.WWII where

import qualified Data.Map as Map
import Data.Tuple

reverseMap :: Map.Map Char Char -> Map.Map Char Char
reverseMap = Map.fromList . map swap . Map.toList

-- The Wehrmacht and Luftwaffe Used Rotors I, II, III, IV, and V. They used
-- Reflectors B and C

-- The Kriegsmarine M3 used Rotors I, II, III, IV, V, VI, VII, and VIII. They
-- used Reflectors B and C

-- The Kriegsmarine M4 used Rotors I, II, III, IV, V, VI, VII, VIII, Beta and
-- Gamma. They used Reflectors B-thin and C-thin. They used thin reflectors
-- because they used 4 rotors.

-- Rotors Beta and Gamma were only used as the 4th rotor in 4 rotor machines,
-- which means that they do not have turnover notches. This is not something
-- that I plan to enforce, but if they are inserted in the very left position
-- they won't trigger any turnovers in rotors to the left of them

-- Reflectors don't rotate, so they don't have turnover notches.

-- Returns the output of the input into a rotor, and their turnover notch
-- positions
rotor :: String -> Char -> (Char, Char, [Char])
rotor "I"     input = (rotorI     Map.! input, reverseMap rotorI     Map.! input, ['Q'])
rotor "II"    input = (rotorII    Map.! input, reverseMap rotorII    Map.! input, ['E'])
rotor "III"   input = (rotorIII   Map.! input, reverseMap rotorIII   Map.! input, ['V'])
rotor "IV"    input = (rotorIV    Map.! input, reverseMap rotorIV    Map.! input, ['J'])
rotor "V"     input = (rotorV     Map.! input, reverseMap rotorV     Map.! input, ['Z'])
rotor "VI"    input = (rotorVI    Map.! input, reverseMap rotorVI    Map.! input, ['Z', 'M'])
rotor "VII"   input = (rotorVII   Map.! input, reverseMap rotorVII   Map.! input, ['Z', 'M'])
rotor "VIII"  input = (rotorVIII  Map.! input, reverseMap rotorVIII  Map.! input, ['Z', 'M'])
rotor "BETA"  input = (rotorBeta  Map.! input, reverseMap rotorBeta  Map.! input, [])
rotor "Β"     input = rotor "BETA" input
rotor "β"     input = rotor "BETA" input
rotor "GAMMA" input = (rotorGamma Map.! input, reverseMap rotorGamma Map.! input, [])
rotor "Γ"     input = rotor "GAMMA" input
rotor "γ"     input = rotor "GAMMA" input
rotor r _           = error $ "Unknown Rotor Configured: '" ++ r ++ "'"

reflector :: String -> Char -> Char
reflector "A"     = reflectorA
reflector "B"     = reflectorB
reflector "C"     = reflectorC
reflector "BTHIN" = reflectorBThin
reflector "CTHIN" = reflectorCThin
reflector r       = error $ "Unknown Reflector Configured: '" ++ r ++ "'"

rotorI :: Map.Map Char Char
rotorI = Map.fromList [
    ('A', 'E'),
    ('B', 'K'),
    ('C', 'M'),
    ('D', 'F'),
    ('E', 'L'),
    ('F', 'G'),
    ('G', 'D'),
    ('H', 'Q'),
    ('I', 'V'),
    ('J', 'Z'),
    ('K', 'N'),
    ('L', 'T'),
    ('M', 'O'),
    ('N', 'W'),
    ('O', 'Y'),
    ('P', 'H'),
    ('Q', 'X'),
    ('R', 'U'),
    ('S', 'S'),
    ('T', 'P'),
    ('U', 'A'),
    ('V', 'I'),
    ('W', 'B'),
    ('X', 'R'),
    ('Y', 'C'),
    ('Z', 'J')
    ]

rotorII :: Map.Map Char Char
rotorII = Map.fromList [
    ('A', 'A'),
    ('B', 'J'),
    ('C', 'D'),
    ('D', 'K'),
    ('E', 'S'),
    ('F', 'I'),
    ('G', 'R'),
    ('H', 'U'),
    ('I', 'X'),
    ('J', 'B'),
    ('K', 'L'),
    ('L', 'H'),
    ('M', 'W'),
    ('N', 'T'),
    ('O', 'M'),
    ('P', 'C'),
    ('Q', 'Q'),
    ('R', 'G'),
    ('S', 'Z'),
    ('T', 'N'),
    ('U', 'P'),
    ('V', 'Y'),
    ('W', 'F'),
    ('X', 'V'),
    ('Y', 'O'),
    ('Z', 'E')
    ]

rotorIII :: Map.Map Char Char
rotorIII = Map.fromList [
    ('A', 'B'),
    ('B', 'D'),
    ('C', 'F'),
    ('D', 'H'),
    ('E', 'J'),
    ('F', 'L'),
    ('G', 'C'),
    ('H', 'P'),
    ('I', 'R'),
    ('J', 'T'),
    ('K', 'X'),
    ('L', 'V'),
    ('M', 'Z'),
    ('N', 'N'),
    ('O', 'Y'),
    ('P', 'E'),
    ('Q', 'I'),
    ('R', 'W'),
    ('S', 'G'),
    ('T', 'A'),
    ('U', 'K'),
    ('V', 'M'),
    ('W', 'U'),
    ('X', 'S'),
    ('Y', 'Q'),
    ('Z', 'O')
    ]

rotorIV :: Map.Map Char Char
rotorIV = Map.fromList [
    ('A', 'E'),
    ('B', 'S'),
    ('C', 'O'),
    ('D', 'V'),
    ('E', 'P'),
    ('F', 'Z'),
    ('G', 'J'),
    ('H', 'A'),
    ('I', 'Y'),
    ('J', 'Q'),
    ('K', 'U'),
    ('L', 'I'),
    ('M', 'R'),
    ('N', 'H'),
    ('O', 'X'),
    ('P', 'L'),
    ('Q', 'N'),
    ('R', 'F'),
    ('S', 'T'),
    ('T', 'G'),
    ('U', 'K'),
    ('V', 'D'),
    ('W', 'C'),
    ('X', 'M'),
    ('Y', 'W'),
    ('Z', 'B')
    ]

rotorV :: Map.Map Char Char
rotorV = Map.fromList [
    ('A', 'V'),
    ('B', 'Z'),
    ('C', 'B'),
    ('D', 'R'),
    ('E', 'G'),
    ('F', 'I'),
    ('G', 'T'),
    ('H', 'Y'),
    ('I', 'U'),
    ('J', 'P'),
    ('K', 'S'),
    ('L', 'D'),
    ('M', 'N'),
    ('N', 'H'),
    ('O', 'L'),
    ('P', 'X'),
    ('Q', 'A'),
    ('R', 'W'),
    ('S', 'M'),
    ('T', 'J'),
    ('U', 'Q'),
    ('V', 'O'),
    ('W', 'F'),
    ('X', 'E'),
    ('Y', 'C'),
    ('Z', 'K')
    ]

rotorVI :: Map.Map Char Char
rotorVI = Map.fromList [
    ('A', 'J'),
    ('B', 'P'),
    ('C', 'G'),
    ('D', 'V'),
    ('E', 'O'),
    ('F', 'U'),
    ('G', 'M'),
    ('H', 'F'),
    ('I', 'Y'),
    ('J', 'Q'),
    ('K', 'B'),
    ('L', 'E'),
    ('M', 'N'),
    ('N', 'H'),
    ('O', 'Z'),
    ('P', 'R'),
    ('Q', 'D'),
    ('R', 'K'),
    ('S', 'A'),
    ('T', 'S'),
    ('U', 'X'),
    ('V', 'L'),
    ('W', 'I'),
    ('X', 'C'),
    ('Y', 'T'),
    ('Z', 'W')
    ]

rotorVII :: Map.Map Char Char
rotorVII = Map.fromList [
    ('A', 'N'),
    ('B', 'Z'),
    ('C', 'J'),
    ('D', 'H'),
    ('E', 'G'),
    ('F', 'R'),
    ('G', 'C'),
    ('H', 'X'),
    ('I', 'M'),
    ('J', 'Y'),
    ('K', 'S'),
    ('L', 'W'),
    ('M', 'B'),
    ('N', 'O'),
    ('O', 'U'),
    ('P', 'F'),
    ('Q', 'A'),
    ('R', 'I'),
    ('S', 'V'),
    ('T', 'L'),
    ('U', 'P'),
    ('V', 'E'),
    ('W', 'K'),
    ('X', 'Q'),
    ('Y', 'D'),
    ('Z', 'T')
    ]

rotorVIII :: Map.Map Char Char
rotorVIII = Map.fromList [
    ('A', 'F'),
    ('B', 'K'),
    ('C', 'Q'),
    ('D', 'H'),
    ('E', 'T'),
    ('F', 'L'),
    ('G', 'X'),
    ('H', 'O'),
    ('I', 'C'),
    ('J', 'B'),
    ('K', 'J'),
    ('L', 'S'),
    ('M', 'P'),
    ('N', 'D'),
    ('O', 'Z'),
    ('P', 'R'),
    ('Q', 'A'),
    ('R', 'M'),
    ('S', 'E'),
    ('T', 'W'),
    ('U', 'N'),
    ('V', 'I'),
    ('W', 'U'),
    ('X', 'Y'),
    ('Y', 'G'),
    ('Z', 'V')
    ]

rotorBeta :: Map.Map Char Char
rotorBeta = Map.fromList [
    ('A', 'L'),
    ('B', 'E'),
    ('C', 'Y'),
    ('D', 'J'),
    ('E', 'V'),
    ('F', 'C'),
    ('G', 'N'),
    ('H', 'I'),
    ('I', 'X'),
    ('J', 'W'),
    ('K', 'P'),
    ('L', 'B'),
    ('M', 'Q'),
    ('N', 'M'),
    ('O', 'D'),
    ('P', 'R'),
    ('Q', 'T'),
    ('R', 'A'),
    ('S', 'K'),
    ('T', 'Z'),
    ('U', 'G'),
    ('V', 'F'),
    ('W', 'U'),
    ('X', 'H'),
    ('Y', 'O'),
    ('Z', 'S')
    ]

rotorGamma :: Map.Map Char Char
rotorGamma = Map.fromList [
    ('A', 'F'),
    ('B', 'S'),
    ('C', 'O'),
    ('D', 'K'),
    ('E', 'A'),
    ('F', 'N'),
    ('G', 'U'),
    ('H', 'E'),
    ('I', 'R'),
    ('J', 'H'),
    ('K', 'M'),
    ('L', 'B'),
    ('M', 'T'),
    ('N', 'I'),
    ('O', 'Y'),
    ('P', 'C'),
    ('Q', 'W'),
    ('R', 'L'),
    ('S', 'Q'),
    ('T', 'P'),
    ('U', 'Z'),
    ('V', 'X'),
    ('W', 'V'),
    ('X', 'G'),
    ('Y', 'J'),
    ('Z', 'D')
    ]

reflectorA :: Char -> Char
reflectorA 'A' = 'E'
reflectorA 'B' = 'J'
reflectorA 'C' = 'M'
reflectorA 'D' = 'Z'
reflectorA 'E' = 'A'
reflectorA 'F' = 'L'
reflectorA 'G' = 'Y'
reflectorA 'H' = 'X'
reflectorA 'I' = 'V'
reflectorA 'J' = 'B'
reflectorA 'K' = 'W'
reflectorA 'L' = 'F'
reflectorA 'M' = 'C'
reflectorA 'N' = 'R'
reflectorA 'O' = 'Q'
reflectorA 'P' = 'U'
reflectorA 'Q' = 'O'
reflectorA 'R' = 'N'
reflectorA 'S' = 'T'
reflectorA 'T' = 'S'
reflectorA 'U' = 'P'
reflectorA 'V' = 'I'
reflectorA 'W' = 'K'
reflectorA 'X' = 'H'
reflectorA 'Y' = 'G'
reflectorA 'Z' = 'D'

reflectorB :: Char -> Char
reflectorB 'A' = 'Y'
reflectorB 'B' = 'R'
reflectorB 'C' = 'U'
reflectorB 'D' = 'H'
reflectorB 'E' = 'Q'
reflectorB 'F' = 'S'
reflectorB 'G' = 'L'
reflectorB 'H' = 'D'
reflectorB 'I' = 'P'
reflectorB 'J' = 'X'
reflectorB 'K' = 'N'
reflectorB 'L' = 'G'
reflectorB 'M' = 'O'
reflectorB 'N' = 'K'
reflectorB 'O' = 'M'
reflectorB 'P' = 'I'
reflectorB 'Q' = 'E'
reflectorB 'R' = 'B'
reflectorB 'S' = 'F'
reflectorB 'T' = 'Z'
reflectorB 'U' = 'C'
reflectorB 'V' = 'W'
reflectorB 'W' = 'V'
reflectorB 'X' = 'J'
reflectorB 'Y' = 'A'
reflectorB 'Z' = 'T'

reflectorC :: Char -> Char
reflectorC 'A' = 'F'
reflectorC 'B' = 'V'
reflectorC 'C' = 'P'
reflectorC 'D' = 'J'
reflectorC 'E' = 'I'
reflectorC 'F' = 'A'
reflectorC 'G' = 'O'
reflectorC 'H' = 'Y'
reflectorC 'I' = 'E'
reflectorC 'J' = 'D'
reflectorC 'K' = 'R'
reflectorC 'L' = 'Z'
reflectorC 'M' = 'X'
reflectorC 'N' = 'W'
reflectorC 'O' = 'G'
reflectorC 'P' = 'C'
reflectorC 'Q' = 'T'
reflectorC 'R' = 'K'
reflectorC 'S' = 'U'
reflectorC 'T' = 'Q'
reflectorC 'U' = 'S'
reflectorC 'V' = 'B'
reflectorC 'W' = 'N'
reflectorC 'X' = 'M'
reflectorC 'Y' = 'H'
reflectorC 'Z' = 'L'

reflectorBThin :: Char -> Char
reflectorBThin 'A' = 'E'
reflectorBThin 'B' = 'N'
reflectorBThin 'C' = 'K'
reflectorBThin 'D' = 'Q'
reflectorBThin 'E' = 'A'
reflectorBThin 'F' = 'U'
reflectorBThin 'G' = 'Y'
reflectorBThin 'H' = 'W'
reflectorBThin 'I' = 'J'
reflectorBThin 'J' = 'I'
reflectorBThin 'K' = 'C'
reflectorBThin 'L' = 'O'
reflectorBThin 'M' = 'P'
reflectorBThin 'N' = 'B'
reflectorBThin 'O' = 'L'
reflectorBThin 'P' = 'M'
reflectorBThin 'Q' = 'D'
reflectorBThin 'R' = 'X'
reflectorBThin 'S' = 'Z'
reflectorBThin 'T' = 'V'
reflectorBThin 'U' = 'F'
reflectorBThin 'V' = 'T'
reflectorBThin 'W' = 'H'
reflectorBThin 'X' = 'R'
reflectorBThin 'Y' = 'G'
reflectorBThin 'Z' = 'S'

reflectorCThin :: Char -> Char
reflectorCThin 'A' = 'R'
reflectorCThin 'B' = 'D'
reflectorCThin 'C' = 'O'
reflectorCThin 'D' = 'B'
reflectorCThin 'E' = 'J'
reflectorCThin 'F' = 'N'
reflectorCThin 'G' = 'T'
reflectorCThin 'H' = 'K'
reflectorCThin 'I' = 'V'
reflectorCThin 'J' = 'E'
reflectorCThin 'K' = 'H'
reflectorCThin 'L' = 'M'
reflectorCThin 'M' = 'L'
reflectorCThin 'N' = 'F'
reflectorCThin 'O' = 'C'
reflectorCThin 'P' = 'W'
reflectorCThin 'Q' = 'Z'
reflectorCThin 'R' = 'A'
reflectorCThin 'S' = 'X'
reflectorCThin 'T' = 'G'
reflectorCThin 'U' = 'Y'
reflectorCThin 'V' = 'I'
reflectorCThin 'W' = 'P'
reflectorCThin 'X' = 'S'
reflectorCThin 'Y' = 'U'
reflectorCThin 'Z' = 'Q'
