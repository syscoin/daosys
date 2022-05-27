from python.dev.lp.event import LPEvent

class WithdrawLPEvent(LPEvent):

     
    def __init__(self, withdraw_action):
        self.__withdraw_action = withdraw_action

    def update(self, liquidity):
        pass
    
    def get_type(self):
        return LPEvent.EVENT_LP_WITHDRAW     
   
    