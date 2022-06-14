from python.dev.action import DepositAction
from python.dev.action import Action
from python.dev.event import Deposit
from python.dev.event import TokenEvent
from python.dev.lp.event import DepositLPEvent
import copy

class DepositChainAction(Action):
    
    def __init__(self, action, target, user, mint_id = None):
        self.__action = action
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id        
        self.__x_target = target.get_x_target()
        self.__y_target = target.get_y_target()
        self.__prev_liquidity_val = 0
 
    def get_prev_liquidity(self):
        return self.__prev_liquidity_val

    def set_prev_liquidity(self, prev_liquidity):
        self.__prev_liquidity_val = copy.copy(prev_liquidity)
        
    def get_mint_id(self):
        return self.__mint_id  

    def get_event(self):
        return self.__action.get_event()

    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return TokenEvent.EVENT_DEPOSIT      

    def apply(self, agents):
        
        mint_id = self.get_mint_id()   
        token = self.get_target().get_token()        
        address = self.get_target().get_address(mint_id) 
        token_index = self.get_target().get_token_index(address)
        apy = self.get_event().get_apy()  
        t_delta = self.get_event().get_time_delta()
        delta = -self.get_event().get_delta()    
        self.__action.apply(agents)
        
        event = Deposit(apy, delta, t_delta, address)
        self.__update_lp(event)
        lp_delta = self.__calc_delta(token_index)

        event = Deposit(apy, lp_delta, t_delta, address)
        token.add_event(event)                
        
        self.get_target().set_token(token) 
        self.get_target().update_token_index(address)
        
        return True
    


            
    

    
        