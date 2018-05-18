import Lista3

sumatoria :: Lista Int -> Int
sumatoria xs = 
	if isEmptyL xs
		then 0
		else headL xs + sumatoria (tailL xs)

append :: Ord a => Lista a -> Lista a -> Lista a
append xs ys = 
	if isEmptyL xs
		then ys
		else consL (headL xs) (append (tailL xs) ys)