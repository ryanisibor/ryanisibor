$ResultSet = @()
$Subs = "US-PROD-SAP", "US-PROD-EDW", "US-PROD-CORE-SERVICES", "US-PROD-CYBERSECURITY"
$Roles = "Owner","Contributor","qrg_az_nonetwork_contributor","qrg_az_oms_contributor","qrg_az_support_contributor","Role Based Access Control Administrator","User Access Administrator","Storage Blob Data Reader","Storage Blob Data Contributor","Storage Blob Data Owner","SQL DB Data Reader","SQL DB Data Contributor","SQL DB Contributor"
foreach ($Sub in $subs) { 
    Set-AzContext $Sub
    $Results   = @()
    $Results   = Get-AzRoleAssignment | Where-Object -Property RoleDefinitionName -in -Value $Roles 
    $Results | ForEach-Object{
        $_ | Add-Member -MemberType NoteProperty -Name "Subscription" -Value "$Sub"
    }
    $ResultSet += $Results
}
#$ResultSet | Select-Object Subscription, Scope, SignInName, DisplayName, ObjectType, ObjectId, RoleDefinitionName | Format-Table -AutoSize > SoxReview.csv
$ResultSet | Select-Object Subscription, Scope, SignInName, DisplayName, ObjectType, ObjectId, RoleDefinitionName | ConvertTo-Csv -NoTypeInformation > SoxReview.csv
