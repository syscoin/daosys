from python.dev.simulation import SimulationOrchestrator
from python.dev.simulation import EventQueue

class EventExecutor():
    
    def __init__(self, queue, orchestrator):
        self.__queue = queue
        self.__orchestrator = orchestrator

    def run(self):
        
        process_queue = True
        
        while(process_queue):
            n = self.__queue.n_events()
            event = self.__queue.get_event()
            event_complete = self.__orchestrator.apply(event)          
            process_queue = self.__queue.n_events() != 0 and event_complete
        
        return True
        
        