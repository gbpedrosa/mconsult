#INCLUDE "Protheus.CH"
#INCLUDE 'FWMVCDEF.CH' 
#INCLUDE 'TOPCONN.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRPMSA12_MVC    บAutor  ณDikson Hebert     บ Data ณ  08/04/15บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cadastro de Contrato de Servi็o                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Administrativo                                             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function RPMSA12_MVC()
Local cAlias := "ZAB"
Local oBrowse
Local cFiltro
Private cCadastro := "Cadastro de Contrato de Servi็o"
Private aRotina := MenuDef()

oBrowse:= FWmBrowse():New()
oBrowse:SetAlias(cAlias)
oBrowse:SetDescription(cCadastro)
//oBrowse:SetFilterDefault(cFiltro)

//oBrowse:AddLegend( "ZAB_STATUS == '0'", "BR_BRANCO"	 ,"Agendada"  )
//oBrowse:AddLegend( "ZAB_STATUS == '1'", "BR_VERDE"	 , "Lancada"  )
//oBrowse:AddLegend( "ZAB_STATUS == '2'" ,"BR_VERMELHO","Fechada"  )
//oBrowse:AddLegend( "ZAB_STATUS == '3'", "BR_PRETO"	 , "Cancelada"  )

oBrowse:Activate()

Return 


Static Function MenuDef() 
Local aRotina := {} 
 
ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 2 ACCESS 0 
ADD OPTION aRotina Title 'Incluir' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 3 ACCESS 0 
ADD OPTION aRotina Title 'Alterar' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 4 ACCESS 0 
ADD OPTION aRotina Title 'Excluir' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 5 ACCESS 0 
ADD OPTION aRotina Title 'Imprimir' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 8 ACCESS 0 
ADD OPTION aRotina Title 'Copiar' Action 'VIEWDEF.RPMSA12_MVC' OPERATION 9 ACCESS 0 
 
Return aRotina

Static Function ModelDef() 
// Cria a estrutura a ser usada no Modelo de Dados 
Local oStruZAB := FWFormStruct( 1, 'ZAB' ) 
Local oModel // Modelo de dados que serแ construํdo 
 
// Cria o objeto do Modelo de Dados 
oModel := MPFormModel():New('RPMSA12M')

// Adiciona ao modelo um componente de formulแrio 
oModel:AddFields( 'ZABMASTER', /*cOwner*/, oStruZAB) 

oModel:SetPrimaryKey( { "ZAB_FILIAL", "ZAB_COD" } )  
// Adiciona a descri็ใo do Modelo de Dados 
oModel:SetDescription( 'Contrato de Servi็os' ) 
 
// Adiciona a descri็ใo do Componente do Modelo de Dados 
oModel:GetModel( 'ZABMASTER' ):SetDescription( 'Contrato de Servi็os' ) 
 
// Retorna o Modelo de dados 
Return oModel    


Static Function ViewDef() 
// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado 
Local oModel := FWLoadModel( 'RPMSA12_MVC' ) 
 
// Cria a estrutura a ser usada na View 
Local oStruZAB := FWFormStruct( 2, 'ZAB' ) 
 
// Interface de visualiza็ใo construํda 
Local oView 
// Cria o objeto de View 
oView := FWFormView():New() 
 
// Define qual o Modelo de dados serแ utilizado na View 
oView:SetModel( oModel ) 
// Adiciona no nosso View um controle do tipo formulแrio 
// (antiga Enchoice) 
oView:AddField( 'VIEW_ZAB', oStruZAB, 'ZABMASTER' ) 
 
// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox( 'TELA' , 100 ) 
 
// Relaciona o identificador (ID) da View com o "box" para exibi็ใo 
oView:SetOwnerView( 'VIEW_ZAB', 'TELA' ) 
 
// Retorna o objeto de View criado 
Return oView