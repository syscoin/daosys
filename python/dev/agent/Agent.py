from abc import *

class Agent(ABC):
    
    TYPE_USER = 'USER'
    TYPE_TOKEN = 'TOKEN'
    TYPE_LP_TOKEN = 'LP_TOKEN'
    
    @abstractmethod    
    def get_name(self):
        pass
    @abstractmethod    
    def get_type(self):
        pass

        