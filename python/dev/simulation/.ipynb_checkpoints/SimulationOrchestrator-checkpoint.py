from python.dev.simulation import SimulationTarget

class SimulationOrchestrator():
    
    def __init__(self, exe = None):
        self.__agents = {}
        
    def apply(self, event):    
        
        user = event.get_user()
        target = event.get_target()
        action = event.get_action()
        self.add_agent(target)
        
        return self.execute(action, target)
   
    def add_agent(self, target)
        self.__agents[target.get_name()] = target

    def execute(self, action, target)
        return action.apply(target, agents)       