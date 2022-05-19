from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Deposit
from python.dev.action import DepositAction

class DepositBatch(Batch):
    
    def __init__(self, target, user, mint_id):
        self.__target = target
        self.__user = user
        self.__mint_id = mint_id
        
    def get_target(self):
        return self.__target
    
    def get_user(self):
        return self.__user    
       
    def simulate_events(self, apy, n_events):
        token_deltas = TokenDeltaModel(1,100).apply(n_events)
        time_deltas = TimeDeltaModel().apply(n_events)
        events = []
        
        for k in range(n_events):
            mint_id = self.__mint_id
            event = Deposit(apy, token_deltas[k], time_deltas[k])
            events.append(DepositAction(event, self.__target, self.__user, mint_id))
            
        return events   
    