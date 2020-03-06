data PredExp a = Pred (a -> Bool) | LOp LogicOp (PredExp a) (PredExp a) | NOT (PredExp a)

data LogicOp = AND | OR

data SetExp a = Empty | Unit a | Union (SetExp a) (SetExp a)

evalPE :: PredExp a -> (a -> Bool)
evalPE (Pred pe)        = pe 
evalPE (NOT pe)         = not . evalPE pe
evalPE (LOp l1 pe1 pe2) = case of x -> AND = (optof AND)(evalPE pe1) (evalPE pe2)
                                       OR = (optof OR) (evalPE pe1) (evalPE pe2)

optof :: LogicOp -> (Bool -> Bool -> Bool)
optof AND = (&&)
optof OR = (||)

sExp2pExp :: SetExp a -> Pred
sExp2pExp Empty = Pred (\x -> False) 
sExp2pExp (Unit x) = Prod (x==)
sExp2pExp (Union s1 s2) = LOp OR (sExp2pExp s1) (sExp2pExp s2)

evalSE  ::  SetExp a -> (a -> Bool)
evalSE Empty = (\x -> false)
evalSE (Unit x) = (x==)
evalSE (Unit s1 s2) = liftB2 (||) (evalSE s1) (evalSE s2)

mapPE :: (a -> b) -> PredPE b -> PredPE a
mapPE f (Pred p) = Pred (p . f)
mapPE f (Not pe) = NOT (mapPE f pe)
mapPE f (LOp op pe1 pe2) = LOp op (mapPE f pe1) (mapPE f pe2)

foldPE :: ((a -> Bool) -> b) -> (b -> b) -> (LogicOp -> b -> b -> b) -> PredExp a -> b
foldPE f g h (Pred p) = f p
foldPE f g h (NOT pe) = g (foldPE f g h pe)
foldPE f g h (LOp l1 pe1 pe2) = h l1 (foldPE f g h pe1) (foldPE f g h pe2)

foldSE :: b -> (a -> b) -> (b -> b -> b) -> SetExp a -> b
foldSE e fu ff Empty = 
foldSE e fu ff (Unit x) = 
foldSE e fu ff (Union s1 s2) =

{-
DEMOSTRACION
PRINCIPIO DE EXTENSIONALIDAD Y SACO EL (.)
    
    mapPE f (sExp2pExp s)
    
    sExp2pExp (mapSE(inversa f) s)
1)CASO BASE: s = Empty
    mapPE f (sExp2pExp Empty)
=def se2pe
    mapPE f (Pred (const false))
    Pred((const false) . f)

    sExp2pExp(mapSE(inversa f) Empty)
=def mapSE
    sExp2pExp Empty
=def se2pe
    Pred(const false)

2) CASO BASE: s = Unit x

    mapPE f (sExp2pExp s)
=def se2pe
    mapPE f (Pred(x==))
=def mapPE
    Pred((x==) . f)

    sExp2pExp (mapSE (inversa f) (Unit x))
=def mapSE
    sExp2pExp(Unit (inversa f x))
=
    Pred (inversa f x ==)
= por conmutatividad ==
    Pred((==) inversa f x)


3) CASO INDUCTIVO: s = Union s1 s2
HI1) ¡ mapPe f (sExp2pExp s1) = sExp2pExp(mapSE (inversa f) s1) !
HI2) ¡ mapPe f (sExp2pExp s2) = sExp2pExp(mapSE (inversa f) s2) !
TI) ¿mapPe f (sExp2pExp(Union s1 s2)) = sExp2pExp(mapSE (inversa f) (Union s1 s2)) ?

    mapPE f (sExp2pExp(Union s1 s2))
def se2pe
    mapPE f (LOp OR (sExp2pExp s1) (sExp2pExp s2))
= def mapPE
    LOp OR (mapPE f (sExp2pExp s1)) (mapPE f (sExp2pExp s2))
HI 1 y 2)
    LOp OR (sExp2pExp (mapSE (inversa f) s1)) (sExp2pExp(mapSE(inversa f) s2))
    -}