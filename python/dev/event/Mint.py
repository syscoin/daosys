from python.dev.event import TokenEvent

class Mint(TokenEvent):
    
    def __init__(self, delta, apy, token_type, is_rebase):
        self.__delta = delta
        self.__apy = apy
        self.__token_type = token_type
        self.__is_rebase = is_rebase
        self.__t_delta = 0
        self.__address = None
        
    def get_apy(self):
        return self.__apy
    
    def get_delta(self):
        return self.__delta   
    
    def get_time_delta(self):
        return self.__t_delta
    
    def get_address(self):
        return self.__address        
    
    def type_of(self):
        return TokenEvent.EVENT_MINT