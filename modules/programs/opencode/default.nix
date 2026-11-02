{
  flake.homeModules.opencode = {
    programs.opencode = {
      enable = true;

      settings = {
        update = "disable";

        providers.openrouter = {
          models = { };
        };

        mcp.servers = {
          context7 = {
            type = "remote";
            url = "https://mcp.context7.com/mcp";
          };
          github = {
            type = "remote";
            url = "https://api.githubcopilot.com/mcp";
            oauth = false;
            headers.Authorization = "Bearer {env:GITHUB_PAT}";
          };
          brave = {
            type = "local";
            command = [ "npx" "@brave/brave-search-mcp-server" "--transport" "stdio" ];
          };
        };

        agents = {
          plan.permissions = [
            { action = "context7_*"; resource = "*"; effect = "allow"; }
            { action = "brave_web_search"; resource = "*"; effect = "allow"; }
            { action = "github_*"; resource = "*"; effect = "allow"; }
          ];

          build.permissions = [
            { action = "context7_*"; resource = "*"; effect = "allow"; }
            { action = "brave_web_search"; resource = "*"; effect = "allow"; }
            { action = "github_*"; resource = "*"; effect = "allow"; }
          ];
        };

        permissions = [
          { action = "shell"; resource = "*"; effect = "ask"; }
          { action = "context7_*"; resource = "*"; effect = "deny"; }
          { action = "brave_*"; resource = "*"; effect = "ask"; }
          { action = "websearch"; resource = "*"; effect = "deny"; }
          { action = "external_directory"; resource = "*"; effect = "ask"; }
        ];
      };

      cli = {
        theme = {
          name = "tokyonight";
          mode = "system";
        };
      };

      agents = ./agents;
      commands = ./commands;
    };
  };
}
