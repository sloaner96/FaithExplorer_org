<cfparam name="URL.Type" default="">
<cfif Not IsDefined("URL.OrgID")>
  <cflocation url="FindaChurch.cfm" addtoken="NO">
</cfif>

<cfset GetChurchInfo = request.Controller.getChurchDetail(URL.OrgID)>
<cfset GetChurchAccess = request.Controller.getChurchAccessability(URL.OrgID)>
<!--- --->
<cfset GetChurchLeader = request.Controller.getChurchLeader(URL.OrgID)> 
<cfset GetMinistries   = request.Controller.getChurchMinistries(URL.OrgID)> 
<cfset FormattedAddrString = "#getChurchInfo.Address1# #getChurchInfo.City# #getChurchInfo.State# #getChurchInfo.ZipCode#">
<cfset FormattedAddrString = ReplaceNoCase(FormattedAddrString, " ", "+", "ALL")>
<cfmodule template="includes/header.cfm" shownav="true"><br>

	<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="#f3f3ed">
	   <tr>
	     <td colspan="2"><img src="images/Head_ChurchFinder.gif" width="317" height="39" alt="" border="0"></td>
	  </tr>
	  <tr>
	    <td width="2%">&nbsp;</td>
	    <td>
		   <table border="0" cellpadding="4" cellspacing="0" width="100%">
	         <tr>
	            <td valign="top">
				    <cfoutput>
					<strong style="font-face: Arial; font-size:16px; color:##3e762e;">#getChurchInfo.ParishName#</strong><br><br>
				    #getChurchInfo.Address1#<br>
					<cfif getChurchInfo.Address2 NEQ "">#getChurchInfo.Address2#<br></cfif>
					#getChurchInfo.City#, #getChurchInfo.State#, #getChurchInfo.ZipCode#<br>
					</cfoutput>
				    <cfswitch expression="#URL.TYPE#">	
					   <cfcase value="A"><br>
					      <cfoutput><div align="right"><a href="ChurchDetail.cfm?OrgID=#ORGID#&"><< Back to Parish Home</a></div></cfoutput>
					       <table border="0" cellpadding="4" cellspacing="0" width="100%">
                              <tr>
                                 <td colspan="4"><strong style="font-face: Arial; font-size:16px; color:#a2ba74;">ACCESSIBILITY</strong></td>
                              </tr>
							  <tr>
							    <td colspan="4">&nbsp;</td>
							  </tr>
							  <cfoutput query="GetChurchAccess" group="GroupID">
							     <tr>
								    <td width="2%">&nbsp;</td>
			                        <td colspan="3"><strong>#GetChurchAccess.GroupName#</strong></td>
			                     </tr>
								 <cfoutput>
								 <tr>
			                        <td width="2%">&nbsp;</td>
									<td width="6%"></td>
									<td width="2%"><cfif GetChurchAccess.CatExists NEQ ""><img src="images/checkbox.gif" width="13" height="13" alt="" border="0"><cfelse><img src="images/BlankCheckbox.gif" width="13" height="13" alt="" border="0"></cfif></td>
									<td width="80%">#GetChurchAccess.CatName#</td>
			                     </tr>
								 </cfoutput>
							  </cfoutput>
                           </table> <br>  
					   </cfcase>
					   <cfcase value="P">
					       <br>
						   <cfoutput><div align="right"><a href="ChurchDetail.cfm?OrgID=#ORGID#&"><< Back to Parish Home</a></div></cfoutput>  
						   <table border="0" cellpadding="0" cellspacing="0" width="100%">
                              <tr>
                                 <td><strong style="font-face: Arial; font-size:14px; color:#739e56;">PROFILE</strong></td>
                              </tr>
                              <cfoutput>
				               <tr>
                                 <td>#GetCHurchInfo.ParishProfile#</td>
                              </tr>
                              </cfoutput>                                 
                           </table>     
					   </cfcase>
					   <cfcase value="W"><br>
					       <cfoutput><div align="right"><a href="ChurchDetail.cfm?OrgID=#ORGID#&"><< Back to Parish Home</a></div></cfoutput>
					       <table border="0" cellpadding="0" cellspacing="0" width="100%">
                              <tr>
                                 <td><strong style="font-face: Arial; font-size:14px; color:#739e56;">WORSHIP SERVICES</strong></td>
                              </tr>
			                  <cfoutput>
                              <tr>
                                 <td>#GetCHurchInfo.WorshipServices#</td>
                              </tr> 
                              </cfoutput>    	
                           </table> 
					   </cfcase>
					   <cfcase value="M"><br>
					       <cfoutput><div align="right"><a href="ChurchDetail.cfm?OrgID=#ORGID#&"><< Back to Parish Home</a></div></cfoutput>
					       <table border="0" cellpadding="0" cellspacing="0" width="100%">
                              <cfoutput>
							    <tr>
                                   <td><strong style="font-face: Arial; font-size:14px; color:##739e56;">MINISTRIES</strong></td>
                                </tr>
								<tr>
								  <td>&nbsp;</td>
								</tr>
								<tr>
								  <td>
								     <table border="0" cellpadding="4" cellspacing="1" width="100%" bgcolor="##999900">
                                         <tr bgcolor="##99cc99">
										   <td><strong>Ministry</strong></td>
										   <td><strong>Contact</strong></td>
										 </tr>
										<cfloop query="GetMinistries"> 
										  <tr bgcolor="##f3f3ed">
                                             <td><strong>#GetMinistries.MinistryName#</strong></td>
											 <td><cfif GetMinistries.Email NEQ ""><a href="mailto:#GetMinistries.Email#">#GetMinistries.ContactName#</a><cfelse>#GetMinistries.ContactName#</cfif><br>#GetMinistries.Phone#</td>
                                          </tr>
										</cfloop>
                                     </table>
								  </td>
								</tr>
							  </cfoutput>
                           </table> 
					   </cfcase>
					   <cfdefaultcase>
						   <cfoutput>
						      <cfif getChurchInfo.Phone NEQ "">Phone: #getChurchInfo.Phone#<br></cfif>
							  <cfif getChurchInfo.Fax NEQ "">Fax: #getChurchInfo.Fax#<br></cfif>
							  <cfif getChurchInfo.Email NEQ ""><a href="Mailto:#getChurchInfo.Email#">#getChurchInfo.Email#</a><br></cfif>
							  <cfif getChurchInfo.Website NEQ "">Website: <a href="#getChurchInfo.Website#" style="color:##990000;">#getChurchInfo.Website#</a><br></cfif>
							  <br>
						      <strong><a href="http://maps.google.com/maps?q=#FormattedAddrString#&hl=en" target="_blank" style="color:##990000;">Click to View Map</a></strong><br><br><br>
						      <a href="ChurchDetail.cfm?OrgID=#ORGID#&Type=A" style="font-face: Arial; font-size:12px; color:##739e56;"><strong >Accessibility</strong></a><br><br>
							  <cfif getChurchinfo.ParishProfile NEQ "">
						      <a href="ChurchDetail.cfm?OrgID=#ORGID#&Type=P" style="font-face: Arial; font-size:12px; color:##739e56;"><strong style="font-face: Arial; font-size:12px; color:##739e56;">Church Profile</strong></a><br><br>
						      </cfif>
							  <cfif GetMinistries.recordcount GT 0> 
							  <a href="ChurchDetail.cfm?OrgID=#ORGID#&Type=M" style="font-face: Arial; font-size:12px; color:##739e56;"><strong style="font-face: Arial; font-size:12px; color:##739e56;">Ministries</strong></a><br><br>
							 </cfif>
							 <cfif getChurchinfo.WorshipServices NEQ "">
							  <a href="ChurchDetail.cfm?OrgID=#ORGID#&Type=W" style="font-face: Arial; font-size:12px; color:##739e56;"><strong style="font-face: Arial; font-size:12px; color:##739e56;">Worship Services</strong></a><br>
						     </cfif>
						   </cfoutput>
						  </td>
						  <cfoutput>
							  <td valign="top"><cfif getChurchInfo.imgPath NEQ ""><img src="http://www.epischicago.org/images/parishes/#getChurchInfo.imgPath#" height="200" width="250" style="border:1px;"><br><br></cfif>
								   <table border="0" cellpadding="3" cellspacing="0" width="100%">
				                      <tr>
				                         <td><strong style="font-face: Arial; font-size:14px; color:##739e56;">LEADERSHIP</strong></td>
				                      </tr>
									  <cfloop query="GetChurchLeader">
									  <tr>
									    <td><cfif GetChurchLeader.Email EQ ""><strong>#GetChurchLeader.Prefix# #GetChurchLeader.Firstname# #GetChurchLeader.Lastname# #GetChurchLeader.Suffix#</strong><br>#GetChurchleader.title#<br>#GetChurchLeader.Phone#<cfelse><strong><a href="mailto:#GetChurchLeader.Email#">#GetChurchLeader.Prefix# #GetChurchLeader.Firstname# #GetChurchLeader.Lastname# #GetChurchLeader.Suffix#</a></strong><br>#GetChurchleader.title#</cfif></td>
									  </tr>
									  </cfloop>
				                   </table>              
							  </td>
						  </cfoutput>
					   </cfdefaultcase>
				    </cfswitch>
				
	         </tr>
	       </table>
		</td>
	  </tr>	
	</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">