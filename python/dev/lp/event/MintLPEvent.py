from python.dev.lp.event import LPEvent
import copy

class MintLPEvent(LPEvent):

     
    def __init__(self, mint_action1, mint_action2):
        self.__mint_action1 = mint_action1
        self.__mint_action2 = mint_action2
        self.__liquidity = None

    def update(self, liquidity):
        
        target1 = self.__mint_action1.get_target()
        target2 = self.__mint_action2.get_target()
        
        address1 = self.__retrieve_address(self.__mint_action1)
        address2 = self.__retrieve_address(self.__mint_action2)
        
        target1.reset_token_indices(address1)
        target2.reset_token_indices(address2)
        
        x_delta = self.__mint_action1.get_event().get_delta()
        y_delta = self.__mint_action2.get_event().get_delta()
        
        x_name = self.__mint_action1.get_target().get_name()
        y_name = self.__mint_action2.get_target().get_name()
        
        liquidity.set_x_real(x_delta)
        liquidity.set_y_real(y_delta)
        
        liquidity.set_x_name(x_name)
        liquidity.set_y_name(y_name)        
        
        L = liquidity.calc()
        self.set_liquidity(liquidity)        
        
        return L
 
    def set_liquidity(self, liquidity):
        self.__liquidity = copy.copy(liquidity)
        
    def get_liquidity(self):
        return self.__liquidity        
    
    def get_action(self):
        return self.__mint_action1    

    def get_type(self):
        return LPEvent.EVENT_LP_MINT  
    
    def __retrieve_address(self, mint_action):
        mint_id = mint_action.get_mint_id()
        return mint_action.get_target().get_address(mint_id)
   
    