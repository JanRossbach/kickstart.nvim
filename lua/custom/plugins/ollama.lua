local project_description =
  'A technical report describing the Methodology for securing autonomous train perception compnents, that was developed by the Project KI-LOK. Should be in the style of an academic paper and focus on how the developed methods work together.'
local project_prompt = 'You are a helpful AI assistent to a computer science researcher working on a paper that is best described as: '
  .. project_description
  .. 'Please format all your answer in latex.'
  .. 'Prioritize clear and concise langauge and ensure a high level of technical detail.'
  .. 'Only output the text and avoid any additional explanations or comments.'
  .. 'Always ensure, that your output is correct and free of errors.'
  .. 'Always ensure, that your output makes sense in the context of the paper and fits the overall narrative.'
  .. 'Always ensure, that your output is free of spelling and grammar errors.'
  .. 'Always ensure, that your output is free of plagiarism.'
  .. 'Insert regular line breaks after around 80 characters.'

local writing_prompt = 'You are a helpful AI assitent to a computer science MSC student doing UNI homwork.'

local coding_model = 'llama3'
local writing_model = 'llama3'

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

local function readAll(file)
  local f = assert(io.open(file, 'rb'))
  local content = f:read '*all'
  f:close()
  return content
end

local function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function get_prompts(path)
  local prompts = {}
  for _, dir in ipairs(vim.fn.readdir(path)) do
    -- the name of the prompt is the name of the directory with a "fabric" in front
    local p = { model = writing_model }
    -- read the user.md file to string
    local system_prompt = readAll(path .. dir .. '/system.md')
    if system_prompt then
      p.system = system_prompt
    else
      goto continue
    end

    p.promt = '$sel\n'

    local pname_sel = 'Fabric ' .. dir .. ' Selection'
    local pname_input = 'Fabric ' .. dir .. ' Input'
    local pname_buffer = 'Fabric ' .. dir .. ' Buffer'

    local pinput = shallowcopy(p)
    local pbuffer = shallowcopy(p)

    prompts[pname_sel] = p

    pinput.prompt = '$input\n'

    prompts[pname_input] = pinput

    pbuffer.prompt = '$buf\n'

    prompts[pname_buffer] = pbuffer

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
      raw = {
        system = project_prompt,
        prompt = '$input',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      raw_sel = {
        system = project_prompt,
        prompt = '$input:\n$sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_continue = {
        system = project_prompt,
        prompt = 'Please continue the input.',
        model = writing_model,
        action = 'display',
      },
      Jenni_raw = {
        system = writing_prompt,
        prompt = 'Given the paper code: $buf\n$input',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      Jenni_raw_with_sel = {
        system = writing_prompt,
        prompt = 'Given the paper code: $buf\n and the following part: $sel\n$input',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      Jenni_expand = {
        system = project_prompt,
        prompt = 'Please expand the bullet points into a coherent text: $sel',
        action = 'display',
        model = writing_model,
      },
      Jenni_rephrase = {
        system = project_prompt,
        prompt = '$buf\nPlase rephrase the following section in your own words: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_cite = {
        system = project_prompt,
        prompt = 'Please find a citation for the following statement: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_simplify = {
        system = project_prompt,
        prompt = 'Please simplify the following section: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_improve_fluency = {
        system = project_prompt,
        prompt = 'Please improve the fluency of the following section: $sel',
        model = writing_model,
        action = 'display',
      },
      Jenni_paraphrase = {
        system = project_prompt,
        prompt = 'Please paraphrase the following section so that it is more $input: $sel',
        input_label = '> ',
        model = writing_model,
        action = 'display',
      },
      Jenni_ask = {
        system = project_prompt,
        prompt = 'Can you please answer the following question: $input',
        model = writing_model,
        action = 'display',
      },
    }),
  },
}
