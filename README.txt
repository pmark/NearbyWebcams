NearbyWebcams: 3DAR example app
Show nearby webcams locations in AR.  When selected, show latest webcam image and metadata.

DETAILS:
- autofocus:  YES
- focus view:  small webcam thumbnail mapped onto 3D rectangle
- tap to select view:  larger webcam image in frame with rounded corners
- API:  this one query is all we need.  Use HTTPRiot.
- estimated time from start to finish: 2 hours

TASKS:
X* make new app with Utility template
X* copy 3DAR and HR
X* create API client
* parse results into POI objects and add to 3DAR
* create custom marker view
* create custom focus view
* create custom detail view
* add 3DAR info on app's flip side view

API DOCUMENTATION:
* webcams.travel API: http://www.webcams.travel/developers/

PORTLAND WEBCAMS:
http://api.webcams.travel/rest?method=wct.webcams.list_nearby&devid=6edcac77158f8433f2767a4a1b37a01a&lat=45.523548&lng=-122.668705&radius=7&unit=mi&per_page=50&format=xml

NEARBY SEARCH:
http://api.webcams.travel/rest?method=wct.webcams.list_nearby&devid=XXX&lat=XXX&lng=XXX&radius=XXX&unit=mi&per_page=50&format=json

{"status":"ok","webcams":{"count":57,"page":1,"per_page":1,"webcam":[{"user":"feratel","userid":"31893","user_url":"http:\/\/www.webcams.travel\/user\/31893","webcamid":"1232544583","title":"Gornergrat","view_count":"13457","comment_count":"0","url":"http:\/\/www.webcams.travel\/webcam\/1232544583","icon_url":"http:\/\/images.webcams.travel\/icon\/1232544583.png","thumbnail_url":"http:\/\/images.webcams.travel\/thumbnail\/1232544583.jpg","daylight_icon_url":"http:\/\/archive.webcams.travel\/daylight\/icon\/1232544583.png","daylight_thumbnail_url":"http:\/\/archive.webcams.travel\/daylight\/thumbnail\/1232544583.jpg","latitude":"45.983600","longitude":"7.783050","continent":"EU","country":"CH","city":"Blatten","last_update":1264165429,"rating_avg":"5.00","rating_count":3}]}}

<wct_response status="ok">
	<webcams>
		<count>21</count>
		<page>1</page>
		<per_page>10</per_page>
		<webcam>
			<user>user_189</user>
			<userid>3643</userid>
			<user_url>http://www.webcams.travel/user/3643</user_url>
			<webcamid>1010218306</webcamid>
			<title>Zermatt Gornergrat, Matterhorn</title>
			<view_count>282</view_count>
			<comment_count>0</comment_count>
			<url>http://www.webcams.travel/webcam/1010218306</url>
			<thumbnail_url>http://images.webcams.travel/thumbnail/1010218306.jpg</thumbnail_url>
			<icon_url>http://images.webcams.travel/icon/1010218306.png</icon_url>
			<daylight_thumbnail_url>
				http://archive.webcams.travel/daylight/thumbnail/1010218306.jpg
			</daylight_thumbnail_url>
			<daylight_icon_url>
				http://archive.webcams.travel/daylight/icon/1010218306.png
			</daylight_icon_url>
			<latitude>45.983365</latitude>
			<longitude>7.783728</longitude>
			<continent>EU</continent>
			<country>CH</country>
			<city>Zermatt</city>
			<last_update>1214753604</last_update>
			<rating_avg>5.00</rating_avg>
			<rating_count>2</rating_count>
		</webcam>
		...
	</webcams>
</wct_response>



WEBCAM DETAILS (not necessary):
http://api.webcams.travel/rest?method=wct.webcams.get_details&devid=API_KEY&webcamid=1010218306

{"status":"ok","webcam":{"user":"ingo","userid":"3626","user_url":"http:\/\/www.webcams.travel\/user\/3626","webcamid":"1171032474","title":"Hardbr\u00fccke","view_count":"75770","comment_count":"2","url":"http:\/\/www.webcams.travel\/webcam\/1171032474","icon_url":"http:\/\/images.webcams.travel\/icon\/1171032474.png","thumbnail_url":"http:\/\/images.webcams.travel\/thumbnail\/1171032474.jpg","daylight_icon_url":"http:\/\/archive.webcams.travel\/daylight\/icon\/1171032474.png","daylight_thumbnail_url":"http:\/\/archive.webcams.travel\/daylight\/thumbnail\/1171032474.jpg","latitude":"47.387803","longitude":"8.519211","continent":"EU","country":"CH","city":"Z\u00fcrich (Kreis 5)","last_update":1264190287,"rating_avg":"4.20","rating_count":25}}

<wct_response status="ok">
	<webcam>
		<user>ingo</user>
		<userid>3626</userid>
		<user_url>http://www.webcams.travel/user/3626</user_url>
		<webcamid>1171032474</webcamid>
		<title>Hardbrücke</title>
		<view_count>159</view_count>
		<comment_count>1</comment_count>
		<url>http://www.webcams.travel/webcam/1171032474</url>
		<thumbnail_url>http://images.webcams.travel/thumbnail/1171032474.jpg</thumbnail_url>
		<icon_url>http://images.webcams.travel/icon/1171032474.png</icon_url>
		<daylight_thumbnail_url>
			http://archive.webcams.travel/daylight/thumbnail/1171032474.jpg
		</daylight_thumbnail_url>
		<daylight_icon_url>
			http://archive.webcams.travel/daylight/icon/1171032474.png
		</daylight_icon_url>
		<latitude>47.387803</latitude>
		<longitude>8.519211</longitude>
		<continent>EU</continent>
		<country>CH</country>
		<city>Zürich</city>
		<last_update>1214753604</last_update>
		<rating_avg>3.75</rating_avg>
		<rating_count>12</rating_count>
	</webcam>
</wct_response>


