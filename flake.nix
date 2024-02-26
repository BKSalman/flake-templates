{
  description = "a bunch of flake templates Salman uses repeatedly and it's kinda getting annoying to copy from old projects";

  outputs = self: {
    templates = {
      rust = {
        path = ./rust;
        description = "generic rust template with rustc cargo and rust-analyzer";
      };

      rust-mold = {
        path = ./rust-mold;
        description = "rust template + mold linker";
      };

      iced = {
        path = ./iced;
        description = "for iced applications development";
      };

      egui = {
        path = ./egui;
        description = "for egui applications development";
      };

      c = {
        path = ./c;
        description = "basic C development environment";
      };
    };
  };
}
