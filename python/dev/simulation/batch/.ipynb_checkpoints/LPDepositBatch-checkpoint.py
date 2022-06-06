from python.dev.simulation.batch import DepositBatch
from python.dev.event import Deposit
from python.dev.action import LPDepositAction

class LPDepositBatch(DepositBatch):
    
    def __init__(self, target, user, mint_event):
        super().__init__(target, user, mint_event)
             
    def generate_event(self, apy, n):

        time_delta = self.gen_time_delta(n)
        mint_id = super().get_mint_event().get_id() 
        target = super().get_target()
        user = super().get_user()
        event = Deposit(apy, 0, time_delta)
            
        return LPDepositAction(event, target, user, mint_id) 

    