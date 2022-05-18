# Last in First out queue

import queue

class EventQueue():
    
    def __init__(self, q = None):
        self.__queue = queue.Queue() if q == None else q
        
    def get_queue(self):
        return self.__queue
       
    def add_event(self, event):
        self.__queue.put(event)

    def add_events(self, event_arr):
        for k in range(len(event_arr)):
            self.__queue.put(event_arr[k])
            
    def add_successive_events(self, event_arr1, event_arr2):
        for k in range(len(event_arr1)):
            self.__queue.put(event_arr1[k])  
            self.__queue.put(event_arr2[k])

    def get_event(self):
        return self.__queue.get()  
    
    def n_events(self):
        return self.__queue.qsize()