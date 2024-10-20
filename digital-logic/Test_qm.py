import unittest
from Quine_McCluskey import quine_mccluskey

class TestQuineMcCluskey(unittest.TestCase):

    def test_valid_input(self):
        """
            Revisa cuando la entrada es vacia.
        """
        terminos = []
        result = quine_mccluskey(terminos)
        self.assertIsInstance(result, set)

    # Ejercicio recuperado de
    # https://drive.google.com/file/d/1BdCwuwFcSar5W5nPxA98FVNfTxZfd6yg/view
    def test_galaviz(self):
        terminos = [0,2,3,5,6,7]
        result = quine_mccluskey(terminos)
        self.assertEqual(result, {'1-1', '-1-', '0-0'})

    # Ejercicio hecho en clase
    def test_ximena(self):
        terminos = [1,5,6,7,10,11,12,13,15]
        result = quine_mccluskey(terminos)
        self.assertEqual(result, {'0-01','011-','101-','110-','-1-1'})
    
    # Ejercicio recuperado de
    # https://youtu.be/DTOzK88Inkk?si=Loh5M-eti8gQP8Hc
    def test_felipe(self):
        terminos = [1,3,4,5,9,11,12,13,14,15]
        result = quine_mccluskey(terminos)
        self.assertEqual(result, {'-0-1','-10-','11--'})

    # Ejercicio recuperado de
    # https://compilandoconocimiento.com/2017/06/13/reduccion-quine-mccluskey/
    def test_patricio(self):
        terminos = [1,3,4,5,7,9,10,11,15]
        result = quine_mccluskey(terminos)
        self.assertEqual(result, {'--11','-0-1','101-','010-'})

if __name__ == '__main__':
    unittest.main()