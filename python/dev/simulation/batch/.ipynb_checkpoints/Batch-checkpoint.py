from abc import *


class Batch(ABC):
 
    @abstractmethod
    def get_user(self):
        pass   

    @abstractmethod
    def get_target(self):
        pass    
    
    @abstractmethod
    def simulate_events(self):
        pass

    