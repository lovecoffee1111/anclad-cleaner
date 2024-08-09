import subprocess

listaComandos = [
    "ipconfig /flushdns",
    "net stop dnscache",
    "net stop dhcp",
    "net start dhcp",
    "ipconfig /registerdns",
    "ipconfig /renew",
    "arp -a -d",
    "netsh interface ip delete arpcache",
    "netsh interface ip delete destinationcache",
    "nbtstat -R",
    "nbtstat -RR",
    "netsh int ip reset",
    "netsh winsock reset catalog",
    "sfc /purgecache",
    "sfc /cachesize=50"
]

for comando in listaComandos:
    if(comando == "net stop dhcp"):
        processo = subprocess.Popen(f"cmd /c {comando}", shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = processo.communicate(input="S\n")
    else:
        processo = subprocess.run(f"cmd /c {comando}", shell=True, capture_output=True, text=True)
        print(f'Saída do comando "{comando}":\n{processo.stdout}')
        
    if processo.stderr:
        print(f'Erro ao executar o comando "{comando}":\n{processo.stderr}')
