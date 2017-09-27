#include "rwmake.ch"
#include "protheus.ch"

User Function AtCliFor()

//===================================================
// Rotina para atualizar o cadastro de Item Contábil
// dos Clientes
//===================================================

dbselectarea("SA1")
SA1->(dbgotop())

While !SA1->(eof())

// Grava conta no CTD
RecLock("CTD",.T.)

CTD->CTD_FILIAL := SA1->A1_FILIAL
CTD->CTD_ITEM   :=	"C"+SA1->(A1_COD+A1_LOJA)
CTD->CTD_CLASSE :=	"2"
CTD->CTD_DESC01 :=	SA1->A1_NOME
CTD->CTD_BLOQ   :=	"2"
CTD->CTD_DTEXIS :=	CTOD("01/01/1980")

CTD->(MSUNLOCK())

SA1->(dbskip())

EndDo

SA1->(dbclosearea())

//===================================================
// Rotina para atualizar o cadastro de Item Contábil
// dos Fornecedores
//===================================================

dbselectarea("SA2")
SA2->(dbgotop())

While !SA2->(eof())

// Grava conta no CTD
RecLock("CTD",.T.)

CTD->CTD_FILIAL := SA2->A2_FILIAL
CTD->CTD_ITEM   := "F"+SA2->(A2_COD+A2_LOJA)
CTD->CTD_CLASSE := "2"
CTD->CTD_DESC01 := SA2->A2_NOME
CTD->CTD_BLOQ   := "2"
CTD->CTD_DTEXIS := CTOD("01/01/1980")

CTD->(MSUNLOCK())

SA2->(dbskip())

EndDo

SA2->(dbclosearea())



//===================================================
// Rotina para atualizar o cadastro de Item Contábil
// dos Produtos
//===================================================

dbselectarea("SA6")
SA6->(dbsetorder(1))
SA6->(dbgotop())

While !SA6->(eof())
	
	If ALLTRIM(SB1->B1_TIPO)$"MP_PA_PI_OI_RE_BN_EM_PP_SP"
		// Grava conta no CTD
		RecLock("CTD",.T.)
		
		CTD->CTD_FILIAL :=	" "
		CTD->CTD_ITEM   :=	"B"+alltrim(SA6->A6_COD)+alltrim(SA6->A6_AGENCIA)+alltrim(SA6->A6_NUMCON)
		CTD->CTD_CLASSE :=	"2"
		CTD->CTD_DESC01 :=	SA6->A6_NOME
		CTD->CTD_BLOQ   :=	"2"
		CTD->CTD_DTEXIS :=	CTOD("01/01/1980")
		
		CTD->(MSUNLOCK())
		
	EndIf
	
	SA6->(dbskip())
	
EndDo

SA6->(dbclosearea())



CTD->(dbclosearea())

ALERT("CONCLUÍDO")

Return
