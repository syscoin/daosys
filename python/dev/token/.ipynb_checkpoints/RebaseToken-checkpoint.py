from python.dev.event.state.series.map import MapStateSeries
from python.dev.event.state.series import StateSeries
from python.dev.event.state import State
from python.dev.token.clock import TokenClock
from python.dev.token import Token
from python.dev.event import Deposit
from python.dev.event import Rebase
import copy

class RebaseToken(Token):
    
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

    def update_rebases(self, apy, addresses):
        T_clock = self.get_clock().get_time()
        for k in range(len(addresses)):
            T_time = self.__state_map.get_states(addresses[k]).get_last_state().get_timestamp()
            if(T_time < T_clock):
                time_delta = T_clock - T_time
                self.add_event(Rebase(apy, time_delta, addresses[k]))       

        
    def mint(self, init_delta = 0, apy = 0):
        
        init_state = State(Deposit(0, 0, 0)) 
        init_addr = super().gen_address()
        super().deposit(init_delta, init_addr) 
        
        self.__state_map.add_state_series(StateSeries(), init_addr)
        init_state.update_event(Deposit(apy, init_delta, 0, init_addr))
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
        delta = delta+state.get_yield()             
        addresses.delta_balance(delta, address)
        
        clock_update_delta = state.get_timestamp() - self.__clock.get_time()
        self.__state_map.add_state(state, address) 
    
        self.__clock.update(clock_update_delta)                
        supply.rebase(delta)  
                
        
        
