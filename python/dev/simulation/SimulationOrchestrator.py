
class SimulationOrchestrator():
    
    def __init__(self, exe = None):
        self.__agent = {}

    def add_agent(self, agent):
        self.__agent[agent.get_name()] = agent  
        
    def apply(self, event):
        pass
        
