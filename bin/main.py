import os
import collections
import time
import google_auth_oauthlib.flow
import googleapiclient.discovery
import googleapiclient.errors

scopes=["https://www.googleapis.com/auth/youtube.readonly"]
songs=[]
apicallback=[]
pairitems=[]
sortedpair=[]
pairs={}

def main():
    os.environ["OAUTHLIB_INSECURE_TRANSPORT"] = "1"

    api_service_name = "youtube"
    api_version = "v3"
    client_secrets_file = "auth.json"

    # Get credentials and create an API client
    flow = google_auth_oauthlib.flow.InstalledAppFlow.from_client_secrets_file(
        client_secrets_file, scopes,)
    credentials = flow.run_console(include_granted_scopes='true')
    youtube = googleapiclient.discovery.build(
        api_service_name, api_version, credentials=credentials)

    request = youtube.playlistItems().list(
        part="snippet",
        playlistId="LL",
        maxResults=256,
        fields="items(snippet(title,resourceId/videoId)),pageInfo/totalResults"
    )
    apicallback = request.execute()
    for item in apicallback['items']:
        pairs[item['snippet']['title']]=item['snippet']['resourceId']['videoId']

def localSongs():
    for file in os.listdir("../"):
        if file.endswith(".mp3"):
            songs.append(file[:-4])
        

def compareSongs():
    file = open("music.lst","w")
    for key,value in pairs.items():
        if key not in songs:
            file.write("https://youtu.be/"+value+"\n")
    file.close
    

if __name__ == "__main__":
    localSongs()
    main()
    compareSongs()
    os.system('youtubemp3.bat')