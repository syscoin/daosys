from python.dev.lp.event import LPEvent
import copy

class WithdrawLPEvent(LPEvent):

     
    def __init__(self, withdraw_action):
        self.__withdraw_action = withdraw_action
        self.__liquidity = None

    def update(self, liquidity):
        x_name = liquidity.get_x_name()
        y_name = liquidity.get_y_name()
        
        target = self.__withdraw_action.get_target()
        
        token_type = target.get_token_type()
        token_name = target.get_name()
        token_address = self.__retrieve_address()
        target.update_token_index(token_address)
        
        if(token_type == Mint.TYPE_REBASE):       
            token_yield = self.__retrieve_token_yield(token_address)
            token_delta = self.__retrieve_token_delta()
            token_delta = token_delta + token_yield
            if(token_name == x_name): liquidity.delta_x(token_delta)
            if(token_name == y_name): liquidity.delta_y(token_delta)
        elif(token_type == Mint.TYPE_NONREBASE):
            token_delta = self.__retrieve_token_delta()
            if(token_name == x_name): liquidity.delta_x(token_delta)
            if(token_name == y_name): liquidity.delta_y(token_delta)
            
        L = liquidity.calc()
        self.set_liquidity(liquidity)
        
        return L
    
    def set_liquidity(self, liquidity):
        self.__liquidity = copy.copy(liquidity)
        
    def get_liquidity(self):
        return self.__liquidity        
    
    def get_action(self):
        return self.__withdraw_action 
    
    def get_type(self):
        return LPEvent.EVENT_LP_WITHDRAW     
        
    def __retrieve_address(self):
        mint_id = self.__withdraw_action.get_mint_id()
        return self.__withdraw_action.get_target().get_address(mint_id)
    
    def __retrieve_token_yield(self, address):
        token = self.__withdraw_action.get_target().get_token()
        return token.get_state_series(address).get_last_state().get_yield()

    def __retrieve_token_delta(self):
        return self.__withdraw_action.get_event().get_delta()      
   
    