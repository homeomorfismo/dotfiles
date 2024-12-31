$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 1_000
$env.config.show_banner = false
$env.config.recursion_limit = 10

$env.config.edit_mode = "hx"

$env.config.completions.algorithm = "fuzzy"

$env.config.float_precision = 4

# Prompt
$env.PROMPT_COMMAND = {|| pwd}
$env.PROMPT_COMMAND_RIGHT = {|| date now | format date "%d-%a %r"}
