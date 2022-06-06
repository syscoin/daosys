import os

class Helper():
    
    def chg_dir(self, from_dir_frag, to_dir_frag):
        cwd = os.getcwd().replace(from_dir_frag,to_dir_frag)  
        os.chdir(cwd)