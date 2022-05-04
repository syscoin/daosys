from python.dev.token.supply import TokenSupply
from python.dev.token.address import TokenAddress

class Token():
    
    def __init__(self, name, symbol = None, supply = None, addresses = None):
        self.__name = name
        self.__symbol = symbol
        self.__supply_obj = TokenSupply() if supply == None else supply
        self.__addresses = TokenAddress(self.__supply.get_gons_per_fragment()) if addresses == None else addresses

    def get_name(self):
        return self.__name  

    def get_symbol(self):
        return self.__symbol         
        
    def get_addresses(self):
        return self.__addresses
    
    def get_supply_obj(self):
        return self.__supply_obj  

    def balance_of(self, user_address):
        return self.__addresses.get_balance(user_address)      

    def total_supply(self):
        return self.__supply_obj.get_total_supply()             
    
    def set_rate(self, native_rate):
        self.__native_rate = native_rate 
        
    def set_addresses(self, addresses):
        self.__addresses = addresses
        
    def set_total_supply(self, total_supply):
        return self.__supply_obj.set_total_supply(total_supply)       

    def gen_address(self):
        return self.__addresses.gen_key()   
    
    def get_balance_deposits(self, addresses = None):
        if(addresses == None):
            deposits = self.__addresses.get_balances()
            deposits = list(deposits.values())
        else:
            deposits = [self.__addresses.get_balance(addr) for addr in addresses] 
            
        return sum(deposits)
    
    def deposit(self, delta, address):
        
        if(not self.__addresses.address_exist(address)):
            self.__addresses.set_balance(delta, address)
        else:    
            self.__addresses.delta_balance(delta, address)
 
        self.__supply.rebase(delta) 
    
    def transfer(self, delta, from_address, to_address):
        self.__addresses.delta_balance(-delta, from_address)
        self.__addresses.delta_balance(delta, to_address)
     
    def rebase(self, delta):
        self.__supply.rebase(delta)  