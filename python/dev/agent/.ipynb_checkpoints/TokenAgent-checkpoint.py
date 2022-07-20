from python.dev.agent import Agent

class TokenAgent():
    
    def __init__(self, agent_name):
        self.__name = agent_name
        self.__addresses = {}
        self.__token_indices = {}
        self.__token = None
        self.__token_type = None
        
    def get_addresses(self):
        return self.__addresses
    
    def get_address(self, mint_id):
        return self.__addresses[mint_id]    
    
    def get_name(self):
        return self.__name
    
    def get_type(self):
        return Agent.TYPE_TOKEN   
    
    def get_token(self):
        return self.__token  
    
    def get_token_type(self):
        return self.__token_type 
    
    def get_token_indices(self):   
        return self.__token_indices

    def get_token_index(self, address):
        
        if (not (address in self.__token_indices)):
            self.__token_indices[address] = 0                

        return self.__token_indices[address]     
    
    def set_token(self, token):
        self.__token = token      
    
    def set_token_type(self, token_type):
        self.__token_type = token_type   
        
    def update_token_index(self, address):        
        self.__token_indices[address] += 1 
        
    def reset_token_indices(self, address):
        if (not (address in self.__token_indices)):
            self.__token_indices[address] = 0
        
    def check_lp_pool(self, lp_pool_name):  
        return lp_pool_name in self.__lp_pools
    
    def add_address(self, mint_id, address):
        self.__addresses[mint_id] = address  
        