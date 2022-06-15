import uuid

class TokenAddress():   
    
    def __init__(self, gons_per_frag = None):
        self.__gon_balances = {} 
        self.__gons_per_frag = gons_per_frag
        
    def set_gons_per_fragment(gons_per_frag):
        self.__gons_per_frag = gons_per_frag
    
    def get_balance(self, user_address):
        return self.__gon_balances[user_address]/self.__gons_per_frag
    
    def gen_key(self):
        uid = uuid.uuid4()
        return uid.hex
    
    def get_balances(self):
        return self.__gon_balances
    
    def address_exist(self, address):
        return address in self.__gon_balances.keys()
    
    def set_address(self, user_address):
        self.__gon_balances[user_address] = 0
    
    def set_balance(self, balance, user_address):
        self.__gon_balances[user_address] = balance/self.__gons_per_frag
        
    def delta_balance(self, delta, user_address):
        gon_delta = delta/self.__gons_per_frag
        
        new_balance = self.__gon_balances[user_address] + gon_delta 
        
        if(new_balance >= 0): 
            self.__gon_balances[user_address] = new_balance
        else:
            print('TokenAddress Error, negative balance')
     