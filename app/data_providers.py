import logging
# from os import environ, path, walk
# from sqlite3 import connect

# from forum_app import app_secrets, app_path
# from forum_app.databases import BaseDataProviderInterface

import mysql.connector

class MySqlDataProvider(object):
    """Data provider for MySql"""

    def __init__(self, database_setting_name):
        pass
        # prefix = ''
        # if 'PYTHONANYWHERE_DOMAIN' not in environ:
        #     prefix = 'dev_'
        # setting_name = f'{prefix}{database_setting_name}'
        # self.database_setting_name = database_setting_name
        # self.db_settings = app_secrets['MYSQL'][setting_name]
        # self.database_name = self.db_settings['DATABASE']
