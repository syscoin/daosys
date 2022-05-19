from python.dev.agent import Agent
from python.dev.action import Action


class SimulationTarget(Agent):
    
    def __init__(self, agents):
        super().__init__()
        self.__agents = agents

    def apply(self, action, target):
        pass