from python.dev.event.state.series.map import MapStateSeries
from python.dev.event.state.series import StateSeries
from python.dev.event.state import State
from python.dev.token.clock import TokenClock
from python.dev.token import RebaseToken
from python.dev.event import Deposit
from python.dev.event import Rebase

class LPRebaseToken(RebaseToken):
    
    
    def __init__(self, name, time0 = None):
        super().__init__(name, None, None)