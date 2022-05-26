from python.dev.math.model import TimeDeltaModel
from python.dev.math.model import TokenDeltaModel
from python.dev.simulation.batch import Batch
from python.dev.event import Deposit
from python.dev.action import DepositAction
from python.dev.event import Withdraw
from python.dev.action import WithdrawAction
from python.dev.action import SwapAction

class SwapBatch(Batch):
    
    def __init__(self, deposit_batch, withdraw_batch):
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
        w_mint_id = self.__withdraw_batch.get_mint_event().get_id()
        d_mint_id = self.__deposit_batch.get_mint_event().get_id()
        w_target = self.__withdraw_batch.get_target()
        d_target = self.__deposit_batch.get_target()
        w_user = self.__withdraw_batch.get_user()
        d_user = self.__deposit_batch.get_user()        
        
        events = []
        
        for k in range(n_events):
            d_event = Deposit(apy, self.__token_del[k], self.__time_del[k])
            deposit_action = DepositAction(d_event, d_target, d_user, d_mint_id)
            w_event = Withdraw(apy, self.__token_del[k], self.__time_del[k])
            withdraw_action = WithdrawAction(w_event, w_target, w_user, w_mint_id)            
            events.append(SwapAction(withdraw_action,deposit_action))
            
        return events   
    