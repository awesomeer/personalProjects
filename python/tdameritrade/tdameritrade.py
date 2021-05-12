from td.client import TDClient
import time

CLIENT_ID = 'BUEB2RIHCXF2WSJOYSGSVTRAERIAJESR'
REDIRECT_URL = 'https://www.google.com/'
CREDENTIALS_PATH = 'token.json'
SIZE = 400

TDSession = None
stocks = ''
stockPrices = dict()
quotes = dict()

quoteLock = threading.Lock()

def updateQuotes(stocks, quotes, session):
	
	quoteLock.acquire()	
	
	for i in range(len(stocks)//SIZE):
		batch = stocks[ i*400 : (i*400)+400 ]
		quote = session.get_quotes(instrument=batch)
		quotes.update(quote)
	
	remain = len(stocks) % SIZE
	if remain != 0:
		quote = session.get_quotes(instruments=stocks[-1*remain:])
		quotes.update(quote)
		
	quoteLock.release()

def updateStockPrices(stockPrices, quotes):
	for stock in stockPrices:
		stockPrices[stock] = [quotes[stock]['bidPrice']] + stockPrices[stock][:-1]
		

# Create session for TD Ameritrade
TDSession = TDClient(
            client_id = CLIENT_ID, 
            redirect_uri = REDIRECT_URL,
            credentials_path = CREDENTIALS_PATH
        )

TDSession.login()


# Read in the list of stocks to monitor
with open('all.list', 'r') as f:
	stocks = f.read()
	stocks = stocks.split()

updateQuotes(stocks, quotes, session)


# Init stockPrices and remove exccess stocks from 'stocks' list (stocks that cause a KeyError)
for s in range(len(stocks)-1, -1, -1):
	stock = stocks[s]
	if stock in quotes:
		stockPrices[stock] = 900 * [quotes[stock]['bidPrice']]
	else:
		stocks.pop(s)


quoteTimer = threading.Timer(1.0, updateQuotes, args = (stocks, quotes, TDSession, ))
quoteTimer.start()

priceChanges = [dict() for i in range(3)]
while True:
    


"""
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
        stockPrices[stock] = 900 * [quote[stock]['bidPrice']]
        print(stock, quote[stock]['bidPrice'])
    except KeyError:
        stocks.pop(i)
        print(stock, 'not found')

priceChanges = [dict() for i in range(3)]
while True:
    quote = TDSession.get_quotes(instruments=stocks)
    print('Now'.center(15) + '1 minute'.center(15) + '5 minutes'.center(15) + '15 minutes'.center(15))

    for stock in stocks:

        curr = 0
        try:
            curr = quote[stock]['bidPrice']
        except KeyError:
            curr = stockPrices[stock][0]
            print('KeyError:', stock)

        outString = stock + ': {:.2f}'.format(curr)
        print(outString.center(15), end='')
        #print(stock, curr, ' ',  end='')

        for index, second in [(0,59), (1,299), (2,-1)]:
            prev = stockPrices[stock][second]
            priceChanges[index][stock] = (100 * (curr - prev)) / prev

            outString = stock + ': {:.2f}'.format(prev)
            print(outString.center(15), end='')
            #print(stock, prev, ' ', end='')

        stockPrices[stock] = [curr] + stockPrices[stock][:-1]
        print()


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
   """
