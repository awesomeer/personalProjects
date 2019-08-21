import spotipy
import spotipy.util as util
import json

client_id = '20654547a4234c56a6171eeedb448317'
client_secret = 'b38c187c9a0a4ac1afc8a1d316e03505'
redirect_url = 'https://www.google.com/'

scope = 'user-library-read user-read-playback-state user-read-currently-playing user-modify-playback-state'
username = 'mithilesh1'

token = util.prompt_for_user_token(username ,scope, client_id=client_id, client_secret=client_secret, redirect_uri=redirect_url)

clienta = spotipy.Spotify(auth=token);

print(json.dumps(clienta.currently_playing(), indent=4))


