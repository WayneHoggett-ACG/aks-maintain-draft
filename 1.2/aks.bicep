param location string = resourceGroup().location
param osDiskSizeGB int = 128
param agentCount int = 1
param agentVMSize string = 'Standard_D2s_v3'
param osTypeLinux string = 'Linux'
param kubernetesVersion string

var uniqueSuffix = uniqueString(resourceGroup().id)

resource aksCluster 'Microsoft.ContainerService/managedClusters@2024-06-02-preview' = {
  location: location
  name: 'aks-${uniqueSuffix}'
  tags: {
    displayname: 'AKS Cluster'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enableRBAC: true
    dnsPrefix: 'aks-${uniqueSuffix}'
    kubernetesVersion: kubernetesVersion
    agentPoolProfiles: [
      {
        name: 'syspool'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: osTypeLinux
        type: 'VirtualMachineScaleSets'
        mode: 'System'
      }
    ]
  }
}
