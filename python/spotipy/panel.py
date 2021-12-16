
import json
import urllib

import spotipy
from spotipy.oauth2 import SpotifyOAuth


CLIENT_ID = '20654547a4234c56a6171eeedb448317'
CLIENT_SECRET = 'b38c187c9a0a4ac1afc8a1d316e03505'
REDIRECT_URL = "https://www.google.com/"
SCOPE = 'user-read-playback-state'

sp = spotipy.Spotify(auth_manager=SpotifyOAuth(client_id=CLIENT_ID,
                                               client_secret=CLIENT_SECRET,
                                               redirect_uri=REDIRECT_URL,
                                               scope=SCOPE))

result = sp.current_playback()

print(result['item']['album']['images'][0]['url'])
urllib.request.urlretrieve(result['item']['album']['images'][0]['url'], 'image.jpg')
#print(json.dumps(result,indent=4))

Lavera at Lake Highlands
16775
16795
Grad Admissions - 512-475-7391