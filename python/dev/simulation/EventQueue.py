# Last in First out queue

import queue

class EventQueue():
    
    def __init__(self, q = None):
        self.__queue = queue.Queue() if q == None else q
        
    def get_queue(self):
        return self.__queue
        
    def add_event(self, event):
        self.__queue.put(event)
        
    def get_event(self, event):
        return self.__queue.get()  
    
    def n_events()
        return self.__queue.qsize()