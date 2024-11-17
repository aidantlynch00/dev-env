local gp_defaults = require("gp.defaults")

require("gp").setup({
    providers = {
        openai = {
            disable = true,
        },
        ollama = {
            disable = false,
            endpoint = "http://localhost:11434/v1/chat/completions",
            secret = "dummy_secret"
        },
    },
    default_command_agent = "Qwen",
    default_chat_agent = "Llama",
    agents = {
        {
            provider = "ollama",
            name = "Qwen",
            chat = true,
            command = true,
            model = {
                model = "qwen2.5-coder:7b",
            },
            system_prompt = gp_defaults.code_system_prompt,
        },
        {
            provider = "ollama",
            name = "Llama",
            chat = true,
            command = false,
            model = {
                model = "llama3.2:3b",
            },
            system_prompt = gp_defaults.chat_system_prompt,
        },
        -- disable the other default ollama agents
        {
            name = "ChatOllamaLlama3.1-8B",
            disable = true
        },
        {
            name = "CodeOllamaLlama3.1-8B",
            disable = true
        }
    },
    hooks = {
        -- example of adding command which explains the selected code
		Explain = function(gp, params)
			local template = "I have the following code from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please respond by explaining the code above."
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.vnew("markdown"), agent, template)
		end,
    },
})
