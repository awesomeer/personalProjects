from td.client import TDClient
import threading

CLIENT_ID = 'BUEB2RIHCXF2WSJOYSGSVTRAERIAJESR'
REDIRECT_URL = 'https://www.google.com/'
CREDENTIALS_PATH = 'token.json'
SIZE = 400
WIDTH = 15

TDSession = None
stocks = ''
stockPrices = dict()

priceLock = threading.Lock()
outLock = threading.Lock()

def updatePrices():

	global stockPrices
	global TDSession
	global stocks
	
	print('Price Thread')
	quotes = dict()
	for i in range(len(stocks)//SIZE):
		batch = stocks[ i*SIZE : (i*SIZE)+SIZE ]
		quote = TDSession.get_quotes(instruments=batch)
		quotes.update(quote)

	remain = len(stocks) % SIZE
	if remain != 0:
		quote = TDSession.get_quotes(instruments=stocks[-1*remain:])
		quotes.update(quote)


	priceLock.acquire()
	print('Price Lock acquired')

    # Update 'stockPrices' dict with prices from 'quotes' dict
	print(len(quotes), len(stocks))
	for stock in quotes:
		if quotes[stock]['description'] == 'Symbol not found':
			continue
		if (stock in stockPrices):
			stockPrices[stock] = [quotes[stock]['bidPrice']] + stockPrices[stock][:-1]
		else:
			stockPrices[stock] = 901 * [quotes[stock]['bidPrice']]
    
    # Update 'stockPrices' dict with stocks not found in 'quotes' dict
	for stock in quotes.keys() ^ stockPrices.keys():
		if not (stock in stockPrices):
			continue
		stockPrices[stock] = [stockPrices[stock][0]] + stockPrices[stock][:-1]

	print('outLock released')
	outLock.release()

	threading.Timer(1.0, updatePrices).start()

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

outLock.acquire()
updatePrices()

while True:
	priceChanges = [list() for i in range(3)]

	outLock.acquire()

	# Calculate Price changes
	for stock in stockPrices:
		for index,second in [(0,60), (1, 300), (2, 900)]:
			curr = stockPrices[stock][0]
			prev = stockPrices[stock][second]
			try:
				perChange = 100 * ((curr-prev)/prev)
			except ZeroDivisionError:
				print(stock)
			priceChanges[index].append( (stock, perChange) )
		#print(stock, stockPrices[stock][0])
    
	priceLock.release()

    # Sort 'priceChanges' lists
	#print(priceChanges)
	for i in range(3):
		priceChanges[i] = sorted(priceChanges[i], key = lambda x: x[1], reverse=True)

	print('Now'.center(WIDTH) + '1 minute'.center(WIDTH) + '5 minutes'.center(WIDTH) + '15 minutes'.center(WIDTH))
	for rank in range(5):
		stock = priceChanges[0][rank][0]
		outStr = stock + ': {:.2f}'.format(stockPrices[stock][0])
		print(outStr.center(WIDTH), end ='')
		for time in range(3):
			outStr = priceChanges[time][rank][0] + ': {:.2f}'.format(priceChanges[time][rank][1])
			print(outStr.center(15), end='')
		print()
    
