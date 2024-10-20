-- Método de Quine–McCluskey
module QuineMcCluskey where

import qualified Data.Map as M

import Data.Maybe (fromMaybe)

-- Un tipo de dato para represantar bits
data Bit = Cero | Uno | Guion deriving Eq

instance Show Bit where
  show Cero = "0"
  show Uno = "1"
  show Guion = "-"

-- Un tipo de dato para representar los terminos
type Termino = [Bit]
-- Un tipo de dato para representar los minterminos
type Minterminos = [Termino]

cero = [Cero, Cero, Cero]
uno = [Cero, Cero, Uno]
dos = [Cero, Uno, Cero]
tres = [Cero, Uno, Uno]
cuatro = [Uno, Cero, Cero]
cinco = [Uno, Cero, Uno]
seis = [Uno, Uno, Cero]
siete = [Uno, Uno, Uno]

ejemplo = [cero, dos, tres, cinco, seis, siete]
ejemploExtremo = [cero, siete]
-- prueba : empatarGruposConsecutivos $ creaDiccionario ejemplo 

-- Calcula el número de unos en un termino
pesoHamming :: Termino -> Int
pesoHamming = length . filter (==Uno)

-- Crea un diccionario a partir de una lista de terminos
-- La llave del diccionario es el numero de unos en el termino
-- El valor del diccionario es una lista de tuplas con el termino y si ya se uso o no
creaDiccionario :: Minterminos -> M.Map Int Minterminos
--creaDiccionario = foldr (\t acc -> M.insertWith (++) (pesoHamming t) [t] acc) M.empty
creaDiccionario = foldr (\t acc -> M.insertWith (++) (pesoHamming t) [t] acc) M.empty

-- Combina dos bits
combinaBits :: Bit -> Bit -> Maybe Bit
combinaBits b1 b2 = if b1 == b2 then Just b1 else Nothing

-- Combina dos terminos
combinaTerminos :: Termino -> Termino -> Maybe Termino
combinaTerminos t1 t2 =
    let combinacion = zipWith combinaBits t1 t2
        numeroDeDiferencias = length . filter (==Nothing) $ combinacion
    in if numeroDeDiferencias == 1
        then Just $ map (fromMaybe Guion) combinacion
        else Nothing


empataGruposConsecutivos :: M.Map Int Minterminos -> M.Map Int Minterminos
empataGruposConsecutivos grupos = M.fromListWith (++) combinaciones
  where
    combinaciones = do
      (k1, v1) <- M.toList grupos
      (k2, v2) <- M.toList grupos
      ([(k1, [t | t1 <- v1, t2 <- v2, Just t <- [combinaTerminos t1 t2]]) | k2 == k1 + 1])
