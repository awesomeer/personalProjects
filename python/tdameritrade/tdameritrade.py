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
        print(stock, curr, ' ',  end='')
        for index, second in [(0,59), (1,299), (2,-1)]:
            prev = stockPrices[stock][second]
            print(stock, prev, ' ', end='')
            priceChanges[index][stock] = (100 * (curr - prev)) / prev
        stockPrices[stock] = [curr] + stockPrices[stock][:-1]
        print()
    
    #print(priceChanges)

    sortedChanges = 3*[None]
    for i in [0,1,2]:
        sortedChanges[i] = sorted(priceChanges[i].items(), key=lambda x: x[1], reverse=True)
        #print(sortedChanges[i])

    print('1 minute'.center(20) + '5 minutes'.center(20) + '15 minutes'.center(20))
    for s in range(5 if len(stocks) >= 5 else len(stocks)):
        for t in range(3):
            outStr = sortedChanges[t][s][0] + ': {:.2f}'.format(sortedChanges[t][s][1])
            print(outStr.center(20), end='')
        print()

    

    print()
    time.sleep(1)
