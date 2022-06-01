from abc import *
from python.dev.event import TokenEvent

class Batch(ABC):
    
    BATCH_DEPOSIT = TokenEvent.EVENT_DEPOSIT
    BATCH_WITHDRAW = TokenEvent.EVENT_WITHDRAW
    BATCH_SWAP = TokenEvent.EVENT_SWAP
 
    @abstractmethod
    def get_user(self):
        pass   

    @abstractmethod
    def get_target(self):
        pass    
    
    @abstractmethod
    def generate_event(self, apy, n):
        pass

    @abstractmethod
    def gen_name(self):
        pass
    
    
    