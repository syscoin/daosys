from python.dev.event.state.series.map import MapStateSeries
from python.dev.event.state.series import StateSeries
from python.dev.event.state import State
from python.dev.token.clock import TokenClock
from python.dev.token import Token
from python.dev.event import Deposit

class NonRebaseToken(Token):
    
    def __init__(self, name, time0 = None):
        super().__init__(name, None, None)
        self.__clock = TokenClock(time0)        
        self.__state_map = MapStateSeries(name)

    def get_clock(self):
        return self.__clock        
 
    def get_state_map(self):
        return self.__state_map

    def get_state_series(self, address):
        return self.__state_map.get_states(address)
    
    def mint(self, init_delta = 0):
        init_state = State(Deposit(0, 0, 0), False) 
        init_addr = super().gen_address()
        super().deposit(init_delta, init_addr) 

        self.__state_map.add_state_series(StateSeries(), init_addr)
        init_state.update_event(Deposit(0, init_delta, 0, init_addr))
        init_state.init_first_state(self.__clock.get_time())
        self.__state_map.add_state(init_state, init_addr) 

        return init_addr 
 
    def add_event(self, event):
        
        addresses = super().get_addresses()
        supply = super().get_supply_obj()
        address = event.get_address()
        delta = event.get_delta()
        time_delta = event.get_time_delta()
          
        state = copy.copy(self.__state_map.get_states(address).get_last_state()) 
        state.update_event(event)            
        addresses.delta_balance(delta, address)
            
        self.__state_map.add_state(state, address)  
        self.__clock.update(time_delta)               
        supply.rebase(delta)  
                
        
        
