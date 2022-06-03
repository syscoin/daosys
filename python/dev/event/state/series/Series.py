import copy

class Series():
    
    def __init__(self, states = None):
        self.__states = [] if states == None else states
        
    def get_states(self):
        return self.__states 
    
    def get_num_states(self):
        return len(self.__states)   
    
    def get_state(self, index):
        #print('{} {}'.format(len(self.__states),index))
        return self.__states[index]  
    
    def get_last_state(self):
        return self.__states[-1]     
    
    def add_state(self, state):
        return self.__states.append(copy.copy(state)) 