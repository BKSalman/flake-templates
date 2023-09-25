{
  description = "a bunch of flake templates Salman uses repeatedly and it's kinda getting annoying to copy from old projects";

  outputs = self: {
    templates = {
      generic-rust = {
        path = ./generic-rust;
        description = "generic rust template with most needed things and rust LSP";
      };

      iced = {
        path = ./iced;
        description = "for iced applications development";
      };
    };
  };
}
