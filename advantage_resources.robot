*** Settings ***
Library    SeleniumLibrary
Library    DatabaseLibrary
Library    Screenshot

*** Variables ***
${URL_ADVANTAGE}                     https://advantageonlineshopping.com
${SPECIAL_OFFER}                     css=.nav-li-Links:nth-child(7) > .menu
${SEE_OFFER}                         xpath=//button[@id='see_offer_btn']
${SETANDO_COR_INFORMADA_BD}          Query    SELECT COLOR FROM massas
${ADD_TO_CART}                       //*[@id="productProperties"]/div[4]/button
${CAMPO_SEARCH}                      css=#autoComplete
${ENTRADA_SEARCH}                    HP PAVILION 15Z TOUCH LAPTOP
${BOTAO_SEARCH}                      css=a > #menuSearch
${VIEW_ALL}                          xpath=//a[contains(text(),'View All')]
${FECHAR_SEARCH}                     xpath=//div[@id='search']/div/div/img
${SELECIONAR_PRODUTO_BD}             xpath=//article[@id='searchPage']/div[3]/div/div/div[2]/ul/li/img
${ENTRADA_QTD_PRODUTOS}              //*[@id="productProperties"]/div[2]/e-sec-plus-minus/div/div[2]/input
${PC_AZUL}                           //*[@id="bunny"]
${ADD_CART}                          xpath=//button[@name='save_to_cart']
${BTN_CHECKOUT}                      xpath=//button[@id='checkOutPopUp']
${CARRINHO_COMPAS}                   css=#menuCart
${BTN_REMOVER_CARRINHO}              xpath=//tr[@id='product']/td[3]/div/div

*** Keywords ***
DADO que estou na página inicial do site https://advantageonlineshopping.com
    SeleniumLibrary.Open Browser    browser=chrome
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Go To           ${URL_ADVANTAGE}

QUANDO clico na opção "Special Offer" no menu
    BuiltIn.Sleep    10s
    SeleniumLibrary.Wait Until Element Is Visible    ${SPECIAL_OFFER}
    SeleniumLibrary.Click Link    ${SPECIAL_OFFER}
    
E clico no botão "See offer"
    SeleniumLibrary.Wait Until Element Is Visible    ${SEE_OFFER}
    BuiltIn.Sleep    5s
    SeleniumLibrary.Click Button    ${SEE_OFFER}
    BuiltIn.Sleep    10s
    SeleniumLibrary.Execute JavaScript    window.scrollTo(0,0);
    BuiltIn.Sleep    5s
    # ${NOME_PRODUTO}    SeleniumLibrary.Get Text    //*[@id="Description"]/h1
    # ${COR_PRODUTO}    SeleniumLibrary.Get Text    //*[@id="grey"]

E altero a cor do produto para a cor informada no banco de automação
    SeleniumLibrary.Wait Until Element Is Visible    ${SETANDO_COR_INFORMADA_BD}
    SeleniumLibrary.Click Button    ${SETANDO_COR_INFORMADA_BD} 

E clico no botão "Add to cart"
    SeleniumLibrary.Wait Until Element Is Visible    ${ADD_TO_CART}
    BuiltIn.Sleep    10s
    SeleniumLibrary.Click Button   ${ADD_TO_CART}

QUANDO clico na opção "Search" e digito o nome do produto do banco de automação
    SeleniumLibrary.Wait Until Element Is Visible    ${BOTAO_SEARCH}
    SeleniumLibrary.Click Element    ${BOTAO_SEARCH}
    SeleniumLibrary.Wait Until Element Is Visible    ${CAMPO_SEARCH}
    SeleniumLibrary.Input Text    ${CAMPO_SEARCH}    ${ENTRADA_SEARCH}

E clico no ícone de busca
    SeleniumLibrary.Wait Until Element Is Visible    ${BOTAO_SEARCH}
    SeleniumLibrary.Click Element    ${BOTAO_SEARCH}
    BuiltIn.Sleep    7S
    SeleniumLibrary.Wait Until Element Is Visible    ${VIEW_ALL}
    SeleniumLibrary.Click Element   ${VIEW_ALL}
    SeleniumLibrary.Wait Until Element Is Visible    ${FECHAR_SEARCH}
    SeleniumLibrary.Click Element   ${FECHAR_SEARCH}
    BuiltIn.Sleep    3S

