from datetime import datetime
from python.dev.event.state.series import Series

class StateSeries(Series):   
    def __init__(self, states = None):
        super().__init__(states)
    
    def get_principle(self):
        N = super().get_num_states()
        states = super().get_states()
        return [states[k].get_principle() for k in range(N)]
    
    def get_balance(self):
        N = super().get_num_states()
        states = super().get_states()
        return [states[k].get_balance() for k in range(N)]
    
    def get_yield(self):
        N = super().get_num_states()
        states = super().get_states()
        return [states[k].get_yield() for k in range(N)]    

    def get_ustamp(self):
        N = super().get_num_states()
        states = super().get_states()
        return [states[k].get_timestamp() for k in range(N)]
    
    def get_tstamp(self):
        N = super().get_num_states()
        ustamp = self.get_ustamp()
        return [datetime.fromtimestamp(t) for t in ustamp]
