#!/usr/bin/env python

import json
import requests
from datetime import datetime

WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅',
    '119': '☁️',
    '122': '☁️',
    '143': '☁️',
    '176': '🌧️',
    '179': '🌧️',
    '182': '🌧️',
    '185': '🌧️',
    '200': '⛈️',
    '227': '🌨️',
    '230': '🌨️',
    '248': '☁️',
    '260': '☁️',
    '263': '🌧️',
    '266': '🌧️',
    '281': '🌧️',
    '284': '🌧️',
    '293': '🌧️',
    '296': '🌧️',
    '299': '🌧️',
    '302': '🌧️',
    '305': '🌧️',
    '308': '🌧️',
    '311': '🌧️',
    '314': '🌧️',
    '317': '🌧️',
    '320': '🌨️',
    '323': '🌨️',
    '326': '🌨️',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧️',
    '353': '🌧️',
    '356': '🌧️',
    '359': '🌧️',
    '362': '🌧️',
    '365': '🌧️',
    '368': '🌧️',
    '371': '❄️',
    '374': '🌨️',
    '377': '🌨️',
    '386': '🌨️',
    '389': '🌨️',
    '392': '🌧️',
    '395': '❄️'
}

MOON_PHASES = {
    'New Moon': '🌑',
    'Waxing Crescent': '🌒',
    'First Quarter': '🌓',
    'Waxing Gibbous': '🌔',
    'Full Moon': '🌕',
    'Waning Gibbous': '🌖',
    'Last Quarter': '🌗',
    'Waning Crescent': '🌘'
}


def which_weather_icon(weather_code, local_time_str, astronomy_data):
    if weather_code != '113' and weather_code != '116':
        return WEATHER_CODES[weather_code]
    local_time = datetime.strptime(local_time_str, "%Y-%m-%d %I:%M %p").time()
    sunrise_time = datetime.strptime(astronomy_data['sunrise'], "%I:%M %p").time()
    sunset_time = datetime.strptime(astronomy_data['sunset'], "%I:%M %p").time()
    
    if local_time > sunset_time or local_time < sunrise_time:
        moon_phase = astronomy_data['moon_phase']
        return MOON_PHASES[moon_phase]
    else:
        return WEATHER_CODES[weather_code]


data = {}
weather = requests.get("https://wttr.in/?format=j1").json()
tempint = int(weather['current_condition'][0]['FeelsLikeC'])
extrachar = ''
if tempint > 0 and tempint < 10:
    extrachar = '+'
icon = which_weather_icon(
    weather['current_condition'][0]['weatherCode'],
    weather['current_condition'][0]['localObsDateTime'],
    weather['weather'][0]['astronomy'][0]
)


data['text'] = \
    f" " \
    f"{icon}" \
    f" " \
    f"{extrachar+weather['current_condition'][0]['FeelsLikeC']}" \
    f"°C"

data['tooltip'] = \
    f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']}" \
    f" {weather['current_condition'][0]['temp_C']} °C</b>\n" \
    f"Feels like: {weather['current_condition'][0]['FeelsLikeC']} °C\n" \
    f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n" \
    f"Humidity: {weather['current_condition'][0]['humidity']}%\n" \
    f"Moon phase: {weather['weather'][0]['astronomy'][0]['moon_phase']}"


print(json.dumps(data))
