from python.dev.event.state.series.map import MapStateSeries
from python.dev.event.state.series import StateSeries
from python.dev.event.state import State
from python.dev.token.clock import TokenClock
from python.dev.token import Token
from python.dev.event import Deposit

class RebaseToken(Token):
    
    def __init__(self, name, time0 = None):
        super().__init__(name, None, None)
        self.__ini_state = State(Deposit(0, 0, 0)) 
        self.__clock = TokenClock(time0)        
        self.__state_map = MapStateSeries(name)
 
    def get_state_map(self):
        return self.__state_map

    def get_state_series(self, address):
        return self.__state_map.get_states(address)
    
    def mint(self, apy = 0, init_delta = 0):
        
        init_addr = super().gen_address()
        super().deposit(init_delta, init_addr) 
        
        self.__state_map.add_state_series(StateSeries(), init_addr)
        self.__ini_state.update_event(Deposit(apy, init_delta, 0, init_addr))
        self.__ini_state.init_first_state(self.__clock.get_time())
        self.__state_map.add_state(self.__ini_state, init_addr) 

        return init_addr 
 
    def add_event(self, event):
        
        addresses = super().get_addresses()
        supply = super().get_supply_obj()
        address = event.get_address()
        delta = event.get_delta()
          
        if(not addresses.address_exist(address)):
            self.__state_map.add_state_series(StateSeries(), address)
            state = self.__ini_state
            state.update_event(event)
            delta = delta+state.get_yield()                  
            addresses.set_balance(delta, address)
        else:     
            state = self.__state_map.get_states(address).get_last_state()
            state.update_event(event)
            delta = delta+state.get_yield()             
            addresses.delta_balance(delta, address)
            
        self.__state_map.add_state(state, address)                 
        supply.rebase(delta)  
                
        
        
