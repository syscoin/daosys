from python.dev.agent import Agent

class UserAgent():
    
    def __init__(self, agent_name):
        self.__name = agent_name
        self.__addresses = []
        
    def get_name(self):
        return self.__name
    
    def get_type(self):
        return Agent.TYPE_USER       
