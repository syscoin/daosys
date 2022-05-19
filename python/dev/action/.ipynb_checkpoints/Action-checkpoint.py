from abc import *

class Action(ABC):
             
    @abstractmethod        
    def apply(self, agents):
        pass
    @abstractmethod     
    def get_user(self):
        pass
    @abstractmethod 
    def get_target(self):
        pass    
    @abstractmethod     
    def get_type(self):
        pass
    
    
        