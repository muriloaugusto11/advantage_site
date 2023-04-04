*** Settings ***
Documentation    Esta suite realiza 4 cenários de testes referentes ao site https://advantageonlineshopping.com

Resource         ./advantage_resources.robot

#Test Setup    DatabaseLibrary.Connect To Database    banco_teste_automacao    alias=default

*** Test Cases ***
Caso de Teste 01 - Validar especificações do produto
    DADO que estou na página inicial do site https://advantageonlineshopping.com
    QUANDO clico na opção "Special Offer" no menu
    E clico no botão "See offer"
    ENTÃO as especificações do produto são exibidas corretamente de acordo com as informações retornadas do banco de automação
    SeleniumLibrary.Close Browser

Caso de Teste 02 - Validar alteração de cor do produto no carrinho
    DADO que estou na página inicial do site https://advantageonlineshopping.com
    QUANDO clico na opção "Special Offer" no menu
    E clico no botão "See offer"
    E altero a cor do produto para a cor informada no banco de automação
    E clico no botão "Add to cart"
    ENTÃO o produto é adicionado ao carrinho com a cor selecionada.
    SeleniumLibrary.Close Browser
        
Caso de Teste 03 - Validar página de checkout
    DADO que estou na página inicial do site https://advantageonlineshopping.com
    QUANDO clico na opção "Search" e digito o nome do produto do banco de automação
    E clico no ícone de busca
    E seleciono o produto pesquisado
    E altero a cor do produto para uma diferente da existente no banco de automação
    E altero a quantidade de produtos que desejo comprar
    E clico no botão "Add to cart"
    E acesso a página de checkout
    ENTÃO valido que a soma dos preços corresponde ao total apresentado na página de checkout
    E realizo um update no banco de automação alterando a cor existente no banco para a cor selecionada no teste
    SeleniumLibrary.Close Browser

Caso de Teste 04 - Remover produto do carrinho de compras
    DADO que estou na página inicial do site https://advantageonlineshopping.com
    QUANDO clico na opção "Special Offer" no menu
    E clico no botão "See offer"
    E clico no botão "Add to cart"
    E clico no ícone do carrinho de compras
    E removo o produto do carrinho
    ENTÃO o carrinho de compras deve estar vazio
    SeleniumLibrary.Close Browser
  
