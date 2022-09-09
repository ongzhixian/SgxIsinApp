import logging
import unittest
from unittest.mock import patch

from app.logger import StructuredLogMessage as sm
from app.logger import Logger

class TestLogger(unittest.TestCase):

    def test_debug(self):
        with patch.object(logging, 'debug') as mock_logging:
            log = Logger()
            log.debug('test message')
            mock_logging.assert_called_once()

    def test_info(self):
        with patch.object(logging, 'info') as mock_logging:
            log = Logger()
            log.info('test message')
            mock_logging.assert_called_once()

    def test_warn(self):
        with patch.object(logging, 'warn') as mock_logging:
            log = Logger()
            log.warn('test message')
            mock_logging.assert_called_once()

    def test_error(self):
        with patch.object(logging, 'error') as mock_logging:
            log = Logger()
            log.error('test message')
            mock_logging.assert_called_once()
            
    def test_critical(self):
        with patch.object(logging, 'critical') as mock_logging:
            log = Logger()
            log.critical('test message')
            mock_logging.assert_called_once()

            