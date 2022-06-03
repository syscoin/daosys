from python.dev.action import Action
from python.dev.event import Swap
from python.dev.event import TokenEvent

class SwapAction(Action):
    
    ACTION_TYPE_WITHDRAW = 'WITHDRAW'
    ACTION_TYPE_DEPOSIT = 'DEPOSIT '
    
    def __init__(self, withdraw_action, deposit_action):
        
        self.__withdraw_action = withdraw_action
        self.__deposit_action = deposit_action
        self.__withdraw_token_event = self.__withdraw_action.get_event()
        self.__deposit_token_event = self.__deposit_action.get_event() 
        self.__token_event = Swap(self.__withdraw_token_event,self.__deposit_token_event)
    
    def apply(self, agents):
                     
        self.__withdraw_action.apply(agents)   
        self.__deposit_action.apply(agents)
           
        return True
    
    def get_event(self):
        return self.__token_event    
        
    def get_user(self):
        return self.__deposit_action.get_user()
    
    def get_target(self, action_type = ACTION_TYPE_DEPOSIT):
        if(action_type == self.ACTION_TYPE_DEPOSIT):
            return self.__deposit_action.get_target() 
        elif(action_type == self.ACTION_TYPE_WITHDRAW):
            return self.__withdraw_action.get_target()
    
    def get_mint_id(self, action_type = ACTION_TYPE_DEPOSIT):
        if(action_type == self.ACTION_TYPE_DEPOSIT):
            return self.__deposit_action.get_mint_id()  
        elif(action_type == self.ACTION_TYPE_WITHDRAW):
            return self.__withdraw_action.get_mint_id()        
          
        
    def get_type(self):
        return self.__token_event.type_of()
    
    
        