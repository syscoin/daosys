from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Deposit
from python.dev.action import DepositAction
from python.dev.event import Withdraw
from python.dev.action import WithdrawAction
from python.dev.action import SwapAction
from python.dev.math.basic import IDGenerator

class SwapBatch(Batch):
    
    def __init__(self, withdraw_batch, deposit_batch):
        self.__deposit_batch = deposit_batch
        self.__withdraw_batch = withdraw_batch
        self.__user = deposit_batch.get_user()
        self.__target = deposit_batch.get_target()
        self.__shape = 1
        self.__scale = 100
        self.__no_time_delay = False        
        self.__token_del = []  
        self.__time_del = []          
        
    def set_no_time_delay(self, no_time_delay):
        self.__no_time_delay = no_time_delay         

    def get_target(self):
        return self.__target
    
    def get_user(self):
        return self.__user
    
    def get_time_deltas(self):
        return self.__time_del  
    
    def get_token_deltas(self):
        return self.__token_del
    
    def get_batch_type(self):
        return Batch.BATCH_SWAP     
    
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
        
        w_mint_id = self.__withdraw_batch.get_mint_event().get_id()
        d_mint_id = self.__deposit_batch.get_mint_event().get_id()
        w_target = self.__withdraw_batch.get_target()
        d_target = self.__deposit_batch.get_target()
        w_user = self.__withdraw_batch.get_user()
        d_user = self.__deposit_batch.get_user()   
        
        w_event = Withdraw(apy, token_delta, time_delta)
        withdraw_action = WithdrawAction(w_event, w_target, w_user, w_mint_id)
     
        d_event = Deposit(apy, token_delta, time_delta)
        deposit_action = DepositAction(d_event, d_target, d_user, d_mint_id)
            
        return SwapAction(withdraw_action,deposit_action) 
        

    