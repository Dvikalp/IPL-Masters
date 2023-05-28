# -*- coding: utf-8 -*-
"""
Created on Fri Mar 31 20:53:43 2023

@author: vikal
"""

#python -m uvicorn ipl_predict:app --reload

from fastapi import FastAPI
from pydantic import BaseModel
import pickle
import json
import pandas as pd

app=FastAPI()

class model_input(BaseModel):
    Batting_team: str
    Bowling_team: str
    City: str
    Runs_left: int
    Balls_left: int
    Wicket: int
    Total_runs: int
    Crr:float
    Rrr:float
    
  

my_model= pickle.load(open('pipe.pkl','rb'))


@app.post('/ipl_prediction')
def ipl_pred(input_parameters : model_input) :
    input_data = input_parameters.json()
    input_dictionary = json.loads(input_data)
    
    
    #input_list=[batting_team,bowling_team,city,runs_left,balls_left,wickets,total_runs_x,current_rr,req_rr]
    #prob= my_model.predict([input_list])
    
    input_df=pd.DataFrame({
    'batting_team':[input_dictionary['Batting_team']],
    'bowling_team':[input_dictionary['Bowling_team']],
    'city':[input_dictionary['City']],
    'runs_left':[input_dictionary['Runs_left']],
    'balls_left':[input_dictionary['Balls_left']],
    'wickets':[input_dictionary['Wicket']],
    'total_runs_x':[input_dictionary['Total_runs']],
    'current_rr':[input_dictionary['Crr']],
    'req_rr':[input_dictionary['Rrr']],
    })
    
    prob=my_model.predict_proba(input_df)
    prob=prob.tolist()
    prob=prob[0]
    print(prob)
    return{
        'lose': prob[0],
        'win':prob[1]
        }   
    

@app.get('/')
def index():
    return {'message': 'Hello, World'}

    
    
    
    

