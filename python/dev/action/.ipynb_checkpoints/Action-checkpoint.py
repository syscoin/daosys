from abc import *

class Action(ABC):
    
    TYPE_TRADE = 'TRADE'
    TYPE_WITHDRAWAL = 'WITHDRAWAL'
    TYPE_DEPOSIT = 'DEPOSIT'
    TYPE_REBASE = 'REBASE'
    TYPE_MINT = 'MINT'    
    
    @abstractmethod
    def apply(self, target, agents)
        pass
    
    @abstractmethod
    def set_type(self, type_action)
        pass
    
    @abstractmethod
    def get_type(self):
        pass
    
    
        