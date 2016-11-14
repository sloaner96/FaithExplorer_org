<cfset GetLinks = request.Controller.getLinks()>
<cfmodule template="includes/header.cfm" shownav="true"><br>
<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="#f3f3ed">
   <tr>
     <td><img src="images/head_links.gif" width="317" height="39" alt="" border="0"></td>
  </tr>
  <cfif getLinks.recordcount GT 0>
	  <tr>
	    <td>
		   <table border="0" cellpadding="4" cellspacing="0" width="100%">
	          <cfoutput query="getLinks" group="LinkCat">
			    <tr>
	                 <td colspan="2"><strong style="font-face: Arial; font-size:16px; color:##3e762e;">#getLinks.LinkCat#</strong></td>
	            </tr>
				
			    <cfoutput>
				  <tr>
				     <td width="10">&nbsp;</td>
				     <td><a href="#getLinks.Siteurl#">#getLinks.SiteName#</a><br>#getLinks.Description#</td>
				  </tr>
				</cfoutput>	
				 <tr><td>&nbsp;</td></tr>
			  </cfoutput>
	       </table>
		</td>
	  </tr>
  <cfelse>
     <tr>
	   <td><strong>There are currently no links for this site.</strong></td>
	 </tr>	  
  </cfif>
</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">