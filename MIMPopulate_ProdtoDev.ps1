Clear-Host
Write-Host "Create Declarative Provisioning Rules to populate Development AD Domain"
# -- Create Sync Rule ---
[xml]$SyncRuleXML = @' 
<Lithnet.ResourceManagement.ConfigSync>
  <!-- Sync Rule  -->
  <Operations> 
    <!-- Declare some Objects -->    
	<ResourceOperation operation="None" resourceType="ma-data" id="SyncRuleID">
            <AnchorAttributes>
                <AnchorAttribute>DisplayName</AnchorAttribute>
            </AnchorAttributes>
            <AttributeOperations>
                <AttributeOperation operation="none" name="DisplayName">TargetMADisplayName</AttributeOperation>
				<AttributeOperation operation="none" name="SyncConfig-id"></AttributeOperation>
            </AttributeOperations>
	</ResourceOperation>		
	<!-- Create SynchronizationRule -->
	<ResourceOperation operation="Add Update" resourceType="SynchronizationRule" id="SyncRuleID">
		<AnchorAttributes>
			<AnchorAttribute>DisplayName</AnchorAttribute>
		</AnchorAttributes>
		<AttributeOperations>
		    <AttributeOperation operation="add" name="DisplayName">__OutboundSyncRule</AttributeOperation>
		    <AttributeOperation operation="add" name="Description">OutboundSyncRuleDescription</AttributeOperation>
		    <AttributeOperation operation="add" name="CreateConnectedSystemObject">true</AttributeOperation>
		    <AttributeOperation operation="add" name="CreateILMObject">false</AttributeOperation>
		    <AttributeOperation operation="add" name="FlowType">1</AttributeOperation>
		    <AttributeOperation operation="add" name="DisconnectConnectedSystemObject">true</AttributeOperation>
		    <AttributeOperation operation="add" name="ConnectedSystem">##xmlref:TargetSystem:SyncConfig-id##</AttributeOperation>
		    <AttributeOperation operation="add" name="ConnectedObjectType">user</AttributeOperation>
		    <AttributeOperation operation="add" name="ILMObjectType">person</AttributeOperation>
		    <AttributeOperation operation="add" name="msidmOutboundIsFilterBased">false</AttributeOperation>
		    <AttributeOperation operation="add" name="RelationshipCriteria">&lt;conditions&gt;&lt;condition&gt;&lt;ilmAttribute&gt;accountName&lt;/ilmAttribute&gt;&lt;csAttribute&gt;sAMAccountName&lt;/csAttribute&gt;&lt;/condition&gt;&lt;/conditions&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;department&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;department&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;description&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;description&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;company&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;company&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;department&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;department&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;company&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;company&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;accountName&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;sAMAccountName&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;displayName&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;displayName&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;firstName&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;givenName&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;company&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;company&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;lastName&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;sn&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="PersistentFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;accountName&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;name&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="InitialFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;sourceDN&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;dn&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;fn id="ReplaceString" isCustomExpression="false"&gt;&lt;arg&gt;sourceDN&lt;/arg&gt;&lt;arg&gt;"DC=customer,DC=com,DC=au"&lt;/arg&gt;&lt;arg&gt;"DC=dev,DC=customer,DC=com,DC=au"&lt;/arg&gt;&lt;/fn&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="InitialFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;512&lt;/src&gt;&lt;dest&gt;userAccountControl&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="InitialFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;P@ssw0rd&lt;/src&gt;&lt;dest&gt;unicodePwd&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="InitialFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;sourceDN&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;dn&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;fn id="ReplaceString" isCustomExpression="false"&gt;&lt;arg&gt;sourceDN&lt;/arg&gt;&lt;arg&gt;"DC=customer,DC=com,DC=au"&lt;/arg&gt;&lt;arg&gt;"DC=dev,DC=customer,DC=com,DC=au"&lt;/arg&gt;&lt;/fn&gt;&lt;/export-flow&gt;</AttributeOperation>
		    <AttributeOperation operation="add" name="InitialFlow">&lt;export-flow allows-null="false"&gt;&lt;src&gt;&lt;attr&gt;sourceUPN&lt;/attr&gt;&lt;/src&gt;&lt;dest&gt;userPrincipalName&lt;/dest&gt;&lt;scoping&gt;&lt;/scoping&gt;&lt;fn id="ReplaceString" isCustomExpression="false"&gt;&lt;arg&gt;sourceUPN&lt;/arg&gt;&lt;arg&gt;"@"&lt;/arg&gt;&lt;arg&gt;"@dev."&lt;/arg&gt;&lt;/fn&gt;&lt;/export-flow&gt;</AttributeOperation>
    	</AttributeOperations>
	</ResourceOperation>
 </Operations>
