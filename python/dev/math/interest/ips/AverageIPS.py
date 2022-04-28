from python.dev.math.interest.ips import IPS

class AverageIPS(IPS):
    
    def calc_ips_from_state(self, state):
        delta = state.get_delta()  
        principle = state.get_principle() 
        A0 = principle - delta
        A1 = state.get_balance() - delta
        dt = state.get_event().get_time_delta()
        return self.calc_ips(A0, A1, dt)
    
    def calc_ips(self, a0, a1, dt):
        return (a1/a0)**(1/dt) - 1
        