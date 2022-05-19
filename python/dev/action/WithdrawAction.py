from python.dev.action import Action
from python.dev.event import Withdraw

class WithdrawAction(Action):
    
    def __init__(self, token_event, target, user, mint_id = None):
        self.__token_event = token_event
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id
              
    def apply(self, agents):
        
        token_name = self.__target.get_name()
        token = self.__target.get_token()
        token_type = self.__target.get_token_type()
        
        apy = self.__token_event.get_apy()
        token_delta = self.__token_event.get_delta()
        time_delta = self.__token_event.get_time_delta()        
        address = self.__target.get_address(self.__mint_id)
        
        if(token_type == Withdraw.TYPE_REBASE):
            token.add_event(Withdraw(apy, token_delta, time_delta, address))
        elif(token_type == Withdraw.TYPE_NONREBASE): 
            token.add_event(Withdraw(0, token_delta, time_delta, address))
        
        self.__target.set_token(token)        
        
        return True
        
    def get_user(self):
        return self.__user
    
    def get_target(self):
        return self.__target    
        
    def get_type(self):
        return self.__token_event.type_of()
    
    
        