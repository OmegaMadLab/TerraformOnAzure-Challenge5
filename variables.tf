variable "location" {
    description = "Azure region"
    default = "westeurope"
}

variable "envprefix" {
    description = "Used to compose the final name of the resources"
    default = "tfonazure-challenge5-"
}

variable "aksname" {
    description = "The name of the AKS cluster deployed in challenge4"
    default = "omegamadlab-tfonaz-4-aks"
}

variable "aksrgname" {
    description = "The name of the resource group that hosts the AKS cluster deployed in challenge4"
    default = "tfonazure-challenge4-RG"
}