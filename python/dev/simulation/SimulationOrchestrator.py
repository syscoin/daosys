from python.dev.event import TokenEvent
from python.dev.lp.event import MintLPEvent
from python.dev.lp.event import DepositLPEvent
from python.dev.lp.event import SwapLPEvent
import queue

class SimulationOrchestrator():
    
    def __init__(self, verbose = False):
        self.__agents = {}
        self.__liquidity_pools = {}
        self.__liquidity_pool_targets = {}
        self.__verbose = verbose
        self.__mint_queue = queue.Queue()
  
    def get_liquidity_pools(self):
        return self.__liquidity_pools 

    def get_liquidity_pool(self, name):
        return self.__liquidity_pools[name]        
        
    def apply(self, action):    
            
        #target = action.get_target()
        #self.add_agent(target)
        is_complete = action.apply(self.__agents) 
        
        
        self.__update_lp(action)
        if(self.__verbose): self.__print_out(action)
        
        
        
        return is_complete

    def add_liquidity_pool(self, name, lp):
        self.__liquidity_pools[name] = lp 
        self.__add_liquidity_pool_targets(lp)
         
    def add_agent(self, target):
        self.__agents[target.get_name()] = target 
         
    def __update_lp(self, action): 
        target = action.get_target()
        lp_name = self.__check_liquidity_pool(target)
        if(lp_name != None): self.__update_lp_queue(action, lp_name)                    
    def __update_lp_queue(self, action, lp_name):
        lp = self.get_liquidity_pool(lp_name)     
        if(action.get_type() == TokenEvent.EVENT_MINT):                    
            if(self.__mint_queue.qsize()  <= 0):
                self.__mint_queue.put(action)
            else: 
                m_action1 = self.__mint_queue.get()                 
                lp.update_event(MintLPEvent(m_action1,action)) 
        elif(action.get_type() == TokenEvent.EVENT_DEPOSIT): 
            lp.update_event(DepositLPEvent(action))
        elif(action.get_type() == TokenEvent.EVENT_SWAP): 
             lp.update_event(SwapLPEvent(action))        
    
    def __add_liquidity_pool_targets(self, lp):    
        x_target_name = lp.get_x_target().get_name()
        y_target_name = lp.get_y_target().get_name()
        self.__liquidity_pool_targets[x_target_name] = lp.get_name()
        self.__liquidity_pool_targets[y_target_name] = lp.get_name()
            
    def __check_liquidity_pool(self, target):
        target_name = target.get_name()
        if(target_name in self.__liquidity_pool_targets):
            return self.__liquidity_pool_targets[target_name] 
        else:
            return None
        
    def __print_out(self, action):
        name = action.get_target().get_name()
        delta = action.get_event().get_delta()
        mint_id = action.get_mint_id()    
        action_type = action.get_type()
        address = action.get_target().get_address(mint_id) 
        print('type {} name {} delta {}'.format(action_type, name, address))         
        