#INCLUDE "Protheus.CH"
#INCLUDE 'FWMVCDEF.CH' 
#INCLUDE 'TOPCONN.CH'


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RPMSA13_MVC�Autor  �   Andre Ramon     � Data �  23/10/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Cadastro de Tarefas.			                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Administrativo                                             ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function RPMSA14_MVC()
Local cAlias := "ZC0"
Local oBrowse
Local cFiltro
Private cCadastro := "OS x Tarefas"
Private aRotina := MenuDef()

oBrowse:= FWmBrowse():New()
oBrowse:SetAlias(cAlias)
oBrowse:SetDescription(cCadastro)

oBrowse:Activate()

Return 


Static Function MenuDef() 
Local aRotina := {} 
 
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.RPMSA14_MVC' OPERATION 2 ACCESS 0 
ADD OPTION aRotina Title 'Incluir' Action 'VIEWDEF.RPMSA14_MVC' OPERATION 3 ACCESS 0 
ADD OPTION aRotina Title 'Alterar' Action 'VIEWDEF.RPMSA14_MVC' OPERATION 4 ACCESS 0 
ADD OPTION aRotina Title 'Excluir' Action 'VIEWDEF.RPMSA14_MVC' OPERATION 5 ACCESS 0 
ADD OPTION aRotina Title 'Imprimir' Action 'VIEWDEF.RPMSA14_MVC' OPERATION 8 ACCESS 0 
//ADD OPTION aRotina Title 'Copiar' Action 'VIEWDEF.COMP021_MVC' OPERATION 9 ACCESS 0 
 
Return aRotina



Static Function ModelDef() 

// Cria a estrutura a ser usada no Modelo de Dados 
Local oStruZA0 := FWFormStruct( 1, 'ZC0' ) 
Local oModel // Modelo de dados que ser� constru�do 
 
// Cria o objeto do Modelo de Dados 
oModel := MPFormModel():New('RPMSA14M',,/*{ |oModel| RPMSA09POS( oModel ) }*/  )
//oModel := MPFormModel():New('RPMSA09M') 
//oModel:SetVldActivate( { |oModel| RPMSA09POS( oModel ) } )

 
// Adiciona ao modelo um componente de formul�rio 
oModel:AddFields( 'ZC0MASTER', /*cOwner*/, oStruZA0) 

oModel:SetPrimaryKey( { "ZC0_FILIAL", "ZC0_CODOS", "ZC0_CODTAREF"} )  
// Adiciona a descri��o do Modelo de Dados 
oModel:SetDescription( 'OS x Tarefas' ) 
 
// Adiciona a descri��o do Componente do Modelo de Dados 
oModel:GetModel( 'ZC0MASTER' ):SetDescription( 'OS x Tarefas' ) 
 
// Retorna o Modelo de dados 
Return oModel    


Static Function ViewDef() 
// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado 
Local oModel := FWLoadModel( 'RPMSA14_MVC' ) 
 
// Cria a estrutura a ser usada na View 
Local oStruZC0 := FWFormStruct( 2, 'ZC0' ) 
 
// Interface de visualiza��o constru�da 
Local oView 
// Cria o objeto de View 
oView := FWFormView():New() 
 
// Define qual o Modelo de dados ser� utilizado na View 
oView:SetModel( oModel ) 
// Adiciona no nosso View um controle do tipo formul�rio 
// (antiga Enchoice) 
oView:AddField( 'VIEW_ZC0', oStruZC0, 'ZC0MASTER' ) 
 
// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox( 'TELA' , 100 ) 
 
// Relaciona o identificador (ID) da View com o "box" para exibi��o 
oView:SetOwnerView( 'VIEW_ZC0', 'TELA' ) 
 
// Retorna o objeto de View criado 
Return oView