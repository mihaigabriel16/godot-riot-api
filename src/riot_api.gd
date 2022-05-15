extends Node

var http_request = HTTPRequest.new()

var key = "RGAPI-2795fc01-4389-4a92-a7e6-54b97ab0be6d"
var apiVersion = null
var last_request = null
var REQUEST_QUEUE = []
var IS_REQUESTING = false

var API_URL = "https://%s.api.riotgames.com"
var ENDPOINT_PLATFORM = "/lol/platform/v%s/"
var ENDPOINT_SUMMONER = "/lol/summoner/v%s/"

var PlatformsDictionary = {
	"EUNE": "eun1",
	"EUW": "euw1",
	"NA": "na1"
}

func _ready():
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	GetVersion()
	$OptionButton.add_item("EUW")
	$OptionButton.add_item("EUNE")
	
	
func request(function):
	call(function)
	
func _http_request_completed(result, response_code, headers, body):
	print("Response Code: "+str(response_code)+"\nResult: "+str(result))
	match last_request:
		"GetVersion":
			apiVersion = parse_json(body.get_string_from_utf8())[0]
			print("API VERSION: " + str(apiVersion))
		"GetSummonerByName":
			var data = parse_json(body.get_string_from_ascii())
			print(data)
	#+"\nBody: "+body.get_string_from_utf8())

func GetPlatform(region):
	return PlatformsDictionary[region]

func GetSummonerByName(name, platform):
	last_request = "GetSummonerByName"
	var api_call: String = "summoners/by-name/" + name
	var raw: String = API_URL + ENDPOINT_SUMMONER + api_call
	var url: String = raw % ["eun1", platform]
	print(url)
	var token = "X-Riot-Token:" + key
	var headers = [token]
	http_request.request(url, headers, false)

func GetSummonerByAccount(name, platform):
	last_request = "GetSummonerByName"
	var api_call: String = "summoners/by-name/" + name
	var raw: String = API_URL + ENDPOINT_SUMMONER + api_call
	var url: String = raw % ["euw1", platform]
	print(url)
	var token = "X-Riot-Token:" + key
	var headers = [token]
	http_request.request(url, headers, false)

func GetVersion():
	last_request = "GetVersion"
	var url = "https://ddragon.leagueoflegends.com/api/versions.json"
	var req = http_request.request(url)


func _on_Button_pressed():
	var region = GetPlatform($OptionButton.get_item_text($OptionButton.get_selected_id()))
	#print(region)s
	GetSummonerByName($TextEdit.text, 4)
