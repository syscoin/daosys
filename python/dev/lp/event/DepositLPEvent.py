from python.dev.lp.event import LPEvent

class DepositLPEvent(LPEvent):

     
    def __init__(self, deposit_action):
        self.__deposit_action = deposit_action

    def update(self, liquidity):
        pass

    def get_type(self):
        return LPEvent.EVENT_LP_DEPOSIT     
   
    