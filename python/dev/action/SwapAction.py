from python.dev.action import Action
from python.dev.event import Swap

class SwapAction(Action):
    
    def __init__(self, withdraw_action, deposit_action):
        self.__withdraw_action = withdraw_action
        self.__deposit_action = deposit_action
        self.__token_event = Swap(withdraw_action.get_event(), deposit_action.get_event())
        self.__target = deposit_action.get_target()
        self.__user = deposit_action.get_user()
              
    def apply(self, agents):
        
        self.__withdraw_action.apply(agents)     
        self.__deposit_action.apply(agents) 
        
        return True
    
    def get_event(self):
        return self.__token_event    
        
    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return self.__token_event.type_of()
    
    
        