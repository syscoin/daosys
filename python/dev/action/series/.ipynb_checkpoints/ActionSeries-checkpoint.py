from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
import copy


class ActionSeries():
    
    def __init__(self, name, user, n_events = 0):
        self.__name = name
        self.__user = user
        self.__n_events = n_events
        self.__shape = 1
        self.__scale = 100
        self.__no_time_delay = False        
        self.__actions = {}
        self.__token_deltas = {}
        self.__time_deltas = {}
                
    def add_action(self, name, action) 
        self.__actions[name] = action
        
    def set_n_events(self, n_events):
        self.__n_events = n_events
        
    def set_token_deltas(self, name, deltas)
        self.__token_deltas[name] = deltas
        
    def set_time_deltas(self, name, deltas)
        self.__time_deltas[name] = deltas
        
    def gen_time_deltas(self, name, n_events):
        if(self.__time_deltas[name] == []):
            return TimeDeltaModel(self.__no_time_delay).apply(n_events)
        else:
            return self.__time_deltas[name] 
        
    def gen_token_deltas(self, name, n_events):
        if(self.__token_deltas[name] == []):
            return TokenDeltaModel(self.__shape,self.__scale).apply(n_events)
        else:
            return self.__token_deltas[name]
        
        
    def generate_actions(self, n_events = 0)     
    