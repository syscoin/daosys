from python.dev.action import DepositAction
from python.dev.action import Action
from python.dev.event import Withdraw
from python.dev.event import TokenEvent
from python.dev.lp.event import DepositLPEvent
import copy

class WithdrawChainAction(Action):
    
    def __init__(self, action, target, user, mint_id = None):
        self.__action = action
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id        
        
    def get_mint_id(self):
        return self.__mint_id  

    def get_event(self):
        return self.__action.get_event()

    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return TokenEvent.EVENT_WITHDRAW     

    def apply(self, agents):
        
        mint_id = self.get_mint_id()   
        token = self.get_target().get_token()        
        address = self.get_target().get_address(mint_id) 
        apy = self.get_event().get_apy()  
        t_delta = self.get_event().get_time_delta()
        delta = abs(self.get_event().get_delta())    
        
        event = Withdraw(apy, delta, t_delta, address)
        token.add_event(event)                
        
        self.get_target().set_token(token) 
        
        return True


            
    

    
        