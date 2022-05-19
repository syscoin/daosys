from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Withdraw
from python.dev.action import Action


class WithdrawBatch(Batch):
    
    def __init__(self, target, user):
        self.__target = target
        self.__user = user
        
    def get_target(self):
        return self.__target
    
    def get_user(self):
        return self.__user    
       
    def simulate_events(self, apy, n_events):
        token_deltas = TokenDeltaModel(1,100).apply(n_events)
        time_deltas = TimeDeltaModel().apply(n_events)
        events = []
        
        for k in range(n_events):
            event = Withdraw(apy, token_deltas[k], time_deltas[k])
            events.append(Action(event, self.__target, self.__user))
            
        return events   
    