from abc import *

class TokenEvent(ABC):
    
    EVENT_DEPOSIT = 'DEPOSIT'
    EVENT_WITHDRAW = 'WITHDRAW'
    EVENT_REBASE = 'REBASE'
    EVENT_MINT = 'MINT'
        
    @abstractmethod
    def get_time_delta(self):
        pass 
    @abstractmethod
    def type_of(self):
        pass
    @abstractmethod
    def get_apy(self):
        pass
    @abstractmethod
    def get_delta(self):
        pass  