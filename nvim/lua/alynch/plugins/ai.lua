require("codecompanion").setup {
    adapters = {
        ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
                name = "qwen",
                schema = {
                    model = {
                        default = "qwen2.5-coder:7b"
                    },
                },
            })
        end,
    },
    strategies = {
        chat = {
            adapter = "ollama",
            roles = {
                llm = "Assistant",
                user = "User",
            },
        },
        inline = {
            adapter = "ollama",
        },
    },
}
