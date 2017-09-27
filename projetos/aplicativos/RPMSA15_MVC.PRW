#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

// #########################################################################################
// Projeto: Horas Investimento
// Modulo : Faturamento
// Fonte  : RPMSA15
// ---------+-------------------+-----------------------------------------------------------
// Data     | Autor             | Descricao
// ---------+-------------------+-----------------------------------------------------------
// 23/02/17 | Anderson Ávila    | Autorização Horas de Investimento com envio de email após
//  		| 				    | gravação e alteração de registro.
// ---------+-------------------+-----------------------------------------------------------

User Function RPMSA15_MVC()
	local cVldAlt := ".T." // Operacao: ALTERACAO
	local cVldExc := ".T." // Operacao: EXCLUSAO
	
	local cAlias
	
	cAlias := "SZC"
	chkFile(cAlias)
	dbSelectArea(cAlias)
	dbSetOrder(1)
	axCadastro(cAlias, "Autorização Horas de Investimento", cVldExc, "U_PMS15EML()")
Return

User Function PMS15EML()
	// Dados do email
	cDe 	:= GetMV("MV_WFMAIL")//"workflow@mconsult.com.br"
	cAssunto:= ""
	cBody 	:= ""
	cAtach 	:= ""
	cCopia 	:= ""
	cCC 	:= ""
	cPara 	:= "dr@mconsult.com.br;"
	cPara	+= "jt@mconsult.com.br;"
	cPara	+= "rafaelxavier@mconsult.com.br;"
	cPara	+= "rodrigolucas@mconsult.com.br;"
	cPara	+= "gustavopedrosa@mconsult.com.br"

	// Campos
	cCodigo		:= Alltrim(M->ZC_COD		)
	cCodCliente	:= Alltrim(M->ZC_CLIENTE	)
	cLoja		:= Alltrim(M->ZC_LOJA		)
	cCliente	:= Alltrim(M->ZC_NCLIENTE	)
	cCodProjeto	:= Alltrim(M->ZC_PROJETO	)
	cProjeto	:= Alltrim(M->ZC_NPROJET	)
	cCodItem	:= Alltrim(M->ZC_ITEMPRO	)
	cItem		:= Alltrim(M->ZC_ITEM		)
	cCodAnalista:= Alltrim(M->ZC_RECURSO	)
	cAnalista	:= Alltrim(M->ZC_ANALIST	)
	dDtInicio	:= M->ZC_INICIO
	dDtFim		:= M->ZC_FIM
	nQtdHoras	:= M->ZC_HORAS
	cJustifica	:= Alltrim(M->ZC_JUSTIFI	)
	
	cAssunto 	:= 'Autorização Horas de Investimento'
	
	cBody:='<HTML><HEAD><TITLE></TITLE>'
	cBody+='<META http-equiv=Content-Type content="text/html; charset=windows-1252">'
	cBody+='<META content="MSHTML 6.00.6000.16735" name=GENERATOR></HEAD>'
	cBody+='<BODY>'
	cBody+='<TABLE cellSpacing=0 cellPadding=0 width="100%">'
	cBody+='  <TBODY>'
	cBody+='  	<TR>'
	cBody+='  		<TD COLSPAN="2" style="text-align:center">'
	cBody+='    		<h3>' + cAssunto + '</h3>'
	cBody+='  		</TD>'
	cBody+='  	</TR>'
	cBody+='  	<TR>'
	cBody+='  		<TD COLSPAN="2" style="text-align:center">'
	cBody+='    		<h3>Período: ' + DtoC(dDtInicio) + ' a ' + DtoC(dDtFim) + '</h3>'
	cBody+='  		</TD>'
	cBody+='  	</TR>'
	cBody+='  	<TR>'
	cBody+='  		<TD COLSPAN="2">'
	cBody+='  			<TABLE>'
	cBody+='  				<TBODY>'
	cBody+='  					<TR style="background:#ccc">'
	cBody+='    					<TD>Cliente: </TD>'
	cBody+='    					<TD>' + cCliente + '</TD>'
	cBody+='  					</TR>'
	cBody+='  					<TR>'
	cBody+='    					<TD>Projeto: </TD>'
	cBody+='    					<TD>' + cProjeto + '</TD>'
	cBody+='  					</TR>'		
	cBody+='  					<TR style="background:#ccc">'
	cBody+='    					<TD>Item: </TD>'
	cBody+='    					<TD>' + cItem + '</TD>'
	cBody+='  					</TR>'
	cBody+='  					<TR>'
	cBody+='    					<TD>Analista: </TD>'
	cBody+='    					<TD>' + cAnalista + '</TD>'
	cBody+='  					</TR>'
	cBody+='  					<TR style="background:#ccc">'
	cBody+='    					<TD>Qtd. Horas: </TD>'
	cBody+='    					<TD>' + cValToChar(nQtdHoras) + ' horas </TD>'
	cBody+='  					</TR>'
	cBody+='  					<TR>'
	cBody+='    					<TD>Justificativa: </TD>'
	cBody+='    					<TD>' + cJustifica + '</TD>'
	cBody+='  					</TR>'
	cBody+='  				</TBODY>'
	cBody+='  			</TABLE>'
	cBody+='  		</TD>'
	cBody+='  	</TR>'
	cBody+='  </TBODY>'
	cBody+='</TABLE>'
	cBody+='</BODY>'
	cBody+='</HTML>'
	
	//U_EnviarEmail(cDe,cPara,cAssunto,cBody, cAtach, cCopia,cCC)	
	U_EnviarEmail(cDe,cPara,cAssunto,cBody)
Return .T.