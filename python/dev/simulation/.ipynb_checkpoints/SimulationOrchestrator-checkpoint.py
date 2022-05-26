class SimulationOrchestrator():
    
    def __init__(self, exe = None):
        self.__agents = {}
        
    def apply(self, action):    
        
        user = action.get_user()
        target = action.get_target()
        action_type = action.get_type()
        self.add_agent(target)
        
        return action.apply(self.__agents)
   
    def add_agent(self, target):
        self.__agents[target.get_name()] = target     