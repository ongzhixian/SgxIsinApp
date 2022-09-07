"""
'yafi_fetch' master

1.  This script download the instrument list from SGX.
2.  It then parses the list for tickers.
3.  Tickers are then written to the 'yafi_fetch' queue.
"""

import json
import logging
import sys

from datetime import datetime
from os import path
from urllib.parse import quote
from urllib.request import urlopen as url_open
from urllib.request import Request as url_request
import re

import pika
from logger import Logger
from data_providers import MySqlDataProvider


EXCHANGE_NAME = 'financial_instrument'
ROUTING_KEY = "yafi.fetch"
QUEUE_NAME = 'yafi_fetch'


def setup_rabbit_mq(channel):
    channel.exchange_declare(
        exchange=EXCHANGE_NAME, 
        exchange_type='topic')
        
    channel.queue_declare(
        queue=QUEUE_NAME, 
        durable=True)
    
    channel.queue_bind(
        exchange=EXCHANGE_NAME, 
        routing_key=ROUTING_KEY,
        queue=QUEUE_NAME)


def publish_tickers(url_parameters, ticker_list):

    with pika.BlockingConnection(url_parameters) as connection, connection.channel() as channel:

        setup_rabbit_mq(channel)

        for ticker in ticker_list:

            channel.basic_publish(
                exchange=EXCHANGE_NAME, 
                routing_key=ROUTING_KEY, 
                body=ticker,
                properties=pika.BasicProperties(
                    delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE
                ))

            log.info(f"Publish {ticker}", event="publish", type="ticker", target=ticker)
        

def  get_tickers_from_instrument_list(sgx_isin_data):
    # log.info("Parse SGX instrument list", source="program", event="parse", target="ticker", data_source="SGX instrument list")
    # return ['BN4', 'C09']
    # sql = 'INSERT INTO `instrument` (mic, code, name, counter, isin) VALUES (?, ?, ?, ?, ?)'
    ticker_list = []
    instrument_list = []
    sgx_isin_layout = r"(?P<name>.{50})(?P<status>.{10})(?P<isin>.{20})(?P<code>.{10})(?P<counter>.+)"
    
    isin_line_list = sgx_isin_data.splitlines()
    for line in isin_line_list[1:]:
        if len(line.strip()) <= 0:
            continue
        
        match_result = re.match(sgx_isin_layout, line)
        if match_result is None:
            continue
        
        code = match_result.group('code').strip()
        ticker_list.append(code)
        instrument_list.append(
            (
                'XSGX', 
                match_result.group('code').strip(),
                match_result.group('name').strip(),
                match_result.group('counter').strip(),
                match_result.group('isin').strip()
            )
        )
    
    logging.info(f"Tickers from SGX: {len(ticker_list)}")
    # return ticker_list
    return ['BN4', 'C09']


def save_sgx_isin_to_file(data):
    FILE_DATETIME = datetime.utcnow().strftime("%Y%m%d-%H%M%S")
    FILE_NAME = f'sgx-isin-{FILE_DATETIME}.txt'
    SAVE_FILE_PATH = path.join(output_path, FILE_NAME)
    with open(SAVE_FILE_PATH, 'w', encoding='utf-8') as out_file:
        out_file.write(data)


def download_sgx_instrument_list(output_path=None):
    log.info("Download SGX instrument list", source="program", event="download", target="SGX instrument list")
    # Save downloaded file
    today = datetime.today().strftime('%d %b %Y')
    logging.info(f"Getting ISINs from SGX for {today}")
    url = f'https://links.sgx.com/1.0.0/isin/1/{quote(today)}'
    
    request = url_request(
        url, 
        data=None, 
        headers={
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:103.0) Gecko/20100101 Firefox/103.0'
        }
    )

    with url_open(request) as response:
        sgx_isin_data = response.read().decode("utf-8")

    # TODO: Some download data verification would be nice

    if output_path is not None:
        save_sgx_isin_to_file(sgx_isin_data)
    
    return sgx_isin_data


def get_output_file_path():
    if len(sys.argv) < 3:
        print("ERROR - Require output file path as second argument")
        exit(1)

    full_path = path.abspath(sys.argv[2])
    
    if not path.exists(full_path):
        print(f"ERROR - output path does not exists {full_path}")
        exit(2)

    return full_path


def get_cloudamqp_url_parameters():
        
    if len(sys.argv) < 1:
        exit(1)
    
    full_path = path.abspath(sys.argv[1])
    
    if not path.exists(full_path):
        exit(2)
    
    try:
        with open(full_path, "r", encoding="utf-8") as in_file:
            json_data = json.load(in_file)
    except Exception:
        exit(3)
    
    if 'cloud_amqp' not in json_data:
        exit(4)
    if 'armadillo' not in json_data['cloud_amqp']:
        exit(4)
    if 'url' not in json_data['cloud_amqp']['armadillo']:
        exit(4)
    
    cloud_amqp_url = json_data['cloud_amqp']['armadillo']['url']

    log.info("Cloud AMQP URL read", source="program", event="set", target="cloud amqp url")
    
    return pika.URLParameters(cloud_amqp_url)


def get_database_settings():
    if len(sys.argv) < 4:
        print("ERROR - Require output file path as third argument")
        exit(1)

    full_path = path.abspath(sys.argv[3])
    
    if not path.exists(full_path):
        print(f"ERROR - output path does not exists {full_path}")
        exit(2)

    with open(full_path, 'r', encoding='utf-8') as in_file:
        mysql_settings = json.loads(in_file.read())
    return mysql_settings


def setup_logging():
    logging.getLogger('pika').setLevel(logging.WARNING)
    log = Logger()
    return log


if __name__ == "__main__":
    log = setup_logging()
    # Takes 3 arguments: .cloud-amqp.json output-path .mysql.json
    url_parameters = get_cloudamqp_url_parameters()
    output_path = get_output_file_path()
    database_settings = get_database_settings()

    sgx_isin_data = download_sgx_instrument_list(output_path)
    ticker_list = get_tickers_from_instrument_list(sgx_isin_data)
    # filter ticker_list with blacklist
    # publish_tickers(url_parameters, ticker_list)
    # from data_providers import MySqlDataProvider
    mysql = MySqlDataProvider(database_settings['financial'])
    # NAME                                              STATUS    ISIN CODE           CODE      TRADING COUNTER NAME
    sql = 'INSERT INTO `instrument` (mic, code, name, counter, isin) VALUES (?, ?, ?, ?, ?)'
    data_rows = [
        ('asd',)
    ]
    mysql.execute_batch(sql, data_rows)
    
    # settings_path = '/mnt/secrets/mysql/.mysql-settings.json'
    # with open(settings_path, 'r', encoding='utf-8') as in_file:
    #     jj = json.loads(in_file.read())
    # print(jj)
    log.info("Program complete", source="program", event="complete")
