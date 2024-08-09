import os
import shutil

google = os.path.join(os.getenv('LOCALAPPDATA'), 'Google')

if os.path.isdir(google):
    shutil.rmtree(google)
    print('Google Chrome resetado com sucesso.')

