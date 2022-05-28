from python.dev.lp.event import LPEvent

class MintLPEvent(LPEvent):

     
    def __init__(self, mint_action1, mint_action2):
        self.__mint_action1 = mint_action1
        self.__mint_action2 = mint_action2

    def update(self, liquidity):
        
        x_delta = self.__mint_action1.get_event().get_delta()
        y_delta = self.__mint_action2.get_event().get_delta()
        
        x_name = self.__mint_action1.get_target().get_name()
        y_name = self.__mint_action2.get_target().get_name()
        
        liquidity.set_x_real(x_delta)
        liquidity.set_y_real(y_delta)
        
        liquidity.set_x_name(x_name)
        liquidity.set_y_name(y_name)        
        
        return liquidity.calc()
        

    def get_type(self):
        return LPEvent.EVENT_LP_MINT    
   
    