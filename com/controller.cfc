<cfcomponent displayname="Controller" output="No">
    <!--- Create Instance Structure --->
	<cfset instance = structNew()>
	<!--- Set Instance variables --->
	<cfset instance.dsn = "DioChicago">
	
	<cfset instance.LockName = "controller_cfc">
	<!--- Initialize Component --->
	<cfset Init()>
	
	<!--- ##### The Initialization Funtion --->
	<cffunction name="Init" access="private" returntype="VOID"> 
	
	</cffunction>
	
	<!--- #### Find a Church Search Componnet --->
	<cffunction name="getChurch" access="public" returntype="Query"> 
	  <cfargument name="city" type="string" required="no">
	  <cfargument name="keyword" type="string" required="no">
	  <cfargument name="AccessList" type="string" required="no">
	  
	  <cfset var chuchlookup = "">
	  <cfif isDefined("Arguments.AccessList")>
	      <cfset AcessArray = ListToArray(Arguments.AccessList, ",")>
	  </cfif>
	  
	  <cfquery name="churchlookup" datasource="#instance.dsn#">
	     SELECT d.* From Directory d
			<cfif IsDefined("arguments.City") AND Not IsDefined("arguments.Keyword") and not IsDefined("arguments.AccessList")>
				WHERE d.City like '#arguments.City#'
			<cfelseif Not IsDefined("arguments.City") AND IsDefined("arguments.Keyword") and not IsDefined("arguments.AccessList")>
				WHERE (d.City LIKE '%#arguments.Keyword#%'
					OR d.ParishName LIKE '%#arguments.Keyword#%'
					OR d.Address1 LIKE '%#arguments.Keyword#%')
			<cfelseif IsDefined("arguments.City") AND IsDefined("arguments.Keyword") and not IsDefined("arguments.AccessList")>		
			   Where d.city = '#arguments.City#'
			   AND (d.ParishName LIKE '%#arguments.Keyword#%'
					OR d.Address1 LIKE '%#arguments.Keyword#%')
			<cfelseif not IsDefined("arguments.City") AND not IsDefined("arguments.Keyword") and IsDefined("arguments.AccessList")>
			  LEFT OUTER JOIN FaithAccesability c ON (d.OrgId = c.OrgID)
			  Where C.CatID IN (<cfloop index="x" from="1" to="#Arraylen(AcessArray)#">'#AcessArray[X]#'<cfif ArrayLen(AcessArray) NEQ X>,</cfif></cfloop>)	
			<cfelseif IsDefined("arguments.City") AND Not IsDefined("arguments.Keyword") and IsDefined("arguments.AccessList")>  
			   LEFT OUTER JOIN FaithAccesability c ON (d.OrgId = c.OrgID)
			  Where C.CatID IN (<cfloop index="x" from="1" to="#Arraylen(AcessArray)#">'#AcessArray[X]#'<cfif ArrayLen(AcessArray) NEQ X>,</cfif></cfloop>)	
			  AND d.city = '#arguments.City#'
			<cfelseif Not IsDefined("arguments.City") AND IsDefined("arguments.Keyword") and IsDefined("arguments.AccessList")>  
			   LEFT OUTER JOIN FaithAccesability c ON (d.OrgId = c.OrgID)
			  Where C.CatID IN (<cfloop index="x" from="1" to="#Arraylen(AcessArray)#">'#AcessArray[X]#'<cfif ArrayLen(AcessArray) NEQ X>,</cfif></cfloop>)	
			  And (d.ParishName LIKE '%#arguments.Keyword#%'
			  OR d.Address1 LIKE '%#arguments.Keyword#%')
			<cfelseif IsDefined("arguments.City") AND IsDefined("arguments.Keyword") and IsDefined("arguments.AccessList")>
			   LEFT OUTER JOIN FaithAccesability c ON (d.OrgId = c.OrgID)
				Where d.city = '#arguments.City#'
			    AND (d.ParishName LIKE '%#arguments.Keyword#%'
					OR d.Address1 LIKE '%#arguments.Keyword#%')	
				AND C.CatID IN (<cfloop index="x" from="1" to="#Arraylen(AcessArray)#">'#AcessArray[X]#'<cfif ArrayLen(AcessArray) NEQ X>,</cfif></cfloop>)					
			</cfif>
			AND d.ParishType IN ('P', 'M')
			ORDER BY d.City, d.ParishName
	  </cfquery>
	  
	  <cfreturn churchlookup />
	</cffunction>
    
		<!--- #### Get the leaders of  church --->
	<cffunction name="getChurchLeader" access="public" returntype="Query"> 
	   <cfargument name="parishID" type="numeric" required="yes">
	  
	   <cfset var chuchleader = "">
	  
	  <cfquery name="chuchleader" datasource="#instance.dsn#">
	     SELECT C.*,
		   (Select CodeDesc
		     From Lookups
		      Where CodeGroup = 'CONTYPE'
			  AND C.ContactType = Codevalue) As Title 
		 From Contacts C
		 Where OrgID = #Arguments.ParishID#
		 Order By Lastname, Firstname
	  </cfquery>
	
	   <cfreturn chuchleader/>
	</cffunction>
	
	<!--- #### Get the leaders of  church --->
	<cffunction name="getChurchMinistries" access="public" returntype="Query"> 
	   <cfargument name="parishID" type="numeric" required="yes">
	  
	   <cfset var getMinistries = "">
	  
	  <cfquery name="getMinistries" datasource="#instance.dsn#">
	     Select MinistryID, OrgID, [Desc] as MinistryName, Contactname, Phone, Email
		 From FaithExplorerMinistrty
		 Where orgID = '#Arguments.ParishID#'
		 order by [Desc]
	  </cfquery>
	
	   <cfreturn getMinistries/>
	</cffunction>
	
	
	<!--- #### Get the details of  church --->
	<cffunction name="getChurchDetail" access="public" returntype="Query"> 
	   <cfargument name="parishID" type="numeric" required="yes">
	  
	   <cfset var chuchDetail = "">
	  
	  <cfquery name="chuchDetail" datasource="#instance.dsn#">
	     SELECT  *
		 From Directory
		 Where OrgID = #Arguments.ParishID#
	  </cfquery>
	
	   <cfreturn chuchDetail/>
	</cffunction>
	
    <!--- #### Get the Accessability options for a church--->
	<cffunction name="getChurchAccessability" access="public" returntype="Query"> 
	   <cfargument name="parishID" type="numeric" required="yes">
	  
	   <cfset var chuchDetail = "">
	  
	  <cfquery name="chuchDetail" datasource="#instance.dsn#">
	    SELECT M.GroupID, M.CatID, 
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCGRP'
			  AND CodeValue = M.GroupID) as GroupName,
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCCAT'
			  AND CodeValue = M.CatID) as CatName,
			(Select AccessID
			  From FaithAccesability
			  Where OrgID = #Arguments.ParishID#
			  AND GroupID = M.GroupID 
			  AND CatID = M.CatID) as CatExists  
		 from FaithAccessMatrix M
		 
		 order By M.GroupID, M.CatID 
	  </cfquery>
	
	   <cfreturn chuchDetail/>
	</cffunction>
	
	 <!--- #### Get All rhe Accessability options--->
	<cffunction name="getAccessOptions" access="public" returntype="Query"> 
	  
	   <cfset var accessgroup = "">
	  
	  <cfquery name="accessgroup" datasource="#instance.dsn#">
	     SELECT M.GroupID, M.CatID, 
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCGRP'
			  AND CodeValue = M.GroupID) as GroupName,
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FEACCCAT'
			  AND CodeValue = M.CatID) as CatName
		 from FaithAccessMatrix M
		 order By M.GroupID, M.CatID
	  </cfquery>
	
	   <cfreturn accessgroup/>
	</cffunction>
	
    <!--- #### Get Distinct Cities--->
	<cffunction name="getChurchCities" access="public" returntype="Query"> 
	  
	   <cfset var getCity = "">
	  
	  <cfquery name="getCity" datasource="#instance.dsn#">
	     SELECT Distinct City
		 From Directory
		 Where ParishType IN ('M','P')
		 Order By City
	  </cfquery>
	
	   <cfreturn getCity/>
	</cffunction>
	
	<!--- #### Get Article text--->
	<cffunction name="getArticleText" access="public" returntype="Query"> 
	  <cfargument name="ArticleType" type="string" required="yes">
	  
	   <cfset var gettxt = "">
	  
	  <cfquery name="gettxt" datasource="#instance.dsn#">
	     Select *
		 From FaithExplorerTxt
		 Where ArticleType = '#Arguments.ArticleType#'
	  </cfquery>
	
	   <cfreturn gettxt/>
	</cffunction>
	
	
   <!--- #### Get Links--->
	<cffunction name="getLinks" access="public" returntype="Query"> 
	  
	   <cfset var Links = "">
	  
	  <cfquery name="Links" datasource="#instance.dsn#">
	     Select S.SiteName, S.Siteurl, S.Description,
		   (Select CodeDesc 
		      From Lookups
		      Where CodeGroup = 'FELINKCAT'
			  AND CodeValue = L.CatID) as LinkCat
		 From FaithExplorerLinks L, SiteLinks S
		 Where L.SiteLinkID = S.LinkID
		 Order by 4, S.SiteName
	  </cfquery>
	
	   <cfreturn Links/>
	</cffunction>
	
	<!--- #### SendEmail From Contact US--->
	<cffunction name="SendEmail" access="public" returntype="void"> 
	   <cfargument name="Name" type="String" required="YES">
	   <cfargument name="Address" type="String" required="NO">
	   <cfargument name="City" type="String" required="NO">
	   <cfargument name="State" type="String" required="NO">
	   <cfargument name="ZipCode" type="String" required="NO">
	   <cfargument name="Phone" type="String" required="NO">
	   <cfargument name="Email" type="String" required="NO">
	   <cfargument name="Subject" type="String" required="NO">
	   <cfargument name="Comment" type="String" required="NO">
	   
	   <cfmail from="dskidmore@epischicago.org" to="dskidmore@epischicago.org" subject="Inquiry from FaithExplorer.net" server="mail.epischicago.org">The following inquiry was made on the FaithExplorer.com website.
		  
Name: #Arguments.Name#
<cfif isDefined("Arguments.Address")>Address: #Arguments.Address# #Arguments.City#, #Arguments.State#</cfif>
<cfif isDefined("arguments.Phone")>Phone: #Arguments.Phone# </cfif>
<cfif IsDefined("Arguments.Email")>Email: #Arguments.Email#</cfif>
<cfif IsDefined("Arguments.Subject")>Subject: #Arguments.Subject#</cfif>
<cfif IsDefined("Arguments.Comment")>
Comment:
--------------------------------------------
#Arguments.Comment#
</cfif>
		  
		  
*******************************************************************************************
This Email was Automatically generated. Please do not hit the reply button.
*******************************************************************************************
</cfmail>
	   
	</cffunction>
	
</cfcomponent>