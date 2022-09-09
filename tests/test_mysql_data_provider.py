import logging
import unittest
from unittest.mock import patch

from app.data_providers import MySqlDataProvider

class TestMySqlDataProvider(unittest.TestCase):

    def setUp(self):
        self.database_settings = {
            'HOST': 'some HOST',
            'PORT': 'some PORT',
            'USERNAME': 'some USERNAME',
            'PASSWORD': 'some PASSWORD',
            'DATABASE': 'some DATABASE',
        }

    def test_init(self):
        provider = MySqlDataProvider(self.database_settings)
        self.assertIsNotNone(provider)