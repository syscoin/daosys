from python.dev.action import Action
from python.dev.event import Deposit

class DepositAction(Action):
    
    def __init__(self, token_event, target, user, mint_id = None):
        self.__token_event = token_event
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id
              
    def apply(self, agents):
        
        token = self.__target.get_token()        
        address = self.__target.get_address(self.__mint_id)        
        self.__token_event.set_address(address)
        token.add_event(self.__token_event)                
   
        self.__target.set_token(token)        
        
        return True
  
    def get_event(self):
        return self.__token_event

    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return self.__token_event.type_of()
    
    
        