from python.dev.event.state.series.map import MapStateSeries
from python.dev.event.state.series import StateSeries
from python.dev.event.state import State
from python.dev.token import Token
from python.dev.event import Deposit

class NonRebaseToken(Token):
    
    def __init__(self, name, supply = None, addresses = None):
        super().__init__(name, None, None)
        self.__ini_state = None
        self.__state_map = MapStateSeries(name)
 
    def get_state_map(self):
        return self.__state_map

    def get_state_series(self, address):
        return self.__state_map.get_states(address)
    
    def init_token(self, time0, address):
        self.__ini_state = State(Deposit(0,0,0), False)
        self.__ini_state.init_first_state(time0)
 
    def add_event(self, event):
        
        addresses = super().get_addresses()
        supply = super().get_supply()
        address = event.get_address()
        delta = event.get_delta()
        
        if(not addresses.address_exist(address)):
            self.__state_map.add_state_series(StateSeries(), address)
            state = self.__ini_state
            state.update_event(event)
            addresses.set_balance(delta, address)
        else:   
            state = self.__state_map.get_states(address).get_last_state()
            state.update_event(event)            
            addresses.delta_balance(delta, address)
            
        self.__state_map.add_state(state, address)                 
        supply.rebase(delta)  
                
        
        
