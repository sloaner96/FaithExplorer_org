<cfparam name="url.E" default="0">
<cfmodule template="includes/header.cfm" shownav="true"><br>
<table border="0" cellpadding="4" cellspacing="0" width="97%" bgcolor="#f3f3ed">
   <tr>
     <td><img src="images/head_tellUs.gif" width="317" height="39" alt="" border="0"></td>
  </tr>
  <tr>
    <td align="Center">
	   <table border="0" cellpadding="4" cellspacing="0" width="90%">
          <tr>
            <td><p>If you have questions about the Diocese or its ministries,  or if you just want to communicate some comments about us or this web site, please take a moment to share your thoughts with us.</p>
			<p>Fill in your complete name, daytime phone number, and email address (if you have one).  We need this information to be able respond back to you in a timely manner.  Then type in your message -- the textbox below will scroll to accommodate as long a message as you need to express your inquiry fully.</p>
			</td>
          </tr>
		  <tr>
		    <td>
			   
			   <FORM NAME="GetInq" ACTION="inquiry.cfm" METHOD="POST"> 

				<center>
				<cfif URl.E EQ 1>
				  <li><strong style="color:#CC0000;font-size:12px;">Error! You must include your full name</strong></li>
				<cfelseif url.E EQ 2>
				  <li><strong>You must include either your daytime phone number or an email address</strong></li>
				</cfif>
				<table border="0" cellspacing="0" cellpadding="1" bgcolor="#F3F3F3">
				<tr>
				  <td colspan="2"><strong style="color:#CC0000;">* Required Fields</strong></td>
				</tr>
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Name:</b></font></td>
					<td width=*><INPUT TYPE="text" NAME="Name" SIZE="30" MAXLENGTH="50"> <strong style="">*</strong></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Address:</b></font></td>
					<td width=*><INPUT TYPE="text" NAME="Address" SIZE="30" MAXLENGTH="30"></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>City:</b></font></td>
					<td width=*>
						<INPUT TYPE="text" NAME="City" SIZE="20" MAXLENGTH="30">  
						<font face="Verdana" size="-1"><b>State:</b></font> <INPUT TYPE="text" NAME="State" SIZE="2" MAXLENGTH="2">
				
					</td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Zipcode:</b></font></td>
					<td width=*><INPUT TYPE="text" NAME="Zipcode" SIZE="10" MAXLENGTH="10"></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Phone:</b></font></td>
					<td width=*><INPUT TYPE="text" NAME="Phone" SIZE="20" MAXLENGTH="20"><strong style="#CC0000;">*</strong></td>
				
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Email&nbsp;Address:</b></font></td>
					<td width=*><INPUT TYPE="text" NAME="Email" SIZE="30" MAXLENGTH="130"><strong style="#CC0000;">*</strong></td>
				</tr>
				
				<tr>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Subject:</b></font></td>
					<td width=*>
						<SELECT NAME="Subject" SIZE="1">
						<option value="" selected>--- Select a topic ---</option>
						<option value="Parish Info">Requesting information on parishes within the Diocese</option>
						<option value="Faith Q&A">Questions about the Episcopal Faith</option>
				
						<option value="Youth Ministry">Information on Youth/Young Adult Ministry</option>
						<option value="Re-Development">Comments on the Church Center Redevelopment</option>
						<option value="Cathedral">Inquiry about St. James Cathedral</option>
						<option value="Feedback">Feedback about the web site</option>
						<option value="Other Topic">Another Topic</option>
						</SELECT>
				
					</td>
				</tr>
				
				<tr valign=top>
					<td width=120 align=left><font size="-1" face="Verdana"><b>Comments:</b></font></td>
					<td width=*><textarea name="Message" cols="35" rows="8" wrap="VIRTUAL"></textarea></td>
				</tr>
				
				<tr valign=top>
					<td align=center colspan=2><br><input type="Submit" value="Send My Message Now!">&nbsp;&nbsp;&nbsp;<input type="Reset" value="Clear Form"></td>
				</tr>
				</table>
				
				</center>
				
				</FORM>
			</td>
		  </tr>
       </table>
	</td>
  </tr>
</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">