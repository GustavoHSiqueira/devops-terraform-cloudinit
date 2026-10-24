
# Projeto DevOps — Terraform, Cloud-Init e GitHub Actions

## 1. Objetivo

Este projeto demonstra a criação e configuração automatizada de uma infraestrutura Linux utilizando Terraform, Cloud-Init e GitHub Actions.

A infraestrutura foi implementada localmente no Linux Mint, utilizando o Multipass para provisionar uma máquina virtual Ubuntu Server 24.04 LTS, sem necessidade de contratar serviços de nuvem.

**Tecnologias utilizadas:**
- Terraform — Infraestrutura como Código (IaC)
- Multipass — Virtualização local
- Ubuntu Server 24.04 LTS — Sistema operacional da VM
- Cloud-Init — Configuração automatizada
- Docker — Plataforma de contêineres
- Nginx — Servidor web
- Git e GitHub — Versionamento de código
- GitHub Actions — Integração contínua

## 2. Arquitetura

O projeto utiliza a seguinte arquitetura:

```text
Linux Mint
    |
    | Terraform
    v
Multipass
    |
    v
VM Ubuntu Server 24.04
    |
    | Cloud-Init
    |
    +---- Docker
    |
    +---- Nginx
```

O GitHub Actions realiza verificações automáticas de formatação e validação do código Terraform.

## 3. Estrutura do projeto

```text
devops-local-multipass/
|
|-- .github/
|   |-- workflows/
|       |-- terraform.yml
|
|-- main.tf
|-- variables.tf
|-- versions.tf
|-- outputs.tf
|-- user-data.yaml
|-- .terraform.lock.hcl
|-- .gitignore
|-- README.md
|
|-- evidencias/
    |-- validacao-infraestrutura.txt
```

## 4. Configuração da máquina virtual

A máquina virtual foi criada com os seguintes recursos:

| Recurso | Configuração |
|---|---|
| Nome | devops-lab |
| Sistema operacional | Ubuntu Server 24.04 LTS |
| CPU | 2 vCPUs |
| Memória RAM | 2 GB |
| Disco | 12 GB |
| IP principal no laboratório | 10.97.0.42 |
| Virtualização | Multipass |

O endereço IP é atribuído dinamicamente e pode mudar em outras execuções.

## 5. Provisionamento com Terraform

O Terraform utiliza o provider comunitário `todoroff/multipass` para criar e gerenciar a máquina virtual.

### Inicializar o projeto

```bash
terraform init
```

### Verificar formatação

```bash
terraform fmt -check -recursive
```

### Validar a configuração

```bash
terraform validate
```

### Gerar o plano

```bash
terraform plan -out=tfplan
```

Resultado obtido:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

### Aplicar o plano

```bash
terraform apply "tfplan"
```

Resultado obtido:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

A máquina virtual foi provisionada com sucesso.

## 6. Configuração automatizada com Cloud-Init

O arquivo `user-data.yaml` automatiza a configuração inicial da VM.

As principais operações realizadas são:

- Definir o hostname `devops-lab`.
- Atualizar os índices de pacotes.
- Instalar Docker e Nginx.
- Habilitar e iniciar os serviços.

### Verificação

```bash
multipass exec devops-lab -- cloud-init status --wait
```

Resultado:

```text
status: done
```

Isso confirma que o Cloud-Init concluiu sua execução.

## 7. Validação dos serviços

### Docker

```bash
multipass exec devops-lab -- systemctl is-active docker
```

Resultado:

```text
active
```

### Nginx

```bash
multipass exec devops-lab -- systemctl is-active nginx
```

Resultado:

```text
active
```

### Verificação da VM

```bash
multipass list
```

Resultado:

```text
Name          State      IPv4         Image
devops-lab    Running    10.97.0.42   Ubuntu 24.04 LTS
```

### Teste do servidor web

O Nginx foi acessado pelo navegador no endereço:

http://10.97.0.42

A página padrão "Welcome to nginx!" foi exibida com sucesso.

Esse endereço pertence à rede local do laboratório e não representa um servidor público na internet.

## 8. Pipeline CI/CD — GitHub Actions

O workflow está localizado em:

`.github/workflows/terraform.yml`

Ele é acionado por alterações na branch `main`, pull requests e execução manual.

### Etapas automatizadas

1. Checkout do repositório.
2. Instalação do Terraform.
3. Verificação da formatação com `terraform fmt`.
4. Inicialização com `terraform init -backend=false`.
5. Validação com `terraform validate`.

### Resultado

O workflow **Terraform CI #2** foi executado com sucesso no GitHub Actions.

**Evidência:**

[Visualizar execução da pipeline](https://github.com/GustavoHSiqueira/devops-terraform-cloudinit/actions/runs/4005397600)

### Limitação do ambiente local

O `terraform plan` e o `terraform apply` foram executados manualmente no Linux Mint.

A pipeline hospedada pelo GitHub realiza integração contínua e validação, mas não provisiona a VM local, pois o runner hospedado não possui acesso ao serviço Multipass instalado no computador.

Uma evolução futura seria utilizar um runner próprio isolado, com aprovação manual e permissões restritas, para implementar a etapa de implantação automatizada.

## 9. Evidências

As verificações foram realizadas no ambiente Linux Mint.

| Evidência | Resultado |
|---|---|
| Terraform Plan | 1 recurso planejado |
| Terraform Apply | 1 recurso criado |
| VM Ubuntu | Running |
| Cloud-Init | Done |
| Docker | Active |
| Nginx | Active |
| GitHub Actions | Success |

O arquivo `evidencias/validacao-infraestrutura.txt` contém os resultados dos comandos de validação, quando adicionado ao repositório.

## 10. Segurança

Foram adotadas as seguintes práticas:

- Exclusão de arquivos de estado do Terraform pelo `.gitignore`.
- Exclusão dos arquivos `terraform.tfvars` e `tfplan`.
- Versionamento de `.terraform.lock.hcl`.
- Ausência de credenciais AWS no projeto.
- Infraestrutura executada localmente.
- Pipeline com permissões de leitura.
- Implantação mantida sob controle manual.

## 11. Como encerrar o laboratório

Para interromper a VM e liberar os recursos de CPU e RAM:

```bash
multipass stop devops-lab
```

Para iniciá-la novamente:

```bash
multipass start devops-lab
```

Para destruir a infraestrutura gerenciada pelo Terraform:

```bash
terraform destroy
```

**Atenção:** a destruição remove a VM e os dados armazenados nela. Execute somente quando não precisar mais do laboratório.

## 12. Conclusão

O projeto demonstrou a aplicação prática dos conceitos de Infraestrutura como Código, provisionamento de máquinas virtuais, configuração automatizada de sistemas Linux e integração contínua.

A infraestrutura foi criada com sucesso utilizando Terraform e Multipass. O Cloud-Init instalou e inicializou Docker e Nginx, e as verificações confirmaram que os serviços estavam ativos.

A pipeline GitHub Actions também foi executada com sucesso, validando o código Terraform.

O projeto contribuiu para o desenvolvimento de competências em Linux, automação de infraestrutura, Git, GitHub, Terraform e práticas de DevOps.

---

**Autor:** Gustavo Henrique Silva de Siqueira  
**Projeto:** Atividade prática de DevOps — Terraform, Cloud-Init e GitHub Actions  
**Ambiente:** Linux Mint e Ubuntu Server 24.04 LTS
