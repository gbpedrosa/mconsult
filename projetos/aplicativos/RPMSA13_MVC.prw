#INCLUDE "Protheus.CH"
#INCLUDE 'FWMVCDEF.CH' 
#INCLUDE 'TOPCONN.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RPMSA13_MVCºAutor  ³   Andre Ramon     º Data ³  23/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cadastro de Tarefas.			                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Administrativo                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function RPMSA13_MVC()
Local cAlias := "ZA0"
Local oBrowse
Local cFiltro
Private cCadastro := "Cadastro de Tarefas"
Private aRotina := MenuDef()
/*
Private aRotina := {{"Pesquisar" ,"AxPesqui"     ,0,1} ,;
					{"Visualizar","AxVisual"     ,0,2} ,;
					{"Incluir"   ,"AxInclui"     ,0,3} ,;
					{"Alterar"   ,"AxAltera"     ,0,4} ,;
					{"Excluir"   ,"AxExclui"     ,0,5} ,;
					{"Confirmar OS"   ,"U_RPMSA02B('2')"     ,0,5} ,;
					{"Legenda"   ,"U_RPMSA02A"   ,0,3} ,;
					{"Imprimir"  ,"U_RPMSR01"   ,0,3}}
*/
//cFiltro :="SC5->C5_YNEGOCI $ '"+cNegocio+"'"

oBrowse:= FWmBrowse():New()
oBrowse:SetAlias(cAlias)
oBrowse:SetDescription(cCadastro)
//oBrowse:SetFilterDefault(cFiltro)

oBrowse:AddLegend( "ZA0_STATUS == '1'", "BR_BRANCO"	 ,"Nao Iniciado"  )
oBrowse:AddLegend( "ZA0_STATUS == '2'", "BR_VERDE"	 , "Iniciado"  )
oBrowse:AddLegend( "ZA0_STATUS == '3'" ,"BR_VERMELHO","Concluido"  )

oBrowse:Activate()

Return 


Static Function MenuDef() 
Local aRotina := {} 
 
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.RPMSA13_MVC' OPERATION 2 ACCESS 0 
ADD OPTION aRotina Title 'Incluir' Action 'VIEWDEF.RPMSA13_MVC' OPERATION 3 ACCESS 0 
ADD OPTION aRotina Title 'Alterar' Action 'VIEWDEF.RPMSA13_MVC' OPERATION 4 ACCESS 0 
ADD OPTION aRotina Title 'Excluir' Action 'VIEWDEF.RPMSA13_MVC' OPERATION 5 ACCESS 0 
ADD OPTION aRotina Title 'Imprimir' Action 'VIEWDEF.RPMSA13_MVC' OPERATION 8 ACCESS 0 
//ADD OPTION aRotina Title 'Copiar' Action 'VIEWDEF.COMP021_MVC' OPERATION 9 ACCESS 0 
 
Return aRotina



Static Function ModelDef() 

// Cria a estrutura a ser usada no Modelo de Dados 
Local oStruZA0 := FWFormStruct( 1, 'ZA0' ) 
Local oModel // Modelo de dados que será construído 
 
// Cria o objeto do Modelo de Dados 
oModel := MPFormModel():New('RPMSA13M',,/*{ |oModel| RPMSA09POS( oModel ) }*/  )
//oModel := MPFormModel():New('RPMSA09M') 
//oModel:SetVldActivate( { |oModel| RPMSA09POS( oModel ) } )

 
// Adiciona ao modelo um componente de formulário 
oModel:AddFields( 'ZA0MASTER', /*cOwner*/, oStruZA0) 

oModel:SetPrimaryKey( { "ZA0_FILIAL", "ZA0_PROJET", "ZA0_ITEM", "ZA0_CLIENT", "ZA0_LOJA", "ZA0_TAREFA" } )  
// Adiciona a descrição do Modelo de Dados 
oModel:SetDescription( 'Cadastro de Tarefas' ) 
 
// Adiciona a descrição do Componente do Modelo de Dados 
oModel:GetModel( 'ZA0MASTER' ):SetDescription( 'Cadastro de Tarefas' ) 
 
// Retorna o Modelo de dados 
Return oModel    


Static Function ViewDef() 
// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado 
Local oModel := FWLoadModel( 'RPMSA13_MVC' ) 
 
// Cria a estrutura a ser usada na View 
Local oStruZA0 := FWFormStruct( 2, 'ZA0' ) 
 
// Interface de visualização construída 
Local oView 
// Cria o objeto de View 
oView := FWFormView():New() 
 
// Define qual o Modelo de dados será utilizado na View 
oView:SetModel( oModel ) 
// Adiciona no nosso View um controle do tipo formulário 
// (antiga Enchoice) 
oView:AddField( 'VIEW_ZA0', oStruZA0, 'ZA0MASTER' ) 
 
// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox( 'TELA' , 100 ) 
 
// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZA0', 'TELA' ) 
 
// Retorna o objeto de View criado 
Return oView

User Function RPMSA13B(cOpcao) //  Legenda
RecLock("ZA0",.F.)
	ZA0->ZA0_STATUS := cOpcao
MsUnlock()
Return Nil