local project_description =
  'A technical report describing the Methodology for securing autonomous train perception compnents, that was developed by the Project KI-LOK. Should be in the style of an academic paper and focus on how the developed methods work together.'
local project_prompt = 'You are a researcher working on a paper defined as: '
  .. project_description
  .. 'The $ftype Document you are working on is: $buf\n\n'
  .. 'Please format your answer in latex!'

local writing_prompt = 'You are a helpful AI assitent to a computer science MSC student doing UNI homwork.'

local coding_model = 'starcoder'
local writing_model = 'mistral'

local function merge(...)
  local result = {}
  -- For each source table
  for _, t in ipairs { ... } do
    -- For each pair in t
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local function get_prompts(path)
  local prompts = {}
  for _, dir in ipairs(vim.fn.readdir(path)) do
    -- the name of the prompt is the name of the directory with a "fabric" in front
    local prompt_name = 'Fabric_' .. dir
    local prompt = { model = writing_model}
    -- read the user.md file to string
    local system_prompt = readAll(path .. dir .. '/system.md')
    if system_prompt then
      prompt.prompt = system_prompt .. '$sel'
    else
      goto continue
    end

    prompts[prompt_name] = prompt

    ::continue::
  end
  return prompts
end

local fabric_prompts = get_prompts '/home/jan/.config/fabric/patterns/'

return {
  'nomnivore/ollama.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },

  -- All the user commands added by the plugin
  cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },

  keys = {
    -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
    {
      '<leader>Go',
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = '[G]enerate [o]llama prompt',
      mode = { 'n', 'v' },
    },

    -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
    {
      '<leader>Gc',
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = 'ollama Generate Code',
      mode = { 'n', 'v' },
    },
  },
  opts = {
    model = coding_model, -- The default prompts are all coding related, so we use the coding model by default
    url = 'http://127.0.0.1:11434',
    serve = {
      on_start = false,
      command = 'ollama',
      args = { 'serve' },
      stop_command = 'pkill',
      stop_args = { '-SIGTERM', 'ollama' },
    },
    -- View the actual default prompts in ./lua/ollama/prompts.lua
    prompts = merge(fabric_prompts, {
      Jenni_raw = {
        system_prompt = writing_prompt,
        prompt = '$input: $sel\n',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      Jenni_expand = {
        system_prompt = project_prompt,
        prompt = 'Please expand the following section by filling in gaps and expanding on bullet points: $sel',
        action = 'display',
        model = writing_model,
      },
      Jenni_rephrase = {
        system_prompt = project_prompt,
        prompt = 'Plase rephrase the following section in your own words: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_cite = {
        system_prompt = project_prompt,
        prompt = 'Please find a citation for the following statement: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_simplify = {
        system_prompt = project_prompt,
        prompt = 'Please simplify the following section: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_improve_fluency = {
        system_prompt = project_prompt,
        prompt = 'Please improve the fluency of the following section: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_paraphrase = {
        system_prompt = project_prompt,
        prompt = 'Please paraphrase the following section so that it is more $input: $sel',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      Jenni_ask = {
        system_prompt = project_prompt,
        prompt = 'Can you please answer the following question: $input',
        model = writing_model,
        action = 'display',
      },
    }),
  },
}
