import unittest

from app.logger import StructuredLogMessage as sm

class TestStructuredLogMessage(unittest.TestCase):

    def test_simple_message(self):
        simple_message = 'test message'
        
        test_object = sm(simple_message)

        self.assertIsNotNone(test_object)
        self.assertEqual(str(test_object), simple_message)

    def test_structured_message(self):
        simple_message = 'test message'
        
        test_object = sm(simple_message, event="publish", type="ticker")

        self.assertIsNotNone(test_object)
        self.assertEqual(str(test_object), 'test message | {"event": "publish", "type": "ticker"}')

