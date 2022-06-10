from python.dev.event import TokenEvent

class Swap(TokenEvent):
   
    def __init__(self, deposit_event):
        self.__t_delta = deposit_event.get_time_delta()
        self.__delta = deposit_event.get_delta()
        self.__from_address = deposit_event.get_address() 
        self.__to_address = deposit_event.get_address()
        
    def get_time_delta(self):
        return self.__t_delta
       
    def get_delta(self):
        return self.__delta
    
    def get_apy(self):
        return self.__apy

    def get_address(self):
        return self.__to_address
    
    def type_of(self):
        return TokenEvent.EVENT_SWAP