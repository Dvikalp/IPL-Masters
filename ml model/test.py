# -*- coding: utf-8 -*-
"""
Created on Fri Mar 31 22:16:48 2023

@author: vikal
"""

import json
import requests


url = 'http://127.0.0.1:8000/ipl_prediction'

runsLeft=61;
ballsLeft=31;
wic=4;
run=192;
crr=6*(run-runsLeft)/(120-ballsLeft)
rrr=6*(runsLeft)/ballsLeft
batting='Sunrisers Hyderabad'
input_data_for_model = {
    
    'Batting_team': batting,
    'Bowling_team': 'Mumbai Indians',
    'City': 'Kolkata',
    'Runs_left': runsLeft,
    'Balls_left': ballsLeft,
    'Wicket': wic,
    'Total_runs': run,
    'Crr': crr,
    'Rrr':rrr,
    }

input_json = json.dumps(input_data_for_model)

response = requests.post(url, data=input_json)


