self: super:
  { pandoc-tags = self.callCabal2nix "pandoc-tags" ./. {};
  }

