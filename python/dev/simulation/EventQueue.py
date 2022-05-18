# Last in First out queue

import queue

class EventQueue():
    
    def __init__(self, q = None):
        self.__queue = queue.Queue() if q == None else q
        
    def get_queue(self):
        return self.__queue
       
    def add_event(self, event):
        self.__queue.put(event)

    def add_batch(self, event_batch):
        for k in range(len(event_batch)):
            self.__queue.put(event_batch[k])
            
    def add_batches(self, event_batch1, event_batch2):
        for k in range(len(event_batch1)):
            self.__queue.put(event_batch1[k])  
            self.__queue.put(event_batch2[k])

    def get_event(self):
        return self.__queue.get()  
    
    def n_events(self):
        return self.__queue.qsize()