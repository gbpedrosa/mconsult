#INCLUDE "rwmake.ch"

User Function atuaest

Local _aArray := {'ZZA'}  
//Local _aArray := {'ZZ5'}
for x:= 1 to len(_aArray)
	X31UpdTable(_aArray[x]) //Atualiza o cAlias baseado no SX3
	If __GetX31Error() //Verifica se ocorreu erro
		Alert(__GetX31Trace()) //Mostra os erros
	Endif
next
//DBSELECTAREA("ZN5")
alert("FIM")

Return
