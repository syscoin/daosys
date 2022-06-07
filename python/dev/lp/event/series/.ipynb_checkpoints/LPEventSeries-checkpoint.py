import copy
from datetime import datetime

class LPEventSeries():
    
    def __init__(self, name, events = None):
        self.__name = name
        self.__events = [] if events == None else events
        self.__liquidity_values = []
        self.__prices = []
        self.__dates = []
  
    def get_name(self):
        return self.__name 

    def get_liquidity_values(self):            
        return self.__liquidity_values 

    def get_prices(self):            
        return self.__prices    
    
    def get_dates(self):            
        return self.__dates     
  
    def get_events(self):
        return self.__events 
    
    def get_event(self, index):
        return self.__events[index]    
    
    def get_num_events(self):
        return len(self.__events)   
    
    def get_event(self, index):
        return self.__events[index]  
    
    def get_last_event(self):
        return self.__events[-1]     
    
    def add_event(self, event): 
        self.__events.append(copy.copy(event)) 
        self.update_liquidity_values()
        self.update_prices()
        self.update_dates()
        return self.__events
 
    def update_liquidity_values(self):
        val = self.get_last_event().get_liquidity().get_liquidity_val()
        self.__liquidity_values.append(val)
        
    def update_prices(self):
        price = self.get_last_event().get_liquidity().get_swap_price()
        self.__prices.append(price)    
        
    def update_dates(self):
        
        token_address = self.__retrieve_address()
        unix_time_stamp = self.__retrieve_time_stamp(token_address)
        time_stamp = datetime.fromtimestamp(unix_time_stamp) 
        self.__dates.append(time_stamp) 

    def __retrieve_time_stamp(self, address):
        index = self.get_last_event().get_action().get_target().get_token_index(address)
        token = self.get_last_event().get_action().get_target().get_token() 
        return token.get_state_series(address).get_state(index).get_timestamp()                
    def __retrieve_address(self):
        action = self.get_last_event().get_action()
        mint_id = action.get_mint_id()        
        addresses = action.get_target().get_address(mint_id)        
        return action.get_target().get_address(mint_id)   

        