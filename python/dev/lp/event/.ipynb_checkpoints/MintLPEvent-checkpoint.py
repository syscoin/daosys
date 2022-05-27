from python.dev.lp.event import LPEvent

class MintLPEvent(LPEvent):

     
    def __init__(self, mint_action1, mint_action2):
        self.__mint_action1 = mint_action1
        self.__mint_action2 = mint_action2

    def update(self, liquidity):
        pass

    def get_type(self):
        return LPEvent.EVENT_LP_MINT    
   
    