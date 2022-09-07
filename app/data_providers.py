import logging
# from os import environ, path, walk
# from sqlite3 import connect

# from forum_app import app_secrets, app_path
# from forum_app.databases import BaseDataProviderInterface

import mysql.connector

class MySqlDataProvider(object):
    """Data provider for MySql"""

    def __init__(self, database_settings):
        self.database_settings = database_settings
        print(self.database_settings)

    def get_server_connection(self):
        mysql_connection = mysql.connector.connect(
            host=self.database_settings['HOST'],
            port=self.database_settings['PORT'],
            user=self.database_settings['USERNAME'],
            password=self.database_settings['PASSWORD'],
            collation='utf8mb4_unicode_ci',
            charset='utf8mb4'
        )
        return mysql_connection

    def execute_batch(self, sql, data_rows):
        connection = None
        mycursor = None
        try:
            connection = self.get_server_connection()
            mycursor = connection.cursor()
            mycursor.executemany(sql, data_rows)
            connection.commit()
            return (0, None) if mycursor is None else (mycursor.rowcount, None)
        except Exception as ex:
            logging.error(ex)
            return (-1, ex)
        finally:
            if mycursor is not None:
                mycursor.close()
            if connection is not None:
                connection.close()