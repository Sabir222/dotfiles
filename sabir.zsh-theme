PROMPT="%(?:%F{#9ccfd8}%1{➜%}:%F{#eb6f92}%1{➜%}) %F{#ebbcba}%c%f"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{#31748f}git:(%F{#b4637a}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{#31748f}) %F{#f6c177}%1{✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{#31748f})"
