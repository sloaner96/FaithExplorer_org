
<cfif Not IsDefined("form.name")>
  <cflocation url="ContactUs.cfm?e=1" addtoken="NO">
<cfelse>
   <cfif Len(trim(form.name)) EQ 0>
     <cflocation url="ContactUs.cfm?e=1" addtoken="NO">
   </cfif>
</cfif>
<cfif Not IsDefined("form.Phone") AND Not IsDefined("form.email")>
  <cflocation url="ContactUs.cfm?e=2" addtoken="NO">
</cfif>

<cfif Len(trim(form.Phone)) EQ 0 AND Len(Trim(form.email)) EQ 0>
   <cflocation url="ContactUs.cfm?e=2" addtoken="NO">
 </cfif>

<cfinvoke component="com.controller" method="SendEmail">
   <cfinvokeargument name="Name" value="#Trim(Form.name)#">
   <cfinvokeargument name="Address" value="#Trim(Form.Address)#">
   <cfinvokeargument name="City" value="#Trim(Form.City)#">
   <cfinvokeargument name="State" value="#Trim(form.State)#">
   <cfinvokeargument name="ZipCode" value="#Trim(Form.ZipCode)#">
   <cfinvokeargument name="Phone" value="#Trim(Form.Phone)#">
   <cfinvokeargument name="Email" value="#Trim(Form.Email)#">
   <cfinvokeargument name="Subject" value="#Trim(Form.Subject)#">
   <cfinvokeargument name="Comment" value="#Trim(Form.message)#">
</cfinvoke>

<cfmodule template="includes/header.cfm" shownav="true"><br>
<table border="0" cellpadding="6" cellspacing="0" width="97%" bgcolor="#f3f3ed">
   <tr>
     <td><img src="images/head_tellUs.gif" width="317" height="39" alt="" border="0"></td>
  </tr>
  <tr>
    <td><strong>Thank you for your inquiry. Someone will contact you soon.</strong><br><br><a href="index.cfm">Click here</a> to return to the homepage.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table><br>
<cfmodule template="includes/footer.cfm" showlogo="true">