# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a ServiceBus Queue
.Description
Updates a ServiceBus Queue
#>

function Set-AzServiceBusQueue{
	[OutputType([Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Models.ISbQueue])]
    [CmdletBinding(DefaultParameterSetName = 'SetExpanded', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
	param(
		[Parameter(ParameterSetName = 'SetExpanded', Mandatory, HelpMessage = "The name of the Queue.")]
        [Alias('QueueName')]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Path')]
        [System.String]
        # The name of the Queue.
        ${Name},

        [Parameter(ParameterSetName = 'SetExpanded', Mandatory, HelpMessage = "The name of ServiceBus namespace")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Path')]
        [System.String]
        # The name of ServiceBus namespace
        ${NamespaceName},

        [Parameter(ParameterSetName = 'SetExpanded', Mandatory, HelpMessage = "The name of the resource group. The name is case insensitive.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Path')]
        [System.String]
        # The name of the resource group.
        # The name is case insensitive.
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'SetExpanded', HelpMessage = "The ID of the target subscription.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Runtime.DefaultInfo(Script = '(Get-AzContext).Subscription.Id')]
        [System.String]
        # The ID of the target subscription.
        ${SubscriptionId},

        [Parameter(ParameterSetName = 'SetViaIdentityExpanded', Mandatory, ValueFromPipeline, HelpMessage = "Identity parameter. To construct, see NOTES section for INPUTOBJECT properties and create a hash table.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Models.IServiceBusIdentity]
        # Identity Parameter
        # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
        ${InputObject},

        [Parameter(HelpMessage = "ISO 8061 timeSpan idle interval after which the queue is automatically deleted. The minimum duration is 5 minutes.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.TimeSpan]
        # timeSpan.
        ${AutoDeleteOnIdle},

        [Parameter(HelpMessage = "ISO 8601 default message timespan to live value. This is the duration after which the message expires, starting from when the message is sent to Service Bus. This is the default value used when TimeToLive is not set on a message itself.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.TimeSpan]
        # timeSpan.
        ${DefaultMessageTimeToLive},

        [Parameter(HelpMessage = "ISO 8601 timeSpan structure that defines the duration of the duplicate detection history. The default value is 10 minutes.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.TimeSpan]
        # timeSpan.
        ${DuplicateDetectionHistoryTimeWindow},

        [Parameter(HelpMessage = "ISO 8601 timespan duration of a peek-lock; that is, the amount of time that the message is locked for other receivers. The maximum value for LockDuration is 5 minutes; the default value is 1 minute.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.TimeSpan]
        # timeSpan.
        ${LockDuration},

        [Parameter(HelpMessage = "A value that indicates whether this queue has dead letter support when a message expires.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # A value that indicates whether this queue has dead letter support when a message expires.
        ${DeadLetteringOnMessageExpiration},

        [Parameter(HelpMessage = "Value that indicates whether server-side batched operations are enabled.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # Value that indicates whether server-side batched operations are enabled.
        ${EnableBatchedOperations},

        [Parameter(HelpMessage = "A value that indicates whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Management.Automation.SwitchParameter]
        # A value that indicates whether Express Entities are enabled. An express queue holds a message in memory temporarily before writing it to persistent storage.
        ${EnableExpress},

        [Parameter(HelpMessage = "Queue/Topic name to forward the messages")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.String]
        # Queue/Topic name to forward the messages
        ${ForwardTo},

        [Parameter(HelpMessage = "A value that indicates whether the queue supports the concept of sessions.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.String]
        # A value that indicates whether the queue supports the concept of sessions.
        ${ForwardDeadLetteredMessagesTo},

        [Parameter(HelpMessage = "The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Int32]
        # The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.
        ${MaxDeliveryCount},

        [Parameter(HelpMessage = "The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Int32]
        # The maximum delivery count. A message is automatically deadlettered after this number of deliveries. default value is 10.
        ${MaxSizeInMegabytes},

        [Parameter(HelpMessage = "Maximum size (in KB) of the message payload that can be accepted by the queue. This property is only used in Premium today and default is 1024.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.Int64]
        # Maximum size (in KB) of the message payload that can be accepted by the queue. This property is only used in Premium today and default is 1024.
        ${MaxMessageSizeInKilobytes},

        [Parameter(HelpMessage = "Enumerates the possible values for the status of a messaging entity.")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Body')]
        [System.String]
        ${Status},

        
        [Parameter(HelpMessage = "The credentials, account, tenant, and subscription used for communication with Azure.")]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter(HelpMessage = "Run the command as a job")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter(HelpMessage = "Run the command asynchronously")]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.ServiceBus.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
	)

    process{
        try{
            $hasAutoDeleteOnIdle = $PSBoundParameters.Remove('AutoDeleteOnIdle')
            $hasDefaultMessageTimeToLive = $PSBoundParameters.Remove('DefaultMessageTimeToLive')
            $hasDeadLetteringOnMessageExpiration = $PSBoundParameters.Remove('DeadLetteringOnMessageExpiration')
            $hasDuplicateDetectionHistoryTimeWindow = $PSBoundParameters.Remove('DuplicateDetectionHistoryTimeWindow')
            $hasLockDuration = $PSBoundParameters.Remove('LockDuration')
            $hasEnableBatchedOperations = $PSBoundParameters.Remove('EnableBatchedOperations')
            $hasEnableExpress = $PSBoundParameters.Remove('EnableExpress')
            $hasForwardDeadLetteredMessagesTo = $PSBoundParameters.Remove('ForwardDeadLetteredMessagesTo')
            $hasForwardTo = $PSBoundParameters.Remove('ForwardTo')
            $hasMaxDeliveryCount = $PSBoundParameters.Remove('MaxDeliveryCount')
            $hasMaxMessageSizeInKilobytes = $PSBoundParameters.Remove('MaxMessageSizeInKilobytes')
            $hasMaxSizeInMegabytes = $PSBoundParameters.Remove('MaxSizeInMegabytes')
            $hasStatus = $PSBoundParameters.Remove('Status')
            $hasAsJob = $PSBoundParameters.Remove('AsJob')
            $null = $PSBoundParameters.Remove('WhatIf')
            $null = $PSBoundParameters.Remove('Confirm')

            $queue = Get-AzServiceBusQueue @PSBoundParameters

            # 2. PUT
            $null = $PSBoundParameters.Remove('InputObject')
            $null = $PSBoundParameters.Remove('ResourceGroupName')
            $null = $PSBoundParameters.Remove('NamespaceName')
            $null = $PSBoundParameters.Remove('Name')
            $null = $PSBoundParameters.Remove('SubscriptionId')

            $hasProperty = $false

            if ($hasAutoDeleteOnIdle) {
                $queue.AutoDeleteOnIdle = $AutoDeleteOnIdle
                $hasProperty = $true
            }
            if ($hasDefaultMessageTimeToLive) {
                $queue.DefaultMessageTimeToLive = $DefaultMessageTimeToLive
                $hasProperty = $true
            }
            if ($hasDeadLetteringOnMessageExpiration) {
                $queue.DeadLetteringOnMessageExpiration = $DeadLetteringOnMessageExpiration
                $hasProperty = $true
            }
            if ($hasDuplicateDetectionHistoryTimeWindow) {
                $queue.DuplicateDetectionHistoryTimeWindow = $DuplicateDetectionHistoryTimeWindow
                $hasProperty = $true
            }
            if ($hasLockDuration) {
                $queue.LockDuration = $LockDuration
                $hasProperty = $true
            }
            if ($hasEnableBatchedOperations) {
                $queue.EnableBatchedOperations = $EnableBatchedOperations
                $hasProperty = $true
            }
            if ($hasEnableExpress) {
                $queue.EnableExpress = $EnableExpress
                $hasProperty = $true
            }
            if ($hasForwardDeadLetteredMessagesTo) {
                $queue.ForwardDeadLetteredMessagesTo = $ForwardDeadLetteredMessagesTo
                $hasProperty = $true
            }
            if ($hasForwardTo) {
                $queue.ForwardTo = $ForwardTo
                $hasProperty = $true
            }
            if ($hasMaxDeliveryCount) {
                $queue.MaxDeliveryCount = $MaxDeliveryCount
                $hasProperty = $true
            }
            if ($hasMaxMessageSizeInKilobytes) {
                $queue.MaxMessageSizeInKilobytes = $MaxMessageSizeInKilobytes
                $hasProperty = $true
            }
            if ($hasMaxSizeInMegabytes) {
                $queue.MaxSizeInMegabytes = $MaxSizeInMegabytes
                $hasProperty = $true
            }
            if ($hasStatus) {
                $queue.Status = $Status
                $hasProperty = $true
            }

            if (($hasProperty -eq $false) -and ($PSCmdlet.ParameterSetName -eq 'SetViaIdentityExpanded')){
                throw 'Please specify the property you want to update on the -InputObject. Refer https://go.microsoft.com/fwlink/?linkid=2204584#behavior-of--inputobject for example.'
            }

            if ($hasAsJob) {
                $PSBoundParameters.Add('AsJob', $true)
            }

            if ($PSCmdlet.ShouldProcess("ServiceBus Queue $($queue.Name)", "Create or update")) {
                Az.ServiceBus.private\New-AzServiceBusQueue_CreateViaIdentity -InputObject $queue -Parameter $queue @PSBoundParameters
            }
        }
        catch{
            throw
        }
    }
}
# SIG # Begin signature block
# MIIoUgYJKoZIhvcNAQcCoIIoQzCCKD8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCPmXRStyu+zzoo
# eZgOnWOXcF6lV9mddRf3HIQLzLQTI6CCDYUwggYDMIID66ADAgECAhMzAAAEA73V
# lV0POxitAAAAAAQDMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjQwOTEyMjAxMTEzWhcNMjUwOTExMjAxMTEzWjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCfdGddwIOnbRYUyg03O3iz19XXZPmuhEmW/5uyEN+8mgxl+HJGeLGBR8YButGV
# LVK38RxcVcPYyFGQXcKcxgih4w4y4zJi3GvawLYHlsNExQwz+v0jgY/aejBS2EJY
# oUhLVE+UzRihV8ooxoftsmKLb2xb7BoFS6UAo3Zz4afnOdqI7FGoi7g4vx/0MIdi
# kwTn5N56TdIv3mwfkZCFmrsKpN0zR8HD8WYsvH3xKkG7u/xdqmhPPqMmnI2jOFw/
# /n2aL8W7i1Pasja8PnRXH/QaVH0M1nanL+LI9TsMb/enWfXOW65Gne5cqMN9Uofv
# ENtdwwEmJ3bZrcI9u4LZAkujAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQU6m4qAkpz4641iK2irF8eWsSBcBkw
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzUwMjkyNjAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# AFFo/6E4LX51IqFuoKvUsi80QytGI5ASQ9zsPpBa0z78hutiJd6w154JkcIx/f7r
# EBK4NhD4DIFNfRiVdI7EacEs7OAS6QHF7Nt+eFRNOTtgHb9PExRy4EI/jnMwzQJV
# NokTxu2WgHr/fBsWs6G9AcIgvHjWNN3qRSrhsgEdqHc0bRDUf8UILAdEZOMBvKLC
# rmf+kJPEvPldgK7hFO/L9kmcVe67BnKejDKO73Sa56AJOhM7CkeATrJFxO9GLXos
# oKvrwBvynxAg18W+pagTAkJefzneuWSmniTurPCUE2JnvW7DalvONDOtG01sIVAB
# +ahO2wcUPa2Zm9AiDVBWTMz9XUoKMcvngi2oqbsDLhbK+pYrRUgRpNt0y1sxZsXO
# raGRF8lM2cWvtEkV5UL+TQM1ppv5unDHkW8JS+QnfPbB8dZVRyRmMQ4aY/tx5x5+
# sX6semJ//FbiclSMxSI+zINu1jYerdUwuCi+P6p7SmQmClhDM+6Q+btE2FtpsU0W
# +r6RdYFf/P+nK6j2otl9Nvr3tWLu+WXmz8MGM+18ynJ+lYbSmFWcAj7SYziAfT0s
# IwlQRFkyC71tsIZUhBHtxPliGUu362lIO0Lpe0DOrg8lspnEWOkHnCT5JEnWCbzu
# iVt8RX1IV07uIveNZuOBWLVCzWJjEGa+HhaEtavjy6i7MIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGiMwghofAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAAQDvdWVXQ87GK0AAAAA
# BAMwDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIGDx
# 20PjFqyFNt9XyF/yyFfXCI+GFpkcWpeW1fm3//aLMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAbAZHPurzItjPzAtQza3ijYS+l0zKFf1P/yPr
# hCnM5zb16HUdJ7YM4zQAe/YZaJk51r+qhmiY8xQVQfP82RWRvcs19jz62cRX7C6i
# uFWyiqcjy0DJLfiJFwWkofdKUHcvgr7Y7SN+dJJOojjkSre6X6iRu41dq8PGwxpN
# QrYUiNjvZe5JH838Z1x9sTl9Z1BjRclnBfa3je8xALNgthUIDRCZre9DZeLLiy+r
# ZeWqoYCu8P3qIzJwbP8DHKT7RA8n7qYZX99k6RKPLnImFKVBgrjCGv76je9Sjiiw
# 2z1ZlRe8iMcztnecUIsfWQQY3KNWpg97944pCGQsyduBHEHCnaGCF60wghepBgor
# BgEEAYI3AwMBMYIXmTCCF5UGCSqGSIb3DQEHAqCCF4YwgheCAgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFaBgsqhkiG9w0BCRABBKCCAUkEggFFMIIBQQIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCAec2FlFSAV5uV5ddASzY3VX8JFLpYWkGyz
# vmMNLNRIJgIGZ7YziYMYGBMyMDI1MDIyNTA3MDMzNS4yODNaMASAAgH0oIHZpIHW
# MIHTMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQL
# EyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJzAlBgNVBAsT
# Hm5TaGllbGQgVFNTIEVTTjoyRDFBLTA1RTAtRDk0NzElMCMGA1UEAxMcTWljcm9z
# b2Z0IFRpbWUtU3RhbXAgU2VydmljZaCCEfswggcoMIIFEKADAgECAhMzAAAB/XP5
# aFrNDGHtAAEAAAH9MA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1w
# IFBDQSAyMDEwMB4XDTI0MDcyNTE4MzExNloXDTI1MTAyMjE4MzExNlowgdMxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jv
# c29mdCBJcmVsYW5kIE9wZXJhdGlvbnMgTGltaXRlZDEnMCUGA1UECxMeblNoaWVs
# ZCBUU1MgRVNOOjJEMUEtMDVFMC1EOTQ3MSUwIwYDVQQDExxNaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBTZXJ2aWNlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
# oWWs+D+Ou4JjYnRHRedu0MTFYzNJEVPnILzc02R3qbnujvhZgkhp+p/lymYLzkQy
# G2zpxYceTjIF7HiQWbt6FW3ARkBrthJUz05ZnKpcF31lpUEb8gUXiD2xIpo8YM+S
# D0S+hTP1TCA/we38yZ3BEtmZtcVnaLRp/Avsqg+5KI0Kw6TDJpKwTLl0VW0/23sK
# ikeWDSnHQeTprO0zIm/btagSYm3V/8zXlfxy7s/EVFdSglHGsUq8EZupUO8XbHzz
# 7tURyiD3kOxNnw5ox1eZX/c/XmW4H6b4yNmZF0wTZuw37yA1PJKOySSrXrWEh+H6
# ++Wb6+1ltMCPoMJHUtPP3Cn0CNcNvrPyJtDacqjnITrLzrsHdOLqjsH229Zkvndk
# 0IqxBDZgMoY+Ef7ffFRP2pPkrF1F9IcBkYz8hL+QjX+u4y4Uqq4UtT7VRnsqvR/x
# /+QLE0pcSEh/XE1w1fcp6Jmq8RnHEXikycMLN/a/KYxpSP3FfFbLZuf+qIryFL0g
# EDytapGn1ONjVkiKpVP2uqVIYj4ViCjy5pLUceMeqiKgYqhpmUHCE2WssLLhdQBH
# dpl28+k+ZY6m4dPFnEoGcJHuMcIZnw4cOwixojROr+Nq71cJj7Q4L0XwPvuTHQt0
# oH7RKMQgmsy7CVD7v55dOhdHXdYsyO69dAdK+nWlyYcCAwEAAaOCAUkwggFFMB0G
# A1UdDgQWBBTpDMXA4ZW8+yL2+3vA6RmU7oEKpDAfBgNVHSMEGDAWgBSfpxVdAF5i
# XYP05dJlpxtTNRnpcjBfBgNVHR8EWDBWMFSgUqBQhk5odHRwOi8vd3d3Lm1pY3Jv
# c29mdC5jb20vcGtpb3BzL2NybC9NaWNyb3NvZnQlMjBUaW1lLVN0YW1wJTIwUENB
# JTIwMjAxMCgxKS5jcmwwbAYIKwYBBQUHAQEEYDBeMFwGCCsGAQUFBzAChlBodHRw
# Oi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY3Jvc29mdCUyMFRp
# bWUtU3RhbXAlMjBQQ0ElMjAyMDEwKDEpLmNydDAMBgNVHRMBAf8EAjAAMBYGA1Ud
# JQEB/wQMMAoGCCsGAQUFBwMIMA4GA1UdDwEB/wQEAwIHgDANBgkqhkiG9w0BAQsF
# AAOCAgEAY9hYX+T5AmCrYGaH96TdR5T52/PNOG7ySYeopv4flnDWQLhBlravAg+p
# jlNv5XSXZrKGv8e4s5dJ5WdhfC9ywFQq4TmXnUevPXtlubZk+02BXK6/23hM0TSK
# s2KlhYiqzbRe8QbMfKXEDtvMoHSZT7r+wI2IgjYQwka+3P9VXgERwu46/czz8IR/
# Zq+vO5523Jld6ssVuzs9uwIrJhfcYBj50mXWRBcMhzajLjWDgcih0DuykPcBpoTL
# lOL8LpXooqnr+QLYE4BpUep3JySMYfPz2hfOL3g02WEfsOxp8ANbcdiqM31dm3vS
# heEkmjHA2zuM+Tgn4j5n+Any7IODYQkIrNVhLdML09eu1dIPhp24lFtnWTYNaFTO
# fMqFa3Ab8KDKicmp0AthRNZVg0BPAL58+B0UcoBGKzS9jscwOTu1JmNlisOKkVUV
# kSJ5Fo/ctfDSPdCTVaIXXF7l40k1cM/X2O0JdAS97T78lYjtw/PybuzX5shxBh/R
# qTPvCyAhIxBVKfN/hfs4CIoFaqWJ0r/8SB1CGsyyIcPfEgMo8ceq1w5Zo0JfnyFi
# 6Guo+z3LPFl/exQaRubErsAUTfyBY5/5liyvjAgyDYnEB8vHO7c7Fg2tGd5hGgYs
# +AOoWx24+XcyxpUkAajDhky9Dl+8JZTjts6BcT9sYTmOodk/SgIwggdxMIIFWaAD
# AgECAhMzAAAAFcXna54Cm0mZAAAAAAAVMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYD
# VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEe
# MBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3Nv
# ZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMDAeFw0yMTA5MzAxODIy
# MjVaFw0zMDA5MzAxODMyMjVaMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA5OGmTOe0ciELeaLL1yR5
# vQ7VgtP97pwHB9KpbE51yMo1V/YBf2xK4OK9uT4XYDP/XE/HZveVU3Fa4n5KWv64
# NmeFRiMMtY0Tz3cywBAY6GB9alKDRLemjkZrBxTzxXb1hlDcwUTIcVxRMTegCjhu
# je3XD9gmU3w5YQJ6xKr9cmmvHaus9ja+NSZk2pg7uhp7M62AW36MEBydUv626GIl
# 3GoPz130/o5Tz9bshVZN7928jaTjkY+yOSxRnOlwaQ3KNi1wjjHINSi947SHJMPg
# yY9+tVSP3PoFVZhtaDuaRr3tpK56KTesy+uDRedGbsoy1cCGMFxPLOJiss254o2I
# 5JasAUq7vnGpF1tnYN74kpEeHT39IM9zfUGaRnXNxF803RKJ1v2lIH1+/NmeRd+2
# ci/bfV+AutuqfjbsNkz2K26oElHovwUDo9Fzpk03dJQcNIIP8BDyt0cY7afomXw/
# TNuvXsLz1dhzPUNOwTM5TI4CvEJoLhDqhFFG4tG9ahhaYQFzymeiXtcodgLiMxhy
# 16cg8ML6EgrXY28MyTZki1ugpoMhXV8wdJGUlNi5UPkLiWHzNgY1GIRH29wb0f2y
# 1BzFa/ZcUlFdEtsluq9QBXpsxREdcu+N+VLEhReTwDwV2xo3xwgVGD94q0W29R6H
# XtqPnhZyacaue7e3PmriLq0CAwEAAaOCAd0wggHZMBIGCSsGAQQBgjcVAQQFAgMB
# AAEwIwYJKwYBBAGCNxUCBBYEFCqnUv5kxJq+gpE8RjUpzxD/LwTuMB0GA1UdDgQW
# BBSfpxVdAF5iXYP05dJlpxtTNRnpcjBcBgNVHSAEVTBTMFEGDCsGAQQBgjdMg30B
# ATBBMD8GCCsGAQUFBwIBFjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3Bz
# L0RvY3MvUmVwb3NpdG9yeS5odG0wEwYDVR0lBAwwCgYIKwYBBQUHAwgwGQYJKwYB
# BAGCNxQCBAweCgBTAHUAYgBDAEEwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMB
# Af8wHwYDVR0jBBgwFoAU1fZWy4/oolxiaNE9lJBb186aGMQwVgYDVR0fBE8wTTBL
# oEmgR4ZFaHR0cDovL2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMv
# TWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3JsMFoGCCsGAQUFBwEBBE4wTDBKBggr
# BgEFBQcwAoY+aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcnQwDQYJKoZIhvcNAQELBQADggIBAJ1Vffwq
# reEsH2cBMSRb4Z5yS/ypb+pcFLY+TkdkeLEGk5c9MTO1OdfCcTY/2mRsfNB1OW27
# DzHkwo/7bNGhlBgi7ulmZzpTTd2YurYeeNg2LpypglYAA7AFvonoaeC6Ce5732pv
# vinLbtg/SHUB2RjebYIM9W0jVOR4U3UkV7ndn/OOPcbzaN9l9qRWqveVtihVJ9Ak
# vUCgvxm2EhIRXT0n4ECWOKz3+SmJw7wXsFSFQrP8DJ6LGYnn8AtqgcKBGUIZUnWK
# NsIdw2FzLixre24/LAl4FOmRsqlb30mjdAy87JGA0j3mSj5mO0+7hvoyGtmW9I/2
# kQH2zsZ0/fZMcm8Qq3UwxTSwethQ/gpY3UA8x1RtnWN0SCyxTkctwRQEcb9k+SS+
# c23Kjgm9swFXSVRk2XPXfx5bRAGOWhmRaw2fpCjcZxkoJLo4S5pu+yFUa2pFEUep
# 8beuyOiJXk+d0tBMdrVXVAmxaQFEfnyhYWxz/gq77EFmPWn9y8FBSX5+k77L+Dvk
# txW/tM4+pTFRhLy/AsGConsXHRWJjXD+57XQKBqJC4822rpM+Zv/Cuk0+CQ1Zyvg
# DbjmjJnW4SLq8CdCPSWU5nR0W2rRnj7tfqAxM328y+l7vzhwRNGQ8cirOoo6CGJ/
# 2XBjU02N7oJtpQUQwXEGahC0HVUzWLOhcGbyoYIDVjCCAj4CAQEwggEBoYHZpIHW
# MIHTMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMS0wKwYDVQQL
# EyRNaWNyb3NvZnQgSXJlbGFuZCBPcGVyYXRpb25zIExpbWl0ZWQxJzAlBgNVBAsT
# Hm5TaGllbGQgVFNTIEVTTjoyRDFBLTA1RTAtRDk0NzElMCMGA1UEAxMcTWljcm9z
# b2Z0IFRpbWUtU3RhbXAgU2VydmljZaIjCgEBMAcGBSsOAwIaAxUAoj0WtVVQUNSK
# oqtrjinRAsBUdoOggYMwgYCkfjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAx
# MDANBgkqhkiG9w0BAQsFAAIFAOtnSSAwIhgPMjAyNTAyMjQxOTM4MDhaGA8yMDI1
# MDIyNTE5MzgwOFowdDA6BgorBgEEAYRZCgQBMSwwKjAKAgUA62dJIAIBADAHAgEA
# AgIN8TAHAgEAAgITwTAKAgUA62iaoAIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgor
# BgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBCwUA
# A4IBAQCdfAwUfQuWHzYzALDc8y4Ji8y5WpqnI3pfzb6hEFrmpYbYJSrLp7bAGRil
# loZ9N6YbSm/2clJ8QPLgN7nQOSxdBBzPL8FvcvBZ8J4CNIr90iWoKBSHRQ3hNhIK
# mDy4siO2oCyGvqT9GHPKGXd19pUU7Q0VSFGoRjDjFXA3ESaUc8Mp4sDVXugy11o0
# H3mPT3EN86e/yTxqmpWix++NT9sq0gNGBYSo/9DuYDEoo0NbUXOMpeYxxsxQZ1Oz
# 8ITIQyGDh8nLcP1PrIyxalZZNQ//5hlinly6WGCOYSvCkzrRsxkQnCawdNeS9LIA
# /Xui4plvbqmceNm249cugJk1cWiTMYIEDTCCBAkCAQEwgZMwfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTACEzMAAAH9c/loWs0MYe0AAQAAAf0wDQYJYIZIAWUD
# BAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0B
# CQQxIgQgpQOr6jG/oXFHCf88LIECgmjbYCDbIp9GXL/iO3QaPsMwgfoGCyqGSIb3
# DQEJEAIvMYHqMIHnMIHkMIG9BCCAKEgNyUowvIfx/eDfYSupHkeF1p6GFwjKBs8l
# RB4NRzCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB
# /XP5aFrNDGHtAAEAAAH9MCIEIGMMEmW8AWZK8dcqdScwngTjlnWSoJ4cL1qjbx5B
# pIPkMA0GCSqGSIb3DQEBCwUABIICABscoEjwqzeF65hCv7awt+aa4iJd3OOEhlB/
# KFDVmy5eLyzrlm920+a1QWjRLEOrSWTfr5KGf9AdLJ2fYXKVZ8X/XJayflP38Xsr
# cc94ofLAbG1HTa+7toFqAwGNdQT2+q0tucCIz2/A17faoO0vQnyRDsAb8lofMxZG
# SWp9QosAF4wh1EAcD7zgoRNAWCBLf2wJm+zB+O4BRnBhT+cuPPMUESp7qmFJwaT7
# fv3VwX6AwnwcVshzDPiuDHtbxAMfBi+KjY5FM0lwW3A4VEGSpk+1JyWYTI0QhLGg
# RggpQR3pTgNAIh5erWQdU3WNx3El5cTmmwBRnAuxpkeaJTJFOebTK6vGifibDK1M
# kRGMJSuRviGC4+zASk62kPn4qohG5Ie4cDhszWwoSyG81cFUpxkRC0vwwelb+3AU
# ScTEoJSPq4CoNP5eEoo5hMPeEe6sEcgd+w22XY5HDx+141a2gBBQyW+lDQr3bH+d
# CDFrly8A6Zob+P3soTHruR471+et/h206/GuAPWN6qa1ZTqvl1RDZbl+s5GQLSHs
# aVmCjJAmg1Q7aJVSbC5UNElgxXXqB21f7ALx4JtAYvxb31KZgjlSDBVUiB4HZHOG
# IqM1SQWu78Nu6uMZccegWaa+/NL8txUqGuK3VH9l6HjG4dpzO/SHQ0Cf23qO3KjI
# zhrHiVxl
# SIG # End signature block
