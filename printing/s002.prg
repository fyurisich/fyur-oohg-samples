/*
 * Printing Sample n� 2
 * Author: Fernando Yurisich <fyurisich@oohg.org>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to generate and preview two
 * reports using TPrint with "HBPRINTER" option.
 *
 * Visit us at https://github.com/oohg/samples
 */

#include "oohg.ch"

FUNCTION Main

   PUBLIC oPrint1, oPrint2

   DEFINE WINDOW Form ;
      MAIN ;
      WIDTH 500 HEIGHT 200 ;
      TITLE "oohg - Simultaneous reports using TPrint with HBPRINTER" ;
      ON RELEASE ReleaseTPrintObjects()

      @ 20, 20 BUTTON btn_Run ;
         CAPTION "Test" ;
         ACTION DoReports()

      @ 60, 20 LABEL lbl_Msg ;
         VALUE "This sample shows how to build simultaneous reports using TPrint with HBPRINTER" ;
         WIDTH 340 HEIGHT 80

      ON KEY ESCAPE ACTION ThisWindow.Release()
   END WINDOW

   CENTER WINDOW Form
   ACTIVATE WINDOW Form

   RETURN NIL

FUNCTION DoReports()

   cFont   := "Courier New"
   nNumber := 10320
   cDate   := DToC( Date() )
   cCli    := "ANTONIO"
   cNIF    := "45271099S"
   cAdd    := "My Address"

   // First report
   oPrint1 := TPrint( "HBPRINTER" )
   oPrint1:Init( "Form" )           // To switch between report both must have the same parent
   oPrint1:SetUnits( "MM", 0 )
   oPrint1:SelPrinter( .T., .T. )   // Select, Preview
   oPrint1:SetPreviewSize( 2 )
   oPrint1:BeginDoc()

   oPrint1:BeginPage()
   nLin := 55
   oPrint1:PrintRoundrectangle( nLin + 5, 06, nLin + 17, 60 )
   oPrint1:PrintData( nLin +  7, 08, "AAAAAAA :" ,                       cFont, 12)
   oPrint1:PrintData( nLin +  7, 31, Transform( nNumber, "99,999,999" ), cFont, 12, .T. )
   oPrint1:PrintData( nLin + 12, 08, "Date    :",                        cFont, 12 )
   oPrint1:PrintData( nLin + 12, 31, cDate,                              cFont, 12, .T. )
   oPrint1:PrintRoundrectangle( nLin - 2, 70, nLin+25,203)
   oPrint1:PrintData( nLin,      73, "Client   :", cFont, 12 )
   oPrint1:PrintData( nLin,      99, cCli,         cFont, 12, .T. )
   oPrint1:PrintData( nLin + 10, 73, "NIF      :", cFont, 12 )
   oPrint1:PrintData( nLin + 10, 99, cNIF,         cFont, 12, .T. )
   oPrint1:PrintData( nLin + 15, 73, "Address  :", cFont, 12 )
   oPrint1:PrintData( nLin + 15, 99, cAdd,         cFont, 12, .T.)
   oPrint1:EndPage()

   // Second report
   oPrint2 := TPrint( "HBPRINTER" )
   oPrint2:Init( "Form" )           // To switch between report both must have the same parent
   oPrint2:SetUnits( "MM", 0 )
   oPrint2:SelPrinter( .T., .T. )   // Select, Preview
   oPrint2:SetPreviewSize( 2 ) 
   oPrint2:BeginDoc()

   oPrint2:BeginPage()
   nLin2 := 35
   oPrint2:PrintRoundRectangle( nLin2 + 5, 06, nLin + 17, 60 )
   oPrint2:PrintData( nLin2 +  7, 08, "BBBBBBB :",                        cFont, 12 )
   oPrint2:PrintData( nLin2 +  7, 31, Transform( nNumber, "99,999,999" ), cFont, 12, .T. )
   oPrint2:PrintData( nLin2 + 12, 08, "Date    :",                        cFont, 12 )
   oPrint2:PrintData( nLin2 + 12, 31, cDate,                              cFont, 12, .T. )
   oPrint2:EndPage()

   oPrint2:EndDoc( .F., .F., .T. )   // Save, Wait, Size         
   oPrint1:EndDoc( .F., .F., .T. )   // Save, Wait, Size       

   //oPrint1:Release()   // This closes the preview window
   //oPrint2:Release()   // This closes the preview window

   RETURN NIL

FUNCTION ReleaseTPrintObjects

   IF HB_ISOBJECT( oPrint1 )
      oPrint1:Release()
   ENDIF
   IF HB_ISOBJECT( oPrint2 )
      oPrint2:Release()
   ENDIF

   RETURN NIL

/*
 * EOF
 */