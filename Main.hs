import System.Environment
import Data.Char
import Data.List
import qualified Data.Map as Map
import qualified Rotors.WWII as WWII
import Text.Read

type PlugBoard = Map.Map Char Char

char2offset :: Char -> Int
char2offset c = ((ord c)) - (ord 'A')

offset2char :: Int -> Char
offset2char offset = chr ((offset `mod` 26) + (ord 'A'))

offsetChar :: Int -> Char -> Char
offsetChar offset char = offset2char $ (char2offset char) + offset

doRotors :: [Int] -> [String] -> Char -> Char
doRotors (offset1:offset2:offsets) (rotor:rotors) input = doRotors (offset2:offsets) rotors forward
    where
        (forward, backward, notch) = WWII.rotor rotor (offset2char ((char2offset input) - offset1 + offset2))
doRotors _ _ input = input

doRotorsBackward :: [Int] -> [String] -> Char -> Char
doRotorsBackward (offset1:offset2:offsets) (rotor:rotors) input = doRotorsBackward (offset2:offsets) rotors backward
    where
        (forward, backward, notch) = WWII.rotor rotor (offset2char ((char2offset input) - offset1 + offset2))
doRotorsBackward (offset:[]) _ input = offset2char ((char2offset input) - offset)

doReflection :: Int -> String -> Char -> Char
doReflection offset reflector input = WWII.reflector reflector (offset2char ((char2offset input) - offset))

doPlugBoard :: PlugBoard -> Char -> Char
doPlugBoard plugBoard c
    | Map.notMember c plugBoard = c
    | otherwise = plugBoard Map.! c

getNewRotorPositions :: [Int] -> [String] -> [Int]
getNewRotorPositions positions rotors = map (flip mod 26 . fst) $ reverse $ foldl' doFold [] positions
    where
        doFold acc pos
            | acc == [] = (pos + 1, True) : acc
            | hitNotch  = (pos + 1, True) : (if (snd $ head acc) == False then ((fst $ head acc) + 1, True) else head acc) : (drop 1 acc)
            | otherwise = (pos, False) : acc
            where
                previousRotorOffset = positions !! ((length acc) - 1)
                (_, _, previousRotorNotches) = WWII.rotor (rotors !! ((length acc) - 1)) 'A'
                notchOffsets = map char2offset previousRotorNotches
                hitNotch = previousRotorOffset `elem` notchOffsets

-- Add a space after every 4 letters, since that is how the output of engima was
-- formatted
addSpaces :: String -> String
addSpaces xs@(_:_:_:_:[]) = xs
addSpaces (a:b:c:d:xs) = a : b : c : d : ' ' : addSpaces xs
addSpaces xs = xs

createPlugBoardMap :: [String] -> PlugBoard
createPlugBoardMap input = Map.fromList $ foldl' (\acc (c1:c2:[]) -> (c1, c2) : (c2, c1) : acc) [] input

enigma :: [String] -> String -> [Int] -> PlugBoard -> [Int] -> String -> String
enigma _ _ _ _ _ [] = []
enigma rotors reflector ringSettings plugBoard startPos (c:cs) = doKeyPress : enigma rotors reflector ringSettings plugBoard newPos cs
    where
        -- The additional 0's are for the reflector and the input into the
        -- rotors. They never have an offset (hence the 0) but including makes
        -- the recursive calls easier
        offsets = 0 : (zipWith (\x y -> (x - y) `mod` 26) newPos ringSettings)
        reversedOffsets = 0 : (zipWith (\x y -> (x - y) `mod` 26) (reverse newPos) (reverse ringSettings))

        newPos = getNewRotorPositions startPos rotors

        doKeyPress = doPlugBoard plugBoard $ doRotorsBackward reversedOffsets (reverse rotors) $ doReflection (last offsets) reflector $ doRotors offsets rotors $ doPlugBoard plugBoard c

prepInput :: [String] -> String
prepInput = filter (flip elem ['A'..'Z']) . map (\c -> if c == '.' then 'X' else c) . map toUpper . unwords

validatePlugBoard :: [String] -> [String]
validatePlugBoard [] = []
validatePlugBoard plugs
    | hasDuplicates = error "Plugs have duplicated letters"
    | hasNonPairs = error "Each group of plugs must be a pair"
    | hasNonLetters = error "Each group of plugs must be letters only"
    | otherwise = plugs
    where
        groupedLetters = group $ sort $ filter (/= ' ') $ unwords plugs
        hasDuplicates = 0 < (length $ filter (> 1) $ map length groupedLetters)
        hasNonLetters = 0 < (length $ filter (flip notElem ['A'..'Z'] . head) groupedLetters)

        hasNonPairs = 0 < (length $ filter ((/= 2) . length) plugs)

str2upper :: String -> String
str2upper str = map toUpper str

list2upper :: [String] -> [String]
list2upper list = map str2upper list

areLetters :: [Char] -> Maybe [Char]
areLetters list
    | 0 < (length $ filter (flip notElem ['A'..'Z']) list) = Nothing
    | otherwise = Just list

isNumeric :: String -> Bool
isNumeric str = res /= Nothing
    where
        res = readMaybe str :: Maybe Int

parseRingSettings :: [String] -> ([Int], [String])
parseRingSettings settings = foldl' folder ([], []) settings
    where
        folder (intSide, strSide) str
            | isNumeric str = (intVal                       : intSide, [(offset2char (intVal - 1))] : strSide)
            | otherwise     = ((succ $ char2offset charVal) : intSide, [charVal] : strSide)
            where
                charVal = head str
                intVal = (read str) :: Int

main :: IO ()
main = do
    fileContent <- readFile "configuration.txt"
    let config = map words $ lines fileContent

    let rotors           = list2upper $ reverse $ drop 1 $ head config
    let reflector        = str2upper $ head $ drop 1 $ head $ drop 1 config
    let ringSettings     = parseRingSettings $ list2upper $ drop 2 $ head $ drop 2 config
    let plugBoard        = validatePlugBoard $ list2upper $ drop 2 $ head $ drop 3 config
    let startingPosition = parseRingSettings $ list2upper $ drop 2 $ head $ drop 4 config

    let plugBoardMap = createPlugBoardMap plugBoard

    input <- getArgs

    putStrLn $ "Reflector:     " ++ (show reflector)
    putStrLn $ "Rotors:        " ++ (show $ reverse rotors)
    putStrLn $ "Ring Settings: " ++ (show $ reverse $ fst ringSettings)     ++ " aka " ++ (show $ reverse $ snd ringSettings)
    putStrLn $ "Start Pos:     " ++ (show $ reverse $ fst startingPosition) ++ " aka " ++ (show $ reverse $ snd startingPosition)
    putStrLn $ "Plug Board:    " ++ (show plugBoard)
    putStrLn $ ""

    let ringSettingsAsOffsets = map pred $ fst ringSettings
    let startPosAsOffsets = map pred $ fst startingPosition

    putStrLn $ "Input:  " ++ (addSpaces $ prepInput input)
    putStrLn $ "Output: " ++ (addSpaces $ enigma rotors reflector ringSettingsAsOffsets plugBoardMap startPosAsOffsets $ prepInput input)
