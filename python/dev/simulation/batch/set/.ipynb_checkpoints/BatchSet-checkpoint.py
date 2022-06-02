from python.dev.math.model import TimeDeltaModel


class BatchSet():
    
    def __init__(self, name, verbose = False):
        self.__name = name
        self.__batches = {}
        self.__batch_actions = []
        self.__verbose = verbose
        
    def add_batch(self, batch, name = None):
        batch_name = batch.gen_name() if name == None else name
        self.__batch_actions.append(batch_name)
        self.__batches[batch_name] = batch
        
    def generate_events(self, apy, n_events):

        events = []   
        for k in range(n_events):
            for batch_name in self.__batches:
                event = self.__batches[batch_name].generate_event(apy, k)
                events.append(event)
                
        self.print_out(n_events) 
        return events
    
    def print_out(self, n_events, verbose = None):
        
        verbose = self.__verbose if verbose == None else verbose
        if(verbose):
            print('======== Action Set ===========')
            print('# name: {}'.format(self.__name))
            print('# num_repeats: {} \n'.format(n_events))
            c = 0
            for action in self.__batch_actions:
                c+=1
                print('[task {}] {}'.format(c, action) )
            print('')
