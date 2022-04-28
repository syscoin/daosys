from abc import *

class IPS(ABC):
    
    @abstractmethod
    def calc_ips_from_state(self,state):
        pass
    
    def calc_ips(self,state):
        pass
        
    
    