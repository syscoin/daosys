# Last in First out queue

import queue

class EventQueue():
    
    def __init__(self, alternate_batches = False, q = None):
        self.__queue = queue.Queue() if q == None else q
        self.__event_batches = {}
        self.__alternate_batches = alternate_batches
        self.__batches_configured = False
        
    def get_queue(self):
        return self.__queue
    
    def get_event(self):
        return self.__queue.get() 
    
    def get_n_events(self):
        return self.__queue.qsize()    
   
    def get_event_batches(self):
        return self.__event_batches 
    
    def is_post_configure(self):
        res = self.__batches_configured or len(self.__event_batches) == 0
        return res     

    def add_event(self, event):
        self.__queue.put(event)
  
    def add_event_batch(self, event_batch):          
        batch_index = len(self.__event_batches)
        self.__event_batches[batch_index] = event_batch

    def post_configure(self):
        self.__batches_configured = True
        
        if(self.__alternate_batches):
            self.__pop_alternate_batches()  
        else:  
            self.__pop_non_alternate_batches()            
        
    def __pop_alternate_batches(self):
        n_events_batch = len(self.__event_batches[1])
        n_batches = len(self.__event_batches)
        for k in range(n_events_batch):
            for m in range(n_batches):
                batch = self.__event_batches[m]
                self.__queue.put(batch[k]) 
                    
    def __pop_nonalternate_batches(self):
        n_events_batch = len(self.__event_batches[0])
        n_batches = len(self.__event_batches)
            
        for m in range(n_batches):
            batch = self.__event_batches[m]
            n_events_batch = len(batch)
            for k in range(n_events_batch):
                self.__queue.put(batch[k])                     

            


