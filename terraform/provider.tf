terraform {
  required_providers {
    fly = {
      source  = "fly-apps/fly"
      version = "0.0.20"
    }
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.3"
    }
  }
}


provider "fly" {
  useinternaltunnel    = true
  internaltunnelorg    = "personal"
  internaltunnelregion = "ewr"
}

provider "b2" {
}
