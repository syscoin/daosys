from python.dev.lp.event import LPEvent
from python.dev.event import Mint

class DepositLPEvent(LPEvent):

     
    def __init__(self, deposit_action):
        self.__deposit_action = deposit_action

    def update(self, liquidity):
        
        x_name = liquidity.get_x_name()
        y_name = liquidity.get_y_name()
        
        target = self.__deposit_action.get_target()
        #target_address = self.__deposit_action.get_event()
        token_type = target.get_token_type()
        token_name = target.get_name()
        
        if(token_type == Mint.TYPE_REBASE):
            #token_yield = target
            pass
        elif(token_type == Mint.TYPE_NONREBASE):
            token_delta = self.__deposit_action.get_event().get_delta()
            if(token_name == x_name): liquidity.delta_x(token_delta)
            if(token_name == y_name): liquidity.delta_y(token_delta)
            
            
        return liquidity.calc()

    def get_type(self):
        return LPEvent.EVENT_LP_DEPOSIT     
   
    