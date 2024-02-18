# Considerações Gerais

Você deverá usar este repositório como o repo principal do projeto, i.e., todos os seus commits devem estar registrados aqui, pois queremos ver como você trabalha.

A escolha de tecnologias é livre para a resolução do problema. Utilize os componentes e serviços que melhor domina pois a apresentação na entrega do desafio deverá ser como uma aula em que você explica em detalhes cada decisão que tomou.

Registre tudo: testes que foram executados, ideias que gostaria de implementar se tivesse tempo (explique como você as resolveria, se houvesse tempo), decisões que foram tomadas e seus porquês, arquiteturas que foram testadas e os motivos de terem sido modificadas ou abandonadas. Crie um arquivo COMMENTS.md ou HISTORY.md no repositório para registrar essas reflexões e decisões.


# O Problema

O desafio que você deve resolver é a implantação da aplicação de Comentários em versão API (backend) usando ferramentas open source da sua preferência.

Você precisa criar o ambiente de execução desta API com o maior número de passos automatizados possível, inclusive a esteira de deploy.

A aplicação será uma API REST que está disponível neste repositório. Através dela os internautas enviam comentários em texto de uma máteria e acompanham o que outras pessoas estão falando sobre o assunto em destaque. O funcionamento básico da API consiste em uma rota para inserção dos comentários e uma rota para listagem.

Os comandos de interação com a API são os seguintes:

* Start da app

```
cd app
gunicorn --log-level debug api:app
```

* Criando e listando comentários por matéria

```
# matéria 1
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"first post!","content_id":1}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"alice@example.com","comment":"ok, now I am gonna say something more useful","content_id":1}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I agree","content_id":1}'

# matéria 2
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"bob@example.com","comment":"I guess this is a good thing","content_id":2}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"charlie@example.com","comment":"Indeed, dear Bob, I believe so as well","content_id":2}'
curl -sv localhost:8000/api/comment/new -X POST -H 'Content-Type: application/json' -d '{"email":"eve@example.com","comment":"Nah, you both are wrong","content_id":2}'

# listagem matéria 1
curl -sv localhost:8000/api/comment/list/1

# listagem matéria 2
curl -sv localhost:8000/api/comment/list/2
```


# O que será avaliado na sua solução?

* Automação da infra, provisionamento dos hosts (IaaS)

* Automação de setup e configuração dos hosts (IaC)

* Pipeline de deploy automatizado

* Monitoramento dos serviços e métricas da aplicação


# Dicas

Use ferramentas e bibliotecas open source, mas documente as decisões e porquês;

Automatize o máximo possível;

Em caso de dúvidas, pergunte.


## Fluxo CI/CD

# Armazenamento de Imagens Docker e Execução da API

O Google Cloud foi selecionado como provedor de nuvem para armazenar as imagens Docker e hospedar a API.

A API é implantada no Google Cloud Run, uma plataforma serverless para contêineres. Optou-se por esta ferramenta devido à simplicidade da API, que não requer um banco de dados para funcionar, e não exige uma infraestrutura robusta com recursos como ingress, além de escalar de forma saúdavel e dinâmica parecida com o scalling do K8S.

# Ciclo de Build e Implantação

A Build da API é automatizada e a imagem Docker resultante é enviada para o Google Artifact Registry. Esta decisão foi tomada devido à integração nativa do Google Cloud Run com o Artifact Registry. A identificação da versão da imagem Docker é feita através do hash do commit, garantindo rastreabilidade e consistência entre o código e a implantação.

# Gerenciamento da Infraestrutura

A infraestrutura é provisionada e gerenciada utilizando Terraform. O Terraform é responsável por criar e manter os recursos necessários, incluindo a configuração do Cloud Run com a imagem Docker associada ao commit mais recente. O estado da infraestrutura é armazenado de forma segura em um bucket do Google Cloud Storage.

# Monitoramento e Observabilidade

O sistema é monitorado utilizando Grafana, que está integrado com as métricas e logs do Google Cloud Platform. Isso permite o acompanhamento contínuo do desempenho da aplicação, bem como a detecção e resolução proativa de problemas.


## Otimizações e Aperfeiçoamentos Futuros:

Se houvesse mais tempo disponível, algumas melhorias e otimizações poderiam ser implementadas para aprimorar ainda mais a infraestrutura e os processos do projeto.

# Gestão de Ambientes:

Criar diferentes branches para ambientes de desenvolvimento, homologação e produção, juntamente com projetos separados na Cloud. Isso permitiria um gerenciamento mais eficaz e isolado de cada estágio do ciclo de vida da aplicação.

# Melhorias no Processo de Implantação Contínua (CD) com ArgoCD:

Introduzir o ArgoCD para automatizar e gerenciar o processo de implantação contínua. O ArgoCD é uma ferramenta de entrega contínua que opera no Kubernetes, permitindo a implantação de aplicações de forma declarativa a partir de definições de configuração gitops. Integrando o ArgoCD à pipeline de CI/CD, podemos alcançar uma implantação mais consistente, controlada e segura, garantindo que as atualizações sejam entregues de maneira confiável e automatizada.

# Versionamento Semântico:

Implementar o Semantic Versioning para um controle mais preciso das atualizações da aplicação. Isso proporcionaria uma melhor compreensão das mudanças introduzidas em cada versão e facilitaria o processo de release management.

# Banco de Dados:

Provisionar um banco de dados para armazenar os dados do Grafana e preparar para futuras necessidades de persistência de dados da API. Isso garantiria uma base sólida para escalabilidade e expansão futuras do sistema.

# Personalização de Dashboards:

Desenvolver dashboards personalizados no Grafana em vez de depender exclusivamente de modelos pré-definidos. Isso permitiria uma visualização mais específica e adaptada às necessidades do projeto, proporcionando insights mais relevantes. Além disso, configurar o Grafana para enviar alertas por e-mail e aplicativos de mensagens, como Slack ou Microsoft Teams. Essa funcionalidade garantiria uma resposta rápida a incidentes ou anomalias identificadas nas métricas monitoradas, permitindo uma abordagem proativa na resolução de problemas e na manutenção da integridade do sistema.

# Pipeline de CI/CD Aprimorada:

Refinar a pipeline de integração contínua e implantação contínua (CI/CD) para separar claramente as etapas de build e deploy. Isso aumentaria a flexibilidade e a confiabilidade do processo de entrega de software.

# Gerenciamento de Acesso e Segurança:

Implementar roles customizadas na pipeline para garantir uma autenticação e autorização adequadas durante o processo de build de contêineres e na interação com serviços na nuvem. Isso fortaleceria a segurança e o controle de acesso ao ambiente de desenvolvimento e implantação.
