<cfif IsDefined("Form.City") OR IsDefined("form.Keyword") or isDefined("form.AccessOption")>
<!---  ---> 

<!---  <cfdump var="#FORM#">
 <cfabort> --->
 
  <cfinvoke component="com.controller" Method="getChurch" returnvariable="searchChurch">
    <cfif IsDefined("Form.City")> 
     <cfif Len(Trim(Form.City)) GT 0>
          <cfinvokeargument name="City" value="#Form.City#">
	 </cfif>
	</cfif>
	
   <cfif IsDefined("form.keyword")> 
     <cfif Len(Trim(Form.keyword)) GT 0>
          <cfinvokeargument name="Keyword" value="#Form.Keyword#">
     </cfif>
	</cfif>
	
    <cfif IsDefined("Form.AccessOption")>
     <cfif ListLen(Form.AccessOption) GT 0>
	      <cfinvokeargument name="AccessList" value="#Form.AccessOption#">
	 </cfif>
    </cfif>
  </cfinvoke>
  <!---<cfdump var="#searchChurch#">--->
</cfif>



<cfset getCities = request.Controller.getChurchCities()>
<cfset getAccessibility = request.Controller.getAccessOptions()>
<cfmodule template="includes/header.cfm" shownav="true"><br>
<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="#f3f3ed">
   <tr>
     <td colspan="2"><img src="images/Head_ChurchFinder.gif" width="317" height="39" alt="" border="0"></td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td>
	<cfif Not IsDefined("searchChurch")>
	  <form name="findaParish" action="FindAChurch.cfm" method="POST">
		   <table border="0" cellpadding="4" cellspacing="0" width="100%">
	           <tr>
	               <td>Use the form below to find a parish. You may search by keyword, city, or accessibility options.</td>
	           </tr>
			   <tr>
			     <td><strong>Keywords:</strong> <input type="text" name="keyword" value="" size="25" maxlength="100"></td>
			   </tr>
			   <tr>
			     <td><strong>City:</strong> <select name="city">
				                                       <option value="">-- select name--</option>
				                              <cfoutput query="getCities">  
				                                   <option value="#trim(getCities.City)#">#Trim(getCities.City)#</option>
											  </cfoutput>
											</select>
											
	             </td>
			   </tr>
			   <tr>
			     <td>
				    <table border="0" cellpadding="3" cellspacing="0" width="100%">
	                   <cfoutput query="getAccessibility" group="GroupID">
					     <tr>
	                        <td colspan="3"><strong>#GroupName#</strong></td>
	                     </tr>
						 <cfoutput>
						 <tr>
	                        <td width="5%">&nbsp;</td>
							<td width="2%"><input type="checkbox" name="AccessOption" value="#getAccessibility.CatID#"></td>
							<td width="80%">#getAccessibility.CatName#</td>
	                     </tr>
						 </cfoutput>
					   </cfoutput>
	                </table>
				 </td>
			   </tr>
			   <tr>
			     <td>&nbsp;</td>
			   </tr>
			   <tr>
			     <td><input type="submit" name="submit" value="Find a Parish!"></td>
			   </tr>
			   <tr>
			     <td>&nbsp;</td>
			   </tr>
	        </table>
	   </form>	
	   <cfelse>
	       <cfif searchChurch.recordcount GT 0>
	          <cfif searchChurch.recordcount EQ 1>
			     <cflocation url="ChurchDetail.cfm?orgID=#SearchChurch.OrgID#" addtoken="NO">
				 <cfabort>
			  <cfelse>	 
				  <table border="0" cellpadding="4" cellspacing="0" width="100%">
					<cfoutput query="searchChurch">
					   <tr>
					       <td><strong><a href="ChurchDetail.cfm?orgID=#SearchChurch.OrgID#">#SearchChurch.ParishName#</a></strong><br>#SearchChurch.Address1#<br>#SearchChurch.City#, #SearchChurch.State# #SearchChurch.ZipCode#<br> Phone: #SearchChurch.Phone#</td>
					   </tr>
					</cfoutput>
				  </table>
		      </cfif>
		   <cfelse>
		     <p>Your Search Returned no results.<br><a href="FindAChurch.cfm">Click Here</a> to search again.</p>  
		   </cfif>
	   </cfif>
	</td>
  </tr>
</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">