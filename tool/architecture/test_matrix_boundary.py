import tempfile
import unittest
from pathlib import Path
from check_matrix_boundary import imports

class BoundaryTest(unittest.TestCase):
    def test_detects_sdk_reexport_and_import_but_allows_domain_types(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            path = root / 'lib/src/domain'
            path.mkdir(parents=True)
            (path / 'ok.dart').write_text("import '../entities/message.dart';")
            (path / 'bad.dart').write_text("export 'package:matrix/matrix.dart';")
            self.assertEqual(imports(root), ['lib/src/domain/bad.dart'])

if __name__ == '__main__':
    unittest.main()