E seleciono o produto pesquisado
    SeleniumLibrary.Wait Until Element Is Visible    ${SELECIONAR_PRODUTO_BD}
    SeleniumLibrary.Click Element    ${SELECIONAR_PRODUTO_BD}
    BuiltIn.Sleep    3S

E altero a cor do produto para uma diferente da existente no banco de automação
    SeleniumLibrary.Wait Until Element Is Visible    ${PC_AZUL}
    SeleniumLibrary.Click Element    ${PC_AZUL}

E altero a quantidade de produtos que desejo comprar
    SeleniumLibrary.Press Keys    ${ENTRADA_QTD_PRODUTOS}    CTRL+A    5
    BuiltIn.Sleep    2s

E acesso a página de checkout
    SeleniumLibrary.Wait Until Element Is Visible    ${BTN_CHECKOUT}    
    SeleniumLibrary.Click Element    ${BTN_CHECKOUT}

E clico no ícone do carrinho de compras
    SeleniumLibrary.Wait Until Element Is Visible    ${CARRINHO_COMPAS}
    SeleniumLibrary.Click Element    ${CARRINHO_COMPAS}

E removo o produto do carrinho
    #SeleniumLibrary.Wait Until Element Is Visible    ${BTN_REMOVER_CARRINHO}
    #SeleniumLibrary.Click Element    ${CARRINHO_COMPAS}
    SeleniumLibrary.Wait Until Element Is Visible    //*[@id="menuCart"]
    SeleniumLibrary.Click Element    //*[@id="menuCart"]
    SeleniumLibrary.Wait Until Element Is Visible    xpath=//tr[@id='product']/td[3]/div/div
    SeleniumLibrary.Click Element    xpath=//tr[@id='product']/td[3]/div/div
    BuiltIn.Sleep    5s

ENTÃO o carrinho de compras deve estar vazio
    BuiltIn.Sleep    5s
    SeleniumLibrary.Element Should Contain    //*[@id="shoppingCart"]/div/label    Your shopping cart is empty    

ENTÃO as especificações do produto são exibidas corretamente de acordo com as informações retornadas do banco de automação
    DatabaseLibrary.Connect To Database    banco_teste_automacao    alias=default
    
    ${NOME_PRODUTO_SQL}            Query    SELECT NAME_PRODUCT FROM massas
    ${CUSTOMIZACAO_PRODUTO_SQL}    Query    SELECT CUSTOMIZATION FROM massas
    ${TOUCHSCREEN_PRODUTO_SQL}     Query    SELECT TOUCHSCREEN FROM massas
    ${COR_PRODUTO_SQL}             Query    SELECT COLOR FROM massas

    BuiltIn.Log    ${NOME_PRODUTO_SQL}
    BuiltIn.Log    ${COR_PRODUTO_SQL}

    DADO que estou na página inicial do site https://advantageonlineshopping.com
    QUANDO clico na opção "Special Offer" no menu
    E clico no botão "See offer"
    ${NOME_PRODUTO}    SeleniumLibrary.Get Text    //*[@id="Description"]/h1
    ${COR_PRODUTO}    SeleniumLibrary.Get Text    //*[@id="grey"]
    
    BuiltIn.Should Be Equal    ${NOME_PRODUTO}    ${NOME_PRODUTO_SQL}
    BuiltIn.Should Be Equal    ${COR_PRODUTO}    ${COR_PRODUTO_SQL}


ENTÃO o produto é adicionado ao carrinho com a cor selecionada.
    SeleniumLibrary.Wait Until Element Is Visible    ${CARRINHO_COMPAS}
    SeleniumLibrary.Click Element    ${CARRINHO_COMPAS}

ENTÃO valido que a soma dos preços corresponde ao total apresentado na página de checkout
    Sleep    1s

E realizo um update no banco de automação alterando a cor existente no banco para a cor selecionada no teste
    ${result}    Query    UPDATE massas SET COR='${PC_AZUL}' WHERE NAME_PRODUCT='HP PAVILION 15Z TOUCH LAPTOP'
