<cfmodule template="includes/header.cfm" shownav="true"><br>
<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="#ffffff">
   <tr>
     <td><h4>Search the Site</h4></td>
  </tr>
  <tr>
    <td>
	 <blockquote>
			<cfif NOT IsDefined("Form.Term")>
			
				<p class="regtext">Use this page to search the IPRA web site by a specific key word or phrase.  This process will search the entire web site looking for pages which match your criteria.  Matches will be displayed to you for review.</p>
			
				<cfform name="SiteSearch" action="SiteSearch.cfm">
				<font face="arial" size="+1" color="Navy">Search Term</font>: <cfinput name="term" size=25 type="text" value="" required="Yes" Message="A Search Term must be specified">
				<input type="Submit" value="Search!"> 
				</cfform>
			
			<cfelse>
			
			<cfsearch collection="FaithExplorer"
				          name="GetResults"
				          type="SIMPLE"
				          criteria="#Form.Term#"
				          startrow="1">
			
				<center>
				<p>This search engine has found web pages matching your given criteria.</font></p>
			
				<cfform name="SiteSearch" action="SiteSearch.cfm">
				<font face="arial" size="+1" color="Navy">Search Term</font>: <cfinput name="term" size=25 type="text" value="#Form.term#" required="Yes" Message="A Search Term must be specified">
				<input type="Submit" value="Search!"> 
				</cfform>
				</center>
			
				<cfif GetResults.RecordCount gt 0>
			      
					<table width="90%" border=0 cellspacing=0 cellpadding=6>
					<!--- table header --->
					<tr bgcolor="cccccc" valign=top>
						<!--- <td width="40" align="center"><font face="Arial" size="-1"><B> No</B></font></td> --->
						<td width="40" align="center"><font face="Arial" size="-1"><B>Score</B></font></td>
						<td><font face="Arial" size="-1"><B>Title</B></font></td>
					</tr>
			
					<CFOUTPUT query="GetResults">
					 <cfif FindNocase("MembersOnly", GetResults.url, 1) EQ 0>  
					 <tr valign="top" bgcolor="#IIf(CurrentRow Mod 2, DE('ffffff'), DE('eeeee'))#">
			
						<!--- current row information --->
						<!--- <td align="center"><font face="Arial" size="-1">#CurrentRow#</font></td> --->
			
						<!--- score --->
						<td align="center"><font face="Arial" size="-1">#Round(Score * 100)#%</font></td>
			
						<!--- title for HTML files --->
						<td>
							<CFIF Title is "">
								<CFSET TitleStr = "No Title">
							<CFELSE>
								<CFSET Titlestr = Title>
							</CFIF>
							
							<CFIF NOT IsNumeric(Key)>
								<CFSET href = Replace(URL, " ", "%20", "ALL")>
								<font face="Arial" size="-1"><A href="#href#"><b>#TitleStr#</b></A><br><font size="-1">(#href#)</font></font>
							<CFELSE>
								<font face="Arial" size="-1"><a href="#custom2##Key#"><b>#TitleStr#</b></a><br><font size="-1">(#custom2#-#Key#)</font></font>
							</CFIF>
						</td>
			
					  </tr>
					  </cfif>
					</CFOUTPUT>
			
					</TABLE>
					<br>
			
				<CFELSE>
					<font face="Arial" size="-1"><h3 align="center">** No records matched your search criteria **</h3></font>
				</CFIF>
			
			</cfif>
		</blockquote>
	</td>
  </tr>
</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">