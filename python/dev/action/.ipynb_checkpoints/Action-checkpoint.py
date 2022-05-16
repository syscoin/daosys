from abc import *

class Action(ABC):
    
    TYPE_TRADE = 'TRADE'
    TYPE_WITHDRAWAL = 'WITHDRAWAL'
    TYPE_DEPOSIT = 'DEPOSIT'
    TYPE_REBASE = 'REBASE'
    TYPE_MINT = 'MINT'    
    
    @abstractmethod
    def apply(self, agents):
        pass

    @abstractmethod
    def get_target(self):
        pass   
    
    @abstractmethod
    def get_user(self):
        pass    
         
    @abstractmethod
    def get_type(self):
        pass
    
    
        