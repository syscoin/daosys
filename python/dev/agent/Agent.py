
class Agent():
    
    TYPE_USER = 'USER'
    TYPE_TOKEN = 'TOKEN'
    
    def __init__(self, agent_name, agent_type):
        self.__name = agent_name
        self.__type = agent_type
    
    def get_name(self):
        return self.__name
        