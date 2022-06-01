class MapLPEventSeries(): 
    
    def __init__(self, name, address_events = None):
        self.__name = name
        self.__address_events = {}  
        
    def get_address_events(self):
        return self.__address_events
    
    def get_events(self, address):
        return self.__address_events[address]   

    def add_lp_series(self, event_series, address):
        self.__address_events[address] = event_series    
        
    def add_event(self, event, address):
        self.__address_events[address].add_event(event)        
    