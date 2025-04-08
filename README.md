# Case Fire

Este é um projeto desenvolvido em Flutter que demonstra uma interface para visualizar posts, utilizando Clean Arch, Bloc, Firebase, testes unitários, testes de integração e injeção de dependências.

## Escolhas Técnicas e Justificativas

1.  **Gerenciamento de Estado: BLoC (Business Logic Component)**
    - **Justificativa:** O BLoC é uma arquitetura robusta e escalável para gerenciar o estado em aplicações Flutter complexas. Ele separa a lógica de negócios da camada de apresentação, facilitando a testabilidade, a manutenção e a reutilização do código. O uso de Streams e Sinks no BLoC promove um fluxo de dados unidirecional, tornando o estado da aplicação mais previsível.

2.  **Injeção de Dependências: `get_it`**
    - **Justificativa:** `get_it` é uma biblioteca simples e popular para implementar a injeção de dependências em Flutter. Ela permite desacoplar classes e facilita a criação de mocks para testes, além de simplificar o acesso a instâncias de serviços e repositórios em toda a aplicação.

3.  **Testes de Integração: `flutter_test` e `integration_test`**
    - **Justificativa:** Os testes de integração são cruciais para verificar se diferentes partes da aplicação (widgets, Blocs, serviços) funcionam juntas corretamente. O Flutter oferece as ferramentas `flutter_test` e o pacote `integration_test` para escrever esses tipos de testes, simulando interações reais do usuário e verificando o comportamento da aplicação em um ambiente mais próximo do real.

4.  **Mocks: `mocktail`**
    - **Justificativa:** Para isolar unidades de código durante os testes (unitários e de integração), é essencial usar mocks. `mocktail` é uma biblioteca poderosa para criar mocks com uma sintaxe clara e concisa.

## Instruções de Execução

### Pré-requisitos

- Flutter SDK instalado e configurado no seu ambiente.
- Emulador Android ou Simulador iOS em execução (para testes de integração).

### Executando os Testes

1.  **Navegue até a raiz do projeto:**
    ```bash
    cd case_fire
    ```

2.  **Execute os Testes de Integração:**
    ```bash
    flutter test integration_test/post_page_test.dart
    ```
    Este comando executará os testes localizados no arquivo `post_page_test.dart`, verificando a interação da `PostPage` com seus Blocs e outros componentes, incluindo a simulação do Firebase para testes de autenticação e outros serviços relacionados.

3.  **Execute os Testes unitários:**
    ```bash
    flutter test
    ```
    Este comando executará todos os testes unitários localizados no diretorio `test`.


### Executando a Aplicação

1.  **Navegue até a raiz do projeto:**
    ```bash
    cd case_fire
    ```

2.  **Execute a aplicação em um dispositivo conectado ou emulador/simulador:**
    ```bash
    flutter run
    ``` 


### Credenciais de Login

Utilize as seguintes credenciais para realizar o login na aplicação:

**Usuário:** `tester@casefire.com`
**Senha:** `123456`


## Escalabilidade da Solução

A arquitetura e a separação de responsabilidades implementadas neste projeto facilitam a expansão e a escalabilidade da solução no futuro. Algumas estratégias para isso incluem:

* **Modularização:** Novas funcionalidades podem ser implementadas como módulos independentes (novas pastas dentro de `lib/modules/`), cada um com seus próprios Blocs, modelos e widgets. Isso mantém o código organizado e evita o acoplamento.
* **Reutilização de Componentes:** A arquitetura incentiva a criação de componentes de UI reutilizáveis que podem ser utilizados em diferentes partes da aplicação ou em novas funcionalidades.
* **Separação de Camadas:** A clara separação entre as camadas permite que cada camada seja escalada ou modificada independentemente. Por exemplo, a fonte de dados pode ser alterada (de uma API mockada para uma API real) sem afetar significativamente a lógica dos Blocs ou a interface do usuário.
* **Testabilidade:** A alta testabilidade da arquitetura garante que novas funcionalidades possam ser adicionadas com confiança, com testes unitários e de integração cobrindo a nova lógica e interações.
* **Infraestrutura:** Para escalar a aplicação em termos de infraestrutura (backend), a separação da camada de dados permite a adoção de soluções escaláveis como microsserviços ou bancos de dados distribuídos, sem impactar diretamente o frontend.
* **Otimização de Performance:** Em cenários de alta demanda, Blocs específicos podem ser otimizados para melhor performance, como a implementação de estratégias de caching ou a utilização de Streams de forma eficiente.
* **Novas Plataformas:** O Flutter permite a compilação para diversas plataformas (Web, Desktop, etc.). A arquitetura modular e a separação de responsabilidades facilitam a adaptação da interface do usuário para novas plataformas, mantendo a lógica de negócios centralizada.


## Contato

Em caso de dúvidas, fique a vontade para entrar em contato

**LinkedIn:** `https://www.linkedin.com/in/samuel-arna/`
**WhatsApp:** `11 91565 2168` 
