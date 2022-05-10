from python.dev.simulation import SimulationOrchestrator
from python.dev.simulation import EventQueue
from python.dev.simulation.Agent import Agent

class EventExecutor():
    
    def __init__(self, orchestrator):
        self.__orchestrator = SimulationOrchestrator()
        self.__queue = {}

    def get_handle(self, agent):   
        return 'agent_handle'
        
    def add_event(self, event, agent_handle):
        self.__queue[agent_handle].add_event(event)        
        
    def execute_next(self, agent_handle):
        event = self.__queue[agent_handle].get_event()
        self.__orchestrator.apply(event)
        
        