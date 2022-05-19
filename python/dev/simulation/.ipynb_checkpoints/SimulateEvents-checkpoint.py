from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel


class SimulateEvents():
    
    def __init__(self, target, user):
        self.__target = target
        self.__user = user
        
    def generate_events(self, apy, n):
        token_deltas = TokenDeltaModel(1,100).apply(n)  
        time_deltas = TimeDeltaModel().apply(n)
    