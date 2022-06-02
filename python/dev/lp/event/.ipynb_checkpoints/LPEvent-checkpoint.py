from abc import *

class LPEvent(ABC):
    
    EVENT_LP_DEPOSIT = 'LP_DEPOSIT'
    EVENT_LP_WITHDRAW = 'LP_WITHDRAW'
    EVENT_LP_MINT = 'LP_MINT'
    EVENT_LP_SWAP = 'LP_SWAP'
        
    @abstractmethod
    def update(self, liquidity):
        pass
    
    @abstractmethod
    def set_liquidity(self):
        pass    
    
    @abstractmethod
    def get_liquidity(self):
        pass   
    
    @abstractmethod
    def get_action(self):
        pass     
    
    @abstractmethod
    def get_type(self):
        pass 
    
        
   
    