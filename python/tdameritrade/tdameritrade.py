from td.client import TDClient
import time

CLIENT_ID = 'BUEB2RIHCXF2WSJOYSGSVTRAERIAJESR'
REDIRECT_URL = 'https://www.google.com/'
CREDENTIALS_PATH = 'token.json'

TDSession = TDClient(
            client_id = CLIENT_ID, 
            redirect_uri = REDIRECT_URL,
            credentials_path = CREDENTIALS_PATH
        )

TDSession.login()

# Get the list of stocks to watch, list of stocks as strings
stocks = ''
with open('stocks.list', 'r') as f:
    stocks = f.read()
    stocks = stocks.split()
print(stocks)
stockPrices = dict()

quote = TDSession.get_quotes(instruments=stocks)
for i in range(len(stocks)-1, -1, -1):
    stock = stocks[i]
    print(stock)
    try:
        stockPrices[stock] = 12 * [quote[stock]['bidPrice']]
        print(stock, quote[stock]['bidPrice'])
    except KeyError:
        print(stock, 'not found')
        stocks.pop(i)
        i = i + 1

#print(stockPrices)
