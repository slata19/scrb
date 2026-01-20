param(
    [string]$WebhookUrl,
    [string]$Message
)

$payload = @{ text = $Message } | ConvertTo-Json
Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $payload -ContentType 'application/json'
