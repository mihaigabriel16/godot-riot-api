extends Node

var key = ""
var apiVersion = null

var API_URL = "https://%s.api.riotgames.com"
var ENDPOINT_PLATFORM = "/lol/platform/v%s/"
var ENDPOINT_SUMMONER = "/lol/summoner/v%s/"



func _ready():
	var test = GetVersion()
	

	
func GetSummonerByName(name: String):
	var http = HTTPRequest.new()
	add_child(http)
	var api_call: String = "summoners/by-name/" + name
	var raw: String = API_URL + ENDPOINT_SUMMONER + api_call
	var url: String = raw % ["eun1", 4]
	print(url)
	var token = "X-Riot-Token:" + key
	var headers = [token]
	var req = http.request(url, headers, false)
	var task = yield(http, "request_completed")
	var data = task[3].get_string_from_utf8()
	var json = JSON.parse(data).result
	return json


func GetSummonerByAccount(encryptedAccountId: String):
	var http = HTTPRequest.new()
	add_child(http)
	var api_call: String = "summoners/by-account/" + encryptedAccountId
	var raw: String = API_URL + ENDPOINT_SUMMONER + api_call
	var url: String = raw % ["eun1", 4]
	print(url)
	var token = "X-Riot-Token:" + key
	var headers = [token]
	http.request(url, headers, false)
	

func GetVersion():
	var http = HTTPRequest.new()
	add_child(http)
	var url = "https://ddragon.leagueoflegends.com/api/versions.json"
	var req = http.request(url)
	var task = yield(http, "request_completed")
	var data = task[3].get_string_from_utf8()
	var json = JSON.parse(data).result[0]
	return json


func _on_Button_pressed():
	#print(region)s
	GetSummonerByName($TextEdit.text)
