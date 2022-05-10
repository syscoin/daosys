import copy
from python.dev.math.interest import Yield

class State():
    
    def __init__(self, event, rebase = True):
        self.__event = event
        self.__tn = 0
        self.__balance = 0
        self.__principle = 0
        self.__yield = 0
        self.__rebase = rebase
  
    def init_first_state(self, t0):
        self.__tn = t0

    def get_balance(self):
        return self.__balance
    
    def get_principle(self):
        return self.__principle   
    
    def get_delta(self):
        return self.__event.get_delta()      
    
    def get_timestamp(self):
        return self.__tn     
    
    def get_yield(self):
        return self.__yield   
    
    def get_event(self):
        return self.__event       
    
    def update_event(self, event):
        self.__event = copy.copy(event) 
        self.update_timestamp()
        self.update_balance()  
        self.update_principle()
       
    def update_timestamp(self):
        self.__tn = self.__tn + self.__event.get_time_delta()

    def update_principle(self):
        self.__principle = self.__principle + self.__event.get_delta()

    def update_balance(self):
        if(self.__rebase): self.update_yield()
    def update_yield(self):
        t_delta = self.__event.get_time_delta()
        apy = self.__event.get_apy()        
        self.__yield = Yield().apply(self.__balance, t_delta, apy)
        
        