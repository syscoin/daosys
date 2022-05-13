from python.dev.simulation import SimulationOrchestrator
from python.dev.simulation import EventQueue

class EventExecutor():
    
    def __init__(self, queue, orchestrator):
        self.__queue = queue
        self.__orchestrator = orchestrator

    def run(self):
        
        process_queue = True
        
        while(process_queue):
            event = self.__queue.get_event()
            event_complete = self.__orchestrator.apply(event)          
            process_queue = len(self.__queue) != 0 and event_complete
        
        return True
        
        