</Lithnet.ResourceManagement.ConfigSync> 
'@

# https://gist.github.com/jpoehls/2726969 
function Edit-XmlNodes {
    param (
        [xml] $doc = $(throw "doc is a required parameter"),
        [string] $xpath = $(throw "xpath is a required parameter"),
        [string] $value = $(throw "value is a required parameter"),
        [bool] $condition = $true
    )    
    if ($condition -eq $true) {
        $nodes = $doc.SelectNodes($xpath)
         
        foreach ($node in $nodes) {
            if ($node -ne $null) {
                if ($node.NodeType -eq "Element") {
                    $node.InnerXml = $value
                }
                else {
                    $node.Value = $value
                }
            }
        }
    }
}


Function Get-Folder($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.rootfolder = "MyComputer"
    if ($foldername.ShowDialog() -eq "OK") {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

# PSM to query MIM Sync Server 
import-module LithnetMIISAutomation 
# PSM to create MIM Service Objects
Import-Module LithnetRMA

# Where will we put the files we generate to create our rules?
$WorkingDirectory = Get-Folder
write-host "Configuration Files will be created in"
$WorkingDirectory[1]

# SyncRule DisplayName 
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$title = 'What do you want to name your Sync Rule?'
$msg = 'Enter your Synchronisation Rule Name:'

$SyncRuleIDDisplayName = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
write-host "The Display Name for the rules is: $SyncRuleIDDisplayName"

# Get all my AD Management Agents
$ADmanagementAgents = Get-ManagementAgent | where-object {$_.category -eq "AD" } | select Name
# Prompt for Target MA for Sync Rule
If ($ADmanagementAgents.Count -gt 1) {
    $title = "Target Management Agent Selection"
    $message = "What is the Target MA for they Sync Rule?"

    # Build the choices menu
    $choices = @()
    For ($index = 0; $index -lt $ADmanagementAgents.Count; $index++) {
        $choices += New-Object System.Management.Automation.Host.ChoiceDescription ($ADmanagementAgents[$index]).Name, ($ADmanagementAgents[$index]).Name
    }
    $options = [System.Management.Automation.Host.ChoiceDescription[]]$choices
    $result = $host.ui.PromptForChoice($title, $message, $options, 0) 

    $targetMA = $ADmanagementAgents[$result]
}

Write-host "Target Management Agent is" $targetMA.Name

#Find all nodes of type "Resource Operation" with attribute ID
$ids = $SyncRuleXML | Select-Xml -Xpath "//ResourceOperation[@id]"
# $ids.node

# Generate ID's for each of the objects we will create
# Sync Rule
$SyncRuleIDName = ($SyncRuleIDDisplayName -replace '[\W]', '') + "-SyncRule"
# Workflow
$WorkflowIDName = ($SyncRuleIDDisplayName -replace '[\W]', '') + "-Workflow"
# Set
$SetIDName = ($SyncRuleIDDisplayName -replace '[\W]', '') + "-Set"
# MPR
$MPRIDName = ($SyncRuleIDDisplayName -replace '[\W]', '') + "-MPR"

# Update SyncRuleID from SyncRuleID to value of the SyncRuleName obtained for the user with spaces removed and -ID1 appended
Edit-XmlNodes $SyncRuleXML -xpath "/Lithnet.ResourceManagement.ConfigSync/Operations/ResourceOperation[@id='SyncRuleID']/@id" -value $SyncRuleIDName
# $SyncRuleXML.'Lithnet.ResourceManagement.ConfigSync'.Operations.ResourceOperation.id
Write-Host "Sync Rule ID $SyncRuleIDName"

#Find the nodes with the DisplayName of the TargetMA and the Sync Rulename 
$displayname = $SyncRuleXML | Select-Xml -Xpath "//AttributeOperation[@name='DisplayName']"
# $displayname.node

# Update the Rule for the Management Agent that the Sync Rule will target to provision against 
$node = $displayname.node | where {$_.'#text' -eq 'TargetMADisplayName'}
$node.'#text' = $targetMA.Name

# Update the Displayname for the desired SyncRule Name 
$node = $displayname.node | where {$_.'#text' -eq '__OutboundSyncRule'}
$node.'#text' = $SyncRuleIDDisplayName

# Get and update the SyncRule Description
$description = $SyncRuleXML | Select-Xml -Xpath "//AttributeOperation[@name='Description']"
$description.node.'#text' = $SyncRuleIDDisplayName

# Get and update the node for the Connected System
$connectedSystems = $SyncRuleXML | Select-Xml -Xpath "//AttributeOperation[@name='ConnectedSystem']"
$connectedSystems.node.'#text' = ("##xmlref:" + $SyncRuleIDName + ":SyncConfig-id##")

# Output the CreateSyncRule input file
$SyncRuleXML.save($WorkingDirectory[1] + "\CreateNewSyncRule.xml")
# Create User Sync Rule 
write-host "Creating Syncrhonization Rule"
Import-RMConfig -File ($WorkingDirectory[1] + "\CreateNewSyncRule.xml") # -Preview -Verbose

# Get the Sync Rule just created and get its ObjectID for the Workflow
$importedSyncRule = Get-Resource SynchronizationRule DisplayName $SyncRuleIDDisplayName | select ObjectID
$importedSyncRuleObjID = [string]$importedSyncRule.ObjectID -replace ("urn:uuid:", "")


# -- WORKFLOW -- 

[xml]$WorkflowXML = @'
<Lithnet.ResourceManagement.ConfigSync>
	<Operations> 
		<!-- Create Workflow -->
		<ResourceOperation operation="Add Update" resourceType="WorkflowDefinition" id="SyncRuleWorkflowID">
			<AnchorAttributes>
				<AnchorAttribute>DisplayName</AnchorAttribute>
			</AnchorAttributes>
			<AttributeOperations>
				<AttributeOperation operation="add" name="DisplayName">SyncRuleWorkflowID</AttributeOperation>  
				<AttributeOperation operation="add" name="Description">WorkflowForOutboundSyncRule</AttributeOperation>  
				<AttributeOperation operation="add" name="XOML" type="file">C:\Path\XOML.xml</AttributeOperation>
				<AttributeOperation operation="add" name="RequestPhase">Action</AttributeOperation>
				<AttributeOperation operation="add" name="RunOnPolicyUpdate">false</AttributeOperation>
			</AttributeOperations>
		</ResourceOperation>
	</Operations>
</Lithnet.ResourceManagement.ConfigSync>
'@

[xml]$WorkflowXOML = @'
<ns0:SequentialWorkflow ActorId="00000000-0000-0000-0000-000000000000" RequestId="00000000-0000-0000-0000-000000000000" x:Name="SequentialWorkflow" TargetId="00000000-0000-0000-0000-000000000000" WorkflowDefinitionId="00000000-0000-0000-0000-000000000000" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" xmlns:ns0="clr-namespace:Microsoft.ResourceManagement.Workflow.Activities;Assembly=Microsoft.ResourceManagement, Version=4.4.1302.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35">
	<ns0:SynchronizationRuleActivity AddValue="{x:Null}" Action="Add" SynchronizationRuleId="1234a4567-ab12-34c5-9988-123456789012" AttributeId="00000000-0000-0000-0000-000000000000" RemoveValue="{x:Null}" x:Name="authenticationGateActivity1">
		<ns0:SynchronizationRuleActivity.Parameters>
			<x:Array Type="{x:Type ns0:SynchronizationRuleParameter}" />
		</ns0:SynchronizationRuleActivity.Parameters>
	</ns0:SynchronizationRuleActivity>
	<ns0:FunctionActivity Description="Populate Originating MA attribute" Destination="[//Target/_originatingMA]" FunctionExpression="&lt;fn id=&quot;SingleValueAssignment&quot;  isCustomExpression=&quot;false&quot;&gt;&lt;arg&gt;[//Target/_source]&lt;/arg&gt;&lt;/fn&gt;" x:Name="authenticationGateActivity2" />
</ns0:SequentialWorkflow>
'@

#Find all nodes of type "Resource Operation" with attribute ID and update
$ids = $WorkflowXML | Select-Xml -Xpath "//ResourceOperation[@id]"
# $ids.node.id
Edit-XmlNodes $WorkflowXML -xpath "/Lithnet.ResourceManagement.ConfigSync/Operations/ResourceOperation[@id='SyncRuleWorkflowID']/@id" -value $WorkflowIDName
# $WorkflowXML.'Lithnet.ResourceManagement.ConfigSync'.Operations.ResourceOperation.id

# Get and update the Workflow DisplayName
$displayname = $WorkflowXML | Select-Xml -Xpath "//AttributeOperation[@name='DisplayName']"
$displayname.node.'#text' = $SyncRuleIDDisplayName + " Workflow"

# Get and update the Workflow Description
$description = $WorkflowXML | Select-Xml -Xpath "//AttributeOperation[@name='Description']"
$description.node.'#text' = "Workflow for " + $SyncRuleIDDisplayName

# Get and update the XOML Path
$xomlpath = $WorkflowXML | Select-Xml -Xpath "//AttributeOperation[@name='XOML']"
$xomlpath.node.'#text' = $WorkingDirectory[1] + "\NewWorkflowXOML.xml"

# Output Workflow
$WorkflowXML.save($WorkingDirectory[1] + "\CreateNewWorkflow.xml")

# Update the Workflow XOML for the corresponding SyncRule ID
$node = $WorkflowXOML.SequentialWorkflow.SynchronizationRuleActivity
$node.SynchronizationRuleId = $importedSyncRuleObjID

# Output Workflow XOML
$WorkflowXOML.save($WorkingDirectory[1] + "\NewWorkflowXOML.xml")

# Create Workflow
write-host "Creating Workflow"
Import-RMConfig -File ($WorkingDirectory[1] + "\CreateNewWorkflow.xml") # -Preview -Verbose


# -- Create Set --

[xml]$SetXML = @'
<Lithnet.ResourceManagement.ConfigSync>
	<Operations> 
		<!-- Create Set -->
		<ResourceOperation operation="Add Update" resourceType="Set" id="SetID">
			<AnchorAttributes>
				<AnchorAttribute>DisplayName</AnchorAttribute>
			</AnchorAttributes>
			<AttributeOperations>
				<AttributeOperation operation="replace" name="DisplayName">__UsersSet</AttributeOperation>
				<AttributeOperation operation="replace" name="Description">Set of Users</AttributeOperation>
				<AttributeOperation operation="replace" name="Filter" type="filter">/Person[_source = 'PRODAD']</AttributeOperation>
			</AttributeOperations>
		</ResourceOperation>
	</Operations>
</Lithnet.ResourceManagement.ConfigSync>
'@

# Get and update SetXML ID
$id = $SetXML | Select-Xml -Xpath "//ResourceOperation[@id='SetID']"
$id.node.id = $SetIDName 

# Get and update the Set DisplayName
$displayname = $SetXML | Select-Xml -Xpath "//AttributeOperation[@name='DisplayName']"
$displayname.node.'#text' = $SyncRuleIDDisplayName + " Set"

# Get and update the Set Description
$description = $SetXML | Select-Xml -Xpath "//AttributeOperation[@name='Description']"
$description.node.'#text' = "Set for " + $SyncRuleIDDisplayName

# Output SetXML File
$SetXML.save($WorkingDirectory[1] + "\NewSet.xml")

# Create the Set
write-host "Creating the Set"
Import-RMConfig -File ($WorkingDirectory[1] + "\NewSet.xml") # -preview -Verbose

# -- Create MPR ---

[xml]$MPRXML = @'
<Lithnet.ResourceManagement.ConfigSync>
  <Operations> 
		<ResourceOperation operation="None" resourceType="Set" id="MPRID">
			<AnchorAttributes>
				  <AnchorAttribute>DisplayName</AnchorAttribute>
			</AnchorAttributes>
			<AttributeOperations>
				  <AttributeOperation operation="replace" name="DisplayName">__SET</AttributeOperation>
			</AttributeOperations>
		</ResourceOperation>
		<ResourceOperation operation="None" resourceType="WorkflowDefinition" id="SyncRuleWorkflowID">
			<AnchorAttributes>
				<AnchorAttribute>DisplayName</AnchorAttribute>
			</AnchorAttributes>
			<AttributeOperations>
				<AttributeOperation operation="replace" name="DisplayName">__Workflow</AttributeOperation>
			</AttributeOperations>
		</ResourceOperation>

		<!-- Create transitionIn MPR -->
		<ResourceOperation operation="Add Update" resourceType="ManagementPolicyRule" id="__MPRID">
			<AnchorAttributes>
				  <AnchorAttribute>DisplayName</AnchorAttribute>
			</AnchorAttributes>
			<AttributeOperations>
				  <AttributeOperation operation="replace" name="DisplayName">__MPR</AttributeOperation>
				  <AttributeOperation operation="replace" name="Description">This MPR adds a Sync Rule to provision users to DEV AD when user connectors are detected in PROD AD</AttributeOperation>
				  <AttributeOperation operation="replace" name="ActionParameter">*</AttributeOperation>
					<AttributeOperation operation="replace" name="ActionType">TransitionIn</AttributeOperation>
					<AttributeOperation operation="replace" name="ActionWorkflowDefinition" type="xmlref">AddInitialLoadOfDEVADUsersSyncRule</AttributeOperation>
					<AttributeOperation operation="replace" name="Disabled">false</AttributeOperation>
					<AttributeOperation operation="replace" name="GrantRight">false</AttributeOperation>
					<AttributeOperation operation="replace" name="ManagementPolicyRuleType">SetTransition</AttributeOperation>
					<AttributeOperation operation="replace" name="ResourceFinalSet" type="xmlref">DEVADUsersSet</AttributeOperation>
			</AttributeOperations>
		</ResourceOperation>
	</Operations>
</Lithnet.ResourceManagement.ConfigSync>
'@

# Get and update the MPR DisplayName's, reference the Tansition Set Displayname and the Workflow DisplayName
$displaynames = $MPRXML  | Select-Xml -Xpath "//AttributeOperation[@name='DisplayName']"
# $displaynames.node

foreach ($name in $displaynames) {
    if ($name.Node.'#text'.Equals("__MPR")) {$name.Node.'#text' = $SyncRuleIDDisplayName + " MPR"}
    if ($name.Node.'#text'.Equals("__Workflow")) {$name.Node.'#text' = $SyncRuleIDDisplayName + " Workflow"}
    if ($name.Node.'#text'.Equals("__SET")) {$name.Node.'#text' = $SyncRuleIDDisplayName + " Set"}
}

# Get and update the MPR Description
$description = $MPRXML | Select-Xml -Xpath "//AttributeOperation[@name='Description']"
$description.node.'#text' = "MPR for " + $SyncRuleIDDisplayName

# Get and update the ID's for the MPR, Set and Workflow referenced by the MPR
$id = $MPRXML | Select-Xml -Xpath "//ResourceOperation[@id]"
# $id.node
foreach ($idname in $id) {
    if ($idname.Node.id.Equals("__MPRID")) {$idname.Node.id = $MPRIDName } #MPR
    if ($idname.Node.id.Equals("MPRID")) {$idname.Node.id = $SetIDName} #SET
    if ($idname.Node.id.Equals("SyncRuleWorkflowID")) {$idname.Node.id = $WorkflowIDName} #Workflow
}

# Update Action Worflow Definition Text
$actionwf = $MPRXML | Select-Xml -Xpath "//AttributeOperation[@name='ActionWorkflowDefinition']"
$actionwf.Node.'#text' = $WorkflowIDName

# Update the Resultant Set
$resultantset = $MPRXML | Select-Xml -Xpath "//AttributeOperation[@name='ResourceFinalSet']"
$resultantset.Node.'#text' = $SetIDName

# Output MPR XML File
$MPRXML.save($WorkingDirectory[1] + "\CreateNewMPR.xml")

# Create MPR
write-host "Creating the MPR"
Import-RMConfig -File ($WorkingDirectory[1] + "\CreateNewMPR.xml") # -Preview -Verbose

Write-host "Complete" 