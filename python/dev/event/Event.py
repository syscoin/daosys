from abc import *

class Event(ABC):
    
    EVENT_DEPOSIT = 'DEPOSIT'
    EVENT_WITHDRAW = 'WITHDRAW'
    EVENT_REBASE = 'REBASE'
    
    @abstractmethod
    def get_time_delta(self):
        pass
    @abstractmethod
    def get_address(self):
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