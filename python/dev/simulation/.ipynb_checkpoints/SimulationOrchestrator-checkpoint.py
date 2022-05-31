class SimulationOrchestrator():
    
    def __init__(self, verbose = False):
        self.__agents = {}
        self.__liquidity_pools = {}
        self.__verbose = verbose
  
    def get_liquidity_pools(self):
        return self.__liquidity_pools 

    def get_liquidity_pool(self, name):
        return self.__liquidity_pools[name]        
        
    def apply(self, action):    
        
        user = action.get_user()
        target = action.get_target()
        action_type = action.get_type()
        self.add_agent(target)
        
        if(self.__verbose):
            name = action.get_target().get_name()
            delta = action.get_event().get_delta()
            mint_id = action.get_mint_id()       
            print('type {} name {} delta {}'.format(action_type,name,delta))
        
        return action.apply(self.__agents)

    def add_liquidity_pool(self, name, lp):
        self.__liquidity_pools[name] = lp    
         
    def add_agent(self, target):
        self.__agents[target.get_name()] = target     