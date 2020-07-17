# Criando um salt-formula no SUMA: telegraf-exporter

*Documentação disponível em <a href="https://docs.influxdata.com/telegraf/v1.14/">documentação Telegraf</a>*

Esse exemplo utiliza um host conectado no SUSE Manager. A instalação do Prometheus e do Grafana foram feito através do salt, no SUMA. A formula é implementada para ser utilizada com o SUSE Manager para ser aplciado diretamente nos salt-minions através da interface web.

Aplicar passo-a-passo no server SUSE Manager: 

# Passo a passo
1. **Criar diretório**: Para iniciar, criar o diretorio e criar o arquivo de configuração telegraf.conf dentro desse diretório:
```
mkdir /srv/salt/telegraf-exporter
cd /srv/salt/telegraf-exporter
``` 

2. **Definir salt states no arquivo init.sls**: Para criar os passos que serão executados na formula, criar o arquivo ```vim init.sls``` com o conteúdo de <a href="https://github.com/gbrlins/telegraf-exporter-formula/blob/master/init.sls">init.sls</a>
 
3. **Mover arquivo de configuração pre-definido**: Criar diretório chamado *files*  ```mkdir files``` e, dentro dele, criar o arquivo ```vim telegraf.conf``` com o conteúdo de <a href="https://github.com/gbrlins/telegraf-exporter-formula/blob/master/telegraf.conf">telegraf.conf</a>  

4. **Configurar metadata**: Será necessário copiar os três arquivos dentro da pasta arquivos para o diretório abaixo. Para isso, crie um diretório dentro do path *formula_metadata* e, dentro dele, crie os arquivos presentes em <a href="https://github.com/gbrlins/telegraf-exporter-formula/tree/master/arquivos">arquivos</a>
```
cd /srv/formula_metadata
mkdir telegraf-exporter
```

5. **Restartar o SUSE Manager**: ```spacewalk-service restart```

6. **Configurar o arquivo prometheus.yml do host rodando Prometheus**:
```
vim /etc/prometheus/prometheus.yml
systemctl restart prometheus.service
```
