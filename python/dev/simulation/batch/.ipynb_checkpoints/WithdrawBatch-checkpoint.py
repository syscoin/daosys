from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Withdraw
from python.dev.action import WithdrawAction


class WithdrawBatch(Batch):
    
    def __init__(self, target, user, mint_event):
        self.__target = target
        self.__user = user
        self.__mint_event = mint_event 
        self.__shape = 1
        self.__scale = 100
        self.__time_delay = 100
        self.__no_time_delay = False   
        self.__token_del = []  
        self.__time_del = []
 
    def set_token_delta_shape(self, token_delta_shape):
        self.__shape = token_delta_shape
        
    def set_token_delta_scale(self, token_delta_scale):
        self.__scale = token_delta_scale         
        
    def set_no_time_delay(self, no_time_delay):
        self.__no_time_delay = no_time_delay 
                
    def get_target(self):
        return self.__target
    
    def get_user(self):
        return self.__user  
    
    def get_mint_event(self):
        return self.__mint_event       
    
    def get_time_deltas(self):
        return self.__time_del  
    
    def get_token_deltas(self):
        return self.__token_del 
    
    def set_time_deltas(self, time_deltas):
        self.__time_del = time_deltas
    
    def set_token_deltas(self, token_deltas):
        self.__token_del = token_deltas  
        
    def gen_time_deltas(self, n_events):
        if(self.__time_del == []):
            return TimeDeltaModel(self.__no_time_delay).apply(n_events)
        else:
            return self.__time_del
    
    def gen_token_deltas(self, n_events):
        if(self.__token_del == []):
            return TokenDeltaModel(self.__shape,self.__scale).apply(n_events)
        else:
            return self.__token_del  
       
    def generate_events(self, apy, n_events):
        
        self.__token_del = self.gen_token_deltas(n_events)
        self.__time_del = self.gen_time_deltas(n_events)
        mint_id = self.__mint_event.get_id()
        events = []
        
        for k in range(n_events):
            
            event = Withdraw(apy, self.__token_del[k], self.__time_del[k])
            events.append(WithdrawAction(event, self.__target, self.__user, mint_id))
            
        return events   
    