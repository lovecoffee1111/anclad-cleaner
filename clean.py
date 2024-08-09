import os
import shutil

temp_sistema = os.path.join('C:', os.sep, 'Windows', 'Temp')

temp_usuario = os.path.join(os.getenv('LOCALAPPDATA'), 'Temp')

prefetch_path = os.path.join('C:', os.sep, 'Windows', 'Prefetch')

caminhos = [temp_sistema, temp_usuario, prefetch_path]

for caminho in caminhos:
    arquivos = os.listdir(caminho)
    for arquivo in arquivos:
        nome_completo = os.path.join(caminho, arquivo)
        try:
            tamanho = os.path.getsize(nome_completo) / 1000000
            if os.path.isfile(nome_completo):
                os.remove(nome_completo)
                print('Arquivo removido com sucesso: ', nome_completo)
            elif os.path.isdir(nome_completo):
                shutil.rmtree(nome_completo)
                print('Pasta excluída com sucesso: ', nome_completo)
                
        except Exception as e:
            print(f'Não foi possível remover o arquivo {nome_completo}: {e}')

def run_disk_cleanup():
    os.system(f"cleanmgr /d C:")

if __name__ == "__main__":
    run_disk_cleanup()


 
        



