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

stockPrices = dict()

quote = TDSession.get_quotes(instruments=stocks)
for i in range(len(stocks)-1, -1, -1):
    stock = stocks[i]
    try:
        stockPrices[stock] = 900 * [quote[stock]['bidPrice']]
        print(stock, quote[stock]['bidPrice'])
    except KeyError:
        stocks.pop(i)
        print(stock, 'not found')

priceChanges = [dict() for i in range(3)]
while True:
    quote = TDSession.get_quotes(instruments=stocks)
    for stock in stocks:
        curr = quote[stock]['bidPrice']
        for index, second in [(0,59), (1,299), (2,-1)]:
            prev = stockPrices[stock][second]
            priceChanges[index][stock] = (100 * (curr - prev)) / prev
        stockPrices[stock] = [curr] + stockPrices[stock][:-1]
    
    print(priceChanges)

    sortedChanges = 3*[None]
    for i in [0,1,2]:
        sortedChanges[i] = sorted(priceChanges[i].items(), key=lambda x: x[1], reverse=True)
        #print(sortedChanges[i])
    

    print()
    time.sleep(1)
