from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Withdraw
from python.dev.action import WithdrawAction
from python.dev.math.basic import IDGenerator


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
    
    def get_batch_type(self):
        return Batch.BATCH_WITHDRAW      
    
    def set_time_deltas(self, time_deltas):
        self.__time_del = time_deltas
    
    def set_token_deltas(self, token_deltas):
        self.__token_del = token_deltas  
        
    def gen_name(self):
        random_alphanumeric = IDGenerator().apply(3)
        target_name = self.__target.get_name()
        batch_type =  self.get_batch_type()
        return batch_type + '_' + target_name + random_alphanumeric      
            
    def gen_time_delta(self, index):
        if(self.__time_del == []):
            return TimeDeltaModel(self.__no_time_delay).apply()
        else:
            return self.__time_del[index]         
        
    def gen_token_delta(self, index):
        if(self.__token_del == []):
            return TokenDeltaModel(self.__shape,self.__scale).apply()
        else:
            return self.__token_del[index]          
       
    def generate_event(self, apy, n):
        token_delta = self.gen_token_delta(n)
        time_delta = self.gen_time_delta(n)
        mint_id = self.__mint_event.get_id()     
        event = Withdraw(apy, token_delta, time_delta)
            
        return WithdrawAction(event, self.__target, self.__user, mint_id) 
        
           
    