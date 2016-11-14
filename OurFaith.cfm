<cfset gettext = request.controller.getArticleText(URL.Type)>
<cfmodule template="includes/header.cfm" shownav="true"><br>
<cfoutput>
	<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="##f3f3ed">
	  <cfswitch expression="#URL.TYPE#">
	     <cfcase value="A">
			  <tr>
			     <td><img src="images/head_whoweare.gif" width="317" height="39" alt="" border="0"></td>
			  </tr> 
	    </cfcase>
		<cfcase value="B">
			  <tr>
			     <td><img src="images/head_WhatBelieve.gif" width="317" height="39" alt="" border="0"></td>
			  </tr>
	    </cfcase>
		<cfcase value="M">
			  <tr>
			     <td><img src="images/head_ourMinistry.gif" width="317" height="39" alt="" border="0"></td>
			  </tr>
	
	    </cfcase>
		<cfcase value="W">
			  <tr>
			     <td><img src="images/head_howWorship.gif" width="317" height="39" alt="" border="0"></td>
			  </tr>
	
	    </cfcase>
		<cfcase value="E">
			  <tr>
			     <td><img src="images/head_OurMessage.gif" width="317" height="39" alt="" border="0"></td>
			  </tr>
	
	    </cfcase>
	  </cfswitch>
	   <tr>
	     <td>
		    <table border="0" cellpadding="5" cellspacing="0" width="100%">
				<tr>
				   <td>&nbsp;</td>
				   <td><cfif getText.imgSrc NEQ ""><img src="http://www.epischicago.org/images/FaithExplorer/#getText.ImgSrc#" alt="#gettext.ArticleTitle#" hspace="5" vspace="5" border="0" align="left" style="border-width: 1px; border-color: ##000000;"></cfif>#trim(gettext.ArticleText)#</td>
				</tr>
			 </table>
		  </td>
	  </tr>
	  <tr>
	    <td>&nbsp;</td>
	  </tr>
	</table><br>
</cfoutput>
<cfmodule template="includes/footer.cfm" showlogo="true">