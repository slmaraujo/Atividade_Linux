# Atividade_Linux: Instalação e Configuração no Linux

### Configuração do NFS no Servidor

Para começar, utilizamos o comando "sudo su" para elevar nossos privilégios administrativos.

#### Instalação e Configuração do NFS

- **Instalação do NFS Server**:
  ```sh
  yum update -y
  yum install -y nfs-utils
  ```

- **Criação do Diretório NFS**:
  ```sh
  mkdir -p /mnt/nfs
  ```

- **Montagem do NFS**:
  ```sh
  mount -t nfs nfs-server-ip:/path/to/nfs /mnt/nfs
  ```

- **Adição da Montagem ao fstab**:
  ```sh
  echo "nfs-server-ip:/path/to/nfs /mnt/nfs nfs defaults 0 0" | sudo tee -a /etc/fstab
  ```

- **Criação do Diretório no NFS**:
  ```sh
  mkdir /mnt/nfs/ste
  ```

### Instalação e Configuração do Apache

- **Instalação do Apache**:
  ```sh
  yum install -y httpd
  ```

- **Inicialização e Habilitação do Apache**:
  ```sh
  systemctl start httpd
  systemctl enable httpd
  ```

### Criação do Script de Validação do Serviço

- **Criação e Configuração do Script**:
  ```sh
  nano /usr/local/bin/validacao_servico.sh
  ```

  ```sh
  #!/bin/bash

  SERVICE="httpd"
  STATUS=$(systemctl is-active $SERVICE)
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  MESSAGE=""

  if [ "$STATUS" = "active" ]; then
    MESSAGE="ONLINE"
    echo "$TIMESTAMP - $SERVICE - $STATUS - $MESSAGE" >> /srv/bin/seu-nome/service_online.log
  else
    MESSAGE="OFFLINE"
    echo "$TIMESTAMP - $SERVICE - $STATUS - $MESSAGE" >> /mnt/nfs/seu-nome/service_offline.log
  fi
  ```

- **Tornando o Script Executável**:
  ```sh
  chmod +x /usr/local/bin/validacao_servico.sh
  ```

### Configuração Automática do Script

- **Edição do Crontab para Execução Automatizada**:
  ```sh
  crontab -e
  ```

  Adicione a seguinte linha:
  ```sh
  */5 * * * * /usr/local/bin/validacao_servico.sh
  ```

### Teste e Verificação da Configuração

- **Testando a Configuração Manualmente**:
  ```sh
  /usr/local/bin/validacao_servico.sh
  ```

- **Verificando os Logs Gerados**:
  ```sh
  cat /mnt/nfs/seu-nome/service_online.log
  cat /mnt/nfs/seu-nome/service_offline.log
  ```

- **Confirmando a Configuração do Crontab**:
  ```sh
  crontab -l
  ```

Por fim, foi possível concluir que, realizamos a configuração do NFS, criamos diretórios, instalamos e configuramos o Apache, criamos um script de validação de serviço e configuramos sua execução automatizada a cada 5 minutos.
