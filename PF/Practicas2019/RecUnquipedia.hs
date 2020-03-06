data Component = Cargo | Engine | Shield | Cannon deriving (Eq, Show)
data Spaceship = Module Component Spaceship Spaceship | Plug deriving (Eq, Show)

data Direction = Larboard | Starboard deriving (Eq, Show)
data Size = Small | Big | Torpedo
type Hazard = (Direction, Int, Size)

shielded :: Spaceship -> Bool
shielded Plug             = False
shielded (Module c s1 s2) = c == Shield || shielded s1 || shielded s2

armed :: Spaceship -> Bool
armed Plug                = False
armed (Module c s1 s2) = c == Cannon || shielded s1 || shielded s2

thrust :: Spaceship -> Int
thrust Plug             = 0
thrust (Module c s1 s2) = if c == Engine then 1 + thrust s1 + thrust s2
                                         else thrust s1 + thrust s2

wreck :: Hazard -> Spaceship -> Spaceship
wreck h (Module c s1 s2) = if getFst(h) == Larboard then Module c (wrecursive h s1 0) s2
                                                    else Module c s1 (wrecursive h s2 0)

wrecursive :: Hazard -> Spaceship -> Int -> Spaceship
wrecursive h Plug n             = Plug
wrecursive h (Module c s1 s2) n = if getSnd(h) == n then Plug
                                                    else Module c (wrecursive h s1 (n+1)) (wrecursive h s1 (n+1))
getFst (x , _ , _) = x
getSnd (_ , x , _) = x
getTrd (_ , _ , x) = x

foldSS :: (Component -> b -> b -> b) -> b -> Spaceship -> b
foldSS f z Plug              = z
foldSS f z (Module c s1 s2) = f c (foldSS f z s1) (foldSS f z s2)

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' f y []	 = y
foldr' f y (x:xs) = f x (foldr f y xs)

capacity :: Spaceship -> Int
capacity s = foldSS (sumaSi) 0 s

sumaSi :: Component -> Int -> Int -> Int
sumaSi c s1 s2 = if c == Cargo then 1 + s1 + s2
                               else s1 + s2

largest :: [Spaceship] -> Spaceship
largest xs = foldr' laMasGrande Plug xs

laMasGrande :: (Spaceship -> Spaceship -> Spaceship)
laMasGrande s1 s2 = if capacity s1 > capacity s2 then s1
                                                 else s2

dimensions :: Spaceship -> (Int, Int)
dimensions sp = (foldSS largo 0 sp, foldSS ancho 1 sp)

largo :: Component -> Int -> Int -> Int 
largo c n1 n2 = 1 + max n1 n2

ancho :: Component -> Int -> Int -> Int
ancho c n1 n2 = n1 + n2

components :: Spaceship -> [Component]
components Plug             = []
components (Module c s1 s2) = components s1 ++ [c] ++ components s2

replace :: (Component -> Component) -> Spaceship -> Spaceship
replace f Plug = Plug
replace f (Module c s1 s2) = Module (f c) (replace f s1) (replace f s2)

--SUPER ARBOL Module Cargo (Module Cargo (Module Cargo (Plug) (Module Cargo Plug Plug)) (Module Cargo (Plug) (Module Cargo (Plug) (Module Cargo (Module Cargo (Plug) (Module Cargo Plug Plug)) (Plug))))) (Module Cargo (Module Cargo (Plug) (Plug)) (Module Cargo (Plug) (Plug))))
{--
components (replace f sp) = map f (components sp)
DEM: Por induccion en la estructura de Spaceship
CASO BASE : Plug

components (replace f Plug) = map f (components Plug)
= def replace 1                 def components 1
components Plug             = map f []
= def components 1              def map 1
[]                          = []

CASO INDUCTIVO : ps = (Module c s1 s2)
HI1) components (replace f s1) = map f (components s1)
HI2) components (replace f s2) = map f (components s2)
TI) components (replace f (Module c s1 s2)) = map f (components (Module c s1 s2))




--}