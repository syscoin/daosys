from python.dev.simulation import SimulationOrchestrator
from python.dev.simulation import EventQueue

class EventExecutor():
    
    def __init__(self, queue, orchestrator, verbose = False):
        self.__queue = queue
        self.__orchestrator = orchestrator

    def run(self):
        
        process_queue = True
        if(self.__orchestrator.get_verbose()): self.__print_out()

        while(process_queue):
            event = self.__queue.get_event()
            event_complete = self.__orchestrator.apply(event)          
            process_queue = self.__queue.get_n_events() != 0 and event_complete
            
    def __print_out(self): 
        print('======== Action Tasks ===========')
        print('# num_tasks: {} \n'.format(self.__queue.get_n_events()))          
        
        