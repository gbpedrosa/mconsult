#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "FWMVCDEF.CH" 
#INCLUDE "FWBrowse.CH"
#INCLUDE "Topconn.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  RPMSA10  ºAutor  ³   Andre Ramon     º Data ³  13/10/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Cadastro do Cabecalho e Itens dos Projetos.                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Administrativo                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function RPMSA10()

Local cAlias := "ZA1"
Local oBrowse
Local cFiltro

Private cCadastro := "Cadastro de Projetos"
Private aRotina := Menudef()

oBrowse:= FWmBrowse():New()
oBrowse:SetAlias(cAlias)
oBrowse:SetDescription(cCadastro)
//oBrowse:SetFilterDefault(cFiltro)

U_RPMSA10H()

oBrowse:AddLegend( "ZA1_STATUS == '1'", "BR_VERDE"	 , 	"Projeto Aberto"  )
oBrowse:AddLegend( "ZA1_STATUS == '2'", "BR_VERMELHO" ,	"Projeto Encerrado"  )
oBrowse:AddLegend( "ZA1_STATUS == '3'", "BR_PRETO"	 , 	"Projeto Estourado"  )

oBrowse:Activate()

Return 

//---------------------------------------------------------------------------------------

Static Function MenuDef()
 
Local aRotina := {} 
 
ADD OPTION aRotina Title 'Visualizar' 		Action 'VIEWDEF.RPMSA10_MVC' OPERATION 2 ACCESS 0 
ADD OPTION aRotina Title 'Incluir' 		Action 'VIEWDEF.RPMSA10_MVC' OPERATION 3 ACCESS 0 
ADD OPTION aRotina Title 'Alterar'			Action 'VIEWDEF.RPMSA10_MVC' OPERATION 4 ACCESS 0 
ADD OPTION aRotina Title 'Excluir' 		Action 'VIEWDEF.RPMSA10_MVC' OPERATION 5 ACCESS 0
ADD OPTION aRotina Title 'Enc. Projeto' 	Action 'U_RPMSA10B()'	 	 OPERATION 6 ACCESS 0
//ADD OPTION aRotina TITLE 'Imprimir' 		ACTION 'VIEWDEF.RPMSA10_MVC' OPERATION 8 ACCESS 0
//ADD OPTION aRotina TITLE 'Copiar' 			ACTION 'VIEWDEF.RPMSA10_MVC' OPERATION 9 ACCESS 0  
 
Return aRotina

//---------------------------------------------------------------------------------------

Static Function ModelDef()

// Cria as estruturas a serem usadas no Modelo de Dados
Local oStruZA1 := Nil
Local oStruZA2 := Nil
Local oStruZAA := Nil
Local oModel 	 := Nil // Modelo de dados construído


oStruZA1 := FWFormStruct( 1, 'ZA1' )
oStruZA2 := FWFormStruct( 1, 'ZA2' )
oStruZAA := FWFormStruct( 1, 'ZAA' )

oStruZA2:RemoveField( "ZA2_CLIENT" )
oStruZA2:RemoveField( "ZA2_LOJA" )
oStruZA2:RemoveField( "ZA2_PROJET" )
oStruZAA:RemoveField( "ZAA_CLIENT" )
oStruZAA:RemoveField( "ZAA_LOJA" )
oStruZAA:RemoveField( "ZAA_PROJET" )

// Cria o objeto do Modelo de Dados
oModel := MPFormModel():New( 'RPMSA10_MVC' )//, { | oModel | U_RPMSA10A(oModel) } )

// Adiciona ao modelo um componente de formulário
oModel:AddFields( 'ZA1CABEC', /*cOwner*/, oStruZA1 )

// Adiciona ao modelo uma componente de grid
oModel:AddGrid( 'ZA2ITEM', 'ZA1CABEC', oStruZA2 )

// Adiciona ao modelo uma componente de grid
oModel:AddGrid( 'ZAAITEM', 'ZA1CABEC', oStruZAA )

//Chave Primaria
//oModel: SetPrimaryKey( { "ZA1_FILIAL+ZA1_CODIGO+ZA1_CLIENT+ZA1_LOJA" } )
oModel:SetPrimaryKey( {})

// Faz relacionamento entre os componentes do model
oModel:SetRelation( 'ZA2ITEM', { { 'ZA2_FILIAL', 'xFilial( "ZA2" )' }, { 'ZA2_PROJET', 'ZA1_CODIGO' }, { 'ZA2_CLIENT', 'ZA1_CLIENT' }, { 'ZA2_LOJA', 'ZA1_LOJA' } }, ZA2->( IndexKey( 2 ) ) )

// Faz relacionamento entre os componentes do model
oModel:SetRelation( 'ZAAITEM', { { 'ZAA_FILIAL', 'xFilial( "ZAA" )' }, { 'ZAA_PROJET', 'ZA1_CODIGO' }, { 'ZAA_CLIENT', 'ZA1_CLIENT' }, { 'ZAA_LOJA', 'ZA1_LOJA' } }, ZAA->( IndexKey( 1 ) ) )

// Adiciona a descrição do Modelo de Dados
oModel:SetDescription( 'Cadastro de Projetos/Itens' )

// Adiciona a descrição dos Componentes do Modelo de Dados
oModel:GetModel( 'ZA1CABEC' ):SetDescription( 'Cadastro de Projetos' )

oModel:GetModel( 'ZA2ITEM' ):SetDescription( 'Cadastro dos Itens do Projeto' )

oModel:GetModel( 'ZAAITEM' ):SetDescription( 'Itens Financeiro do Projeto' )

oModel:GetModel( 'ZA2ITEM' ):SetUniqueLine( { 'ZA2_ITEMPR' } )

oModel:GetModel( 'ZAAITEM' ):SetUniqueLine( { 'ZAA_ITEMPR' } )

oModel:GetModel( 'ZAAITEM' ):SetOptional(.T.)
// Retorna o Modelo de dados

oModel:SetVldActivate( { | oModel | U_RPMSA10A(oModel) } )

Return oModel

//---------------------------------------------------------------------------------------

Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef do fonte informado
Local oModel 	:= FWLoadModel( 'RPMSA10_MVC' )
Local oStruZA1 
Local oStruZA2
Local oStruZAA
Local oView
//oModel:Activate()
// Cria as estruturas a serem usadas na View
oStruZA1 := FWFormStruct( 2, 'ZA1' )
oStruZA2 := FWFormStruct( 2, 'ZA2' )
oStruZAA := FWFormStruct( 2, 'ZAA' )

oStruZA2:RemoveField( "ZA2_CLIENT" )
oStruZA2:RemoveField( "ZA2_LOJA" )
oStruZA2:RemoveField( "ZA2_PROJET" )
oStruZAA:RemoveField( "ZAA_CLIENT" )
oStruZAA:RemoveField( "ZAA_LOJA" )
oStruZAA:RemoveField( "ZAA_PROJET" )

// Cria o objeto de View
oView := FWFormView():New()

// Define qual Modelo de dados será utilizado
oView:SetModel( oModel )

// Adiciona no nosso View um controle do tipo formulário (antiga Enchoice)
oView:AddField( 'VIEW_ZA1', oStruZA1, 'ZA1CABEC' )
oView:EnableControlBar(.T.) 

//Adiciona no nosso View um controle do tipo Grid (antiga Getdados)
oView:AddGrid( 'VIEW_ZA2', oStruZA2, 'ZA2ITEM' )

//Adiciona no nosso View um controle do tipo Grid (antiga Getdados)
oView:AddGrid( 'VIEW_ZAA', oStruZAA, 'ZAAITEM' )

oView:AddIncrementField("VIEW_ZA2","ZA2_ITEMPR")

oView:AddIncrementField("VIEW_ZAA","ZAA_ITEMPR")	

// Cria um "box" horizontal para receber cada elemento da view
oView:CreateHorizontalBox( 'SUPERIOR', 40 )
oView:CreateHorizontalBox( 'MEIO', 30 )
oView:CreateHorizontalBox( 'INFERIOR', 30 )

// Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView( 'VIEW_ZA1', 'SUPERIOR' )
oView:SetOwnerView( 'VIEW_ZA2', 'MEIO' )
oView:SetOwnerView( 'VIEW_ZAA', 'INFERIOR' )

oView:EnableTitleView( 'VIEW_ZA1' )
oView:EnableTitleView( 'VIEW_ZA2', "ITENS DO PROJETO" )
oView:EnableTitleView( 'VIEW_ZAA', "ITENS FINANCEIRO DO PROJETO" )

oView:SetUseCursor(.T.)

Return oView

//---------------------------------------------------------------------------------------

//Encerramento do Projeto
User Function RPMSA10B()

Local aArea      	:= GetArea()
Local lRet       	:= .T.
Local cMsg			:= ''
	/*
	cQuery := " SELECT ZAE_CODETA "+CRLF
	cQuery += " FROM "+RetSqlName("ZAE")+" ZAE "+CRLF
	cQuery += " WHERE ZAE.D_E_L_E_T_ = '' "+CRLF
	cQuery += " AND ZAE_PROJET	= '"+ZA1->ZA1_CODIGO+"' "+CRLF
	cQuery += " AND ZAE_CLIENT	= '"+ZA1->ZA1_CLIENT+"' "+CRLF
	cQuery += " AND ZAE_LOJA		= '"+ZA1->ZA1_LOJA+"' "+CRLF
	cQuery += " AND ZAE_DTCONC 	= '' "+CRLF
	
	TcQuery cQuery New Alias T01
	*/
	cQuery := " SELECT ZA2_ITEMPR "+CRLF
	cQuery += " FROM "+RetSqlName("ZA2")+" ZA2 "+CRLF
	cQuery += " WHERE ZA2.D_E_L_E_T_ = '' "+CRLF
	cQuery += " AND ZA2_PROJET	= '"+ZA1->ZA1_CODIGO+"' "+CRLF
	cQuery += " AND ZA2_CLIENT	= '"+ZA1->ZA1_CLIENT+"' "+CRLF
	cQuery += " AND ZA2_LOJA		= '"+ZA1->ZA1_LOJA+"' "+CRLF
	cQuery += " AND ZA2_ENCERR	= '' "+CRLF
	
	TcQuery cQuery New Alias T02
	/*
	cQuery := " SELECT * "+CRLF
	cQuery += " FROM "+RetSqlName("ZAD")+" ZAD "+CRLF
	cQuery += " WHERE ZAD.D_E_L_E_T_ = '' "+CRLF
	cQuery += " AND ZAD_PROJET	= '"+ZA1->ZA1_CODIGO+"' "+CRLF
	cQuery += " AND ZAD_ITEMPJ	= '"+T02->ZA2_ITEMPR+"' "+CRLF
	cQuery += " AND ZAD_CLIENT	= '"+ZA1->ZA1_CLIENT+"' "+CRLF
	cQuery += " AND ZAD_LOJA		= '"+ZA1->ZA1_LOJA+"' "+CRLF
				
	TcQuery cQuery New Alias T03
	*/
	If ZA1->ZA1_STATUS == '2'
		MsgAlert("O projeto encontra-se encerrado, não precisa encerrar novamente.")
		T02->(DbCloseArea())
		lRet := .F.
	ElseIf ApMsgYesNo("Deseja Encerrar o Projeto?","Encerrando Projeto")
		/*
		While !T01->(EOF())			
			cMsg += "A data de encerramento da Etapa "+T01->ZAE_CODETA+" do Plano de Ação que foi criado para este projeto ainda não foi preenchida, por favor preencher a data de encerrameto da etapa antes de encerrar o projeto!"+CRLF
			T01->(DbSkip())
		EndDo
		T01->(DbCloseArea())
		*/
		While !T02->(EOF())			
			cMsg += "Falta preencher a data de encerramento do item "+T02->ZA2_ITEMPR+", por favor preencher a data de encerrameto dos itens antes de encerrar o projeto!"+CRLF
			T02->(DbSkip())
		EndDo
		T02->(DbCloseArea())		
		If !Empty(cMsg)
			MsgAlert(cMsg)
			lRet := .F.
		Else
		
			Begin Transaction
			
				RecLock("ZA1",.F.)
					ZA1->ZA1_ENCERR := Date()
					ZA1->ZA1_STATUS := '2'
				MsUnlock()
				/*
				DbSelectArea("ZAD")
				DbSetOrder(2)
				If ZAD->(DbSeek(xFilial("ZAD")+T03->ZAD_PROJET+T03->ZAD_ITEMPJ+T03->ZAD_CLIENT+T03->ZAD_LOJA))
					RecLock("ZAD",.F.)
						ZAD->ZAD_STATUS := '2'
					MsUnlock()
				EndIf
				*/
			End Transaction		
		EndIf
	EndIf

//T03->(DbCloseArea())

RestArea( aArea )

Return lRet

//---------------------------------------------------------------------------------------

//Alteração/Exclusão do Projeto
User Function RPMSA10A(oModel) // Passa o model sem dados

Local aArea      := GetArea()
Local lRet       := .T.
Local oModel 	   := oModel:GetModel()
Local nOperation := oModel:GetOperation()

	If nOperation == 4 .Or. nOperation == 5
		If ZA1->ZA1_STATUS == '2'
			//MsgAlert("O projeto encontra-se Encerrado, não pode ser Alterado/Excluído.")
			//lRet := .F.
		EndIf
	EndIf
	
RestArea( aArea )

Return lRet

//---------------------------------------------------------------------------------------

User Function RPMSA10H()

Local aArea      := GetArea()

	While !ZA1->(EOF())
		
		cQuery := " SELECT convert(float,CONVERT (VARCHAR, SUM (CONVERT (INT, LEFT (ZA3_HRTOTA, 2))) + (((SUM (CONVERT (INT, RIGHT (ZA3_HRTOTA, 2)))) - (SUM (CONVERT (INT, RIGHT (ZA3_HRTOTA, 2))) % 60)) / 60)) + '.' +CONVERT (VARCHAR, SUM (CONVERT (INT, RIGHT (ZA3_HRTOTA, 2))) % 60)) HORAS "+CRLF
		cQuery += " FROM "+RetSqlName("ZA3")+" ZA3 "+CRLF
		cQuery += " 	INNER JOIN "+RetSqlName("ZA1")+" ZA1 "+CRLF
		cQuery += " 		ON ZA1.D_E_L_E_T_ = '' "+CRLF
		cQuery += " 		AND ZA1_FILIAL 	= '"+xFilial("ZA1")+"' "+CRLF
		cQuery += " 		AND ZA1_CODIGO 	= ZA3_PROJET "+CRLF
		cQuery += " 		AND ZA1_CLIENT 	= ZA3_CLIENT "+CRLF
		cQuery += " 		AND ZA1_LOJA 		= ZA3_LOJA "+CRLF
		cQuery += " 		AND ZA1_ENCERR 	= '' "+CRLF
		//cQuery += " 		AND ZA1_STATUS 	<> '3' "+CRLF
		cQuery += " 		AND ZA1_TIPO 		NOT IN ('1') "+CRLF
		cQuery += " 		AND ZA1_QTDHOR 	<> '' "+CRLF
		cQuery += " WHERE ZA3.D_E_L_E_T_ = '' "+CRLF
		cQuery += " AND ZA3_FILIAL = '"+xFilial("ZA3")+"' "+CRLF
		cQuery += " AND ZA3_PROJET 	= '"+ZA1->ZA1_CODIGO+"' "+CRLF
		cQuery += " AND ZA3_CLIENT 	= '"+ZA1->ZA1_CLIENT+"' "+CRLF
		cQuery += " AND ZA3_LOJA 	= '"+ZA1->ZA1_LOJA+"' "+CRLF
		cQuery += " AND ZA3_TPHORA 	= '01' "+CRLF
		cQuery += " AND ZA3_STATUS <> '0' "+CRLF
		
		TcQuery cQuery New Alias T01		
		
		cQuery := " SELECT ZA1_QTDHOR AS HORAS "+CRLF
		cQuery += " FROM "+RetSqlName("ZA1")+" ZA1 "+CRLF
		cQuery += " WHERE ZA1.D_E_L_E_T_ = '' "+CRLF
		cQuery += " AND ZA1_FILIAL = '"+xFilial("ZA1")+"' "+CRLF
		cQuery += " AND ZA1_CODIGO 	= '"+ZA1->ZA1_CODIGO+"' "+CRLF
		cQuery += " AND ZA1_CLIENT 	= '"+ZA1->ZA1_CLIENT+"' "+CRLF
		cQuery += " AND ZA1_LOJA 	= '"+ZA1->ZA1_LOJA+"' "+CRLF
		cQuery += " AND ZA1_ENCERR 	= '' "+CRLF
		//cQuery += " AND ZA1_STATUS 	<> '3' "+CRLF
		cQuery += " AND ZA1_TIPO 	NOT IN ('1') "+CRLF
		cQuery += " AND ZA1_QTDHOR 	<> '' "+CRLF
		
		TcQuery cQuery New Alias T02
		
		If ZA1->ZA1_STATUS == '1'
			If T01->HORAS > Val(T02->HORAS)				
				RecLock("ZA1",.F.)
					ZA1->ZA1_STATUS := '3'
				MsUnlock()
			EndIf
		EndIf
		
		T01->(dbCloseArea())
		T02->(dbCloseArea())
		
		ZA1->(DbSkip())
	EndDo
RestArea(aArea)

Return