<cfapplication name="FaithExplorer" 
sessionmanagement="Yes" 
loginstorage="Session">

<!--- Set Globals --->

<!--- Initialize the CFC and set into variables --->
	<cflock scope="Application" timeout="10" type="EXCLUSIVE">
		<cfobject name="Application.Util" component="com.util">
		<cfobject name="Application.Controller" component="com.controller">
	</cflock> 

<!--- Set the component into the request variable  --->
   <cfset request.Util = Application.Util>
   <cfset request.Controller = Application.Controller>
   

