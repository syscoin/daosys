from python.dev.simulation import SimulationOrchestrator
from python.dev.simulation import EventQueue

class EventExecutor():
    
    def __init__(self, queue, orchestrator):
        self.__queue = queue
        self.__orchestrator = orchestrator

    def __pre_config_queue(self):
        if(not self.__queue.is_post_configure()):
            self.__queue.post_configure()
        
    def run(self):
        
        process_queue = True
        self.__pre_config_queue()
        
        while(process_queue):
            event = self.__queue.get_event()
            event_complete = self.__orchestrator.apply(event)          
            process_queue = self.__queue.get_n_events() != 0 and event_complete
        
        