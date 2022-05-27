from python.dev.lp.event import LPEvent

class SwapLPEvent(LPEvent):

     
    def __init__(self, swap_action):
        self.__swap_action = swap_action

    def update(self, liquidity):
        pass
    
    def get_type(self):
        return LPEvent.EVENT_LP_SWAP     
   
    