import time
from datetime import datetime

class TokenClock():

    def __init__(self, time0 = None):
        self.__current_time = time.time() if time0 == None else time0
        self.__init_time = self.__current_time

    def get_time(self):
        return self.__current_time

    def get_time_delta(self):
        return self.__time_delta       
    
    def get_time_stamp(self):
        return datetime.fromtimestamp(self.__time)    
    
    def set_time(self, time):
        self.__time = time
    
    def update(self, current_time):
        self.__time = self.__time + time_delta
        self.__time_delta = self.__time_delta + time_delta
    