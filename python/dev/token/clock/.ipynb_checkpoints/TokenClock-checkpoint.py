import time
from datetime import datetime

class TokenClock():

    def __init__(self, time0 = None):
        self.__time = time.time() if time0 == None else time0
        
    def get_time(self):
        return self.__time
    
    def get_time_stamp(self):
        return datetime.fromtimestamp(self.__time)  
    
    def set_time(self, time):
        self.__time = time
    
    def update(self, time_delta):
        self.__time = self.__time + time_delta
    