from python.dev.event import TokenEvent
from python.dev.lp.event import MintLPEvent
from python.dev.lp.event import DepositLPEvent
from python.dev.lp.event import SwapLPEvent
import queue

class SimulationOrchestrator():
    
    def __init__(self, verbose = False):
        self.__agents = {}
        self.__verbose = verbose
        self.__mint_queue = queue.Queue()
        
    def get_verbose(self):
        return self.__verbose
         
    def apply(self, action):    

        is_complete = action.apply(self.__agents)   
        if(self.__verbose): self.__print_out(action)
        
        return is_complete
         
    def add_agent(self, target):
        self.__agents[target.get_name()] = target 

    def __print_out(self, action):
        user = action.get_user().get_name()
        name = action.get_target().get_name()
        t_delta = abs(action.get_event().get_time_delta())
        delta = abs(action.get_event().get_delta())
        mint_id = action.get_mint_id()    
        action_type = action.get_type()
        address = action.get_target().get_address(mint_id)         
        print('{} {} {} for {}'.format(action_type, delta, name, user))         
        