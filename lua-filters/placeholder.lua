--- placeholder: Create filter for text placeholders
--
-- Creates a filter to render formatted text for \TK and \needcite commands.
--
-- * \TK indicates something necessary to include in the text at a later date
-- * \needcite indicates that a citation is needed
--
-- The placeholders will be rendered depending on the output format. Both
-- HTML and LaTeX will render the placeholders in highlighted, boldface text
-- inside single square braces `[]`. Other formats will render the placeholder
-- using strong formatting inside  double curly braces `{{}}`. The `\TK` command
-- will render the text TK and the `\needcite` command will render the text
-- NEED CITATION. 
--
-- Both \TK and \needcite may contain optional text inside square brackets
-- after the command (following LaTeX syntax; e.g., `\TK[Need Example]`). The
-- text of the optional argument will be rendered after the placeholder title
-- (TK or NEED CITATION) using the same formatting. This may be useful for
-- writing out what text needs to be added or which citation needs to be 
-- included. 

-- Define variables with text to be included in header for HTML and LaTeX
css = [[
<style>
	.placeholder {
		font-weight: bold;
		background-color: yellow;
	}
</style>
]]

latex = [[
  \usepackage{etoolbox}
  \usepackage{color, soul}
  \newcommand{\placeholder}[2][]{\textbf{\hl{[#2}\ifstrempty{#1}{\hl{]}}{\hl{: #1]}}}}
]]

-- Select appropriate text and add at end of current header-includes
function addHeaderIncludes (meta)

	if FORMAT:match 'latex' then hilang = latex else hilang = css end
	local current = meta['header-includes'] or pandoc.MetaList{meta['header-includes']}
	current[#current+1] = pandoc.MetaBlocks(pandoc.RawBlock(FORMAT, hilang))
	meta['header-includes'] = current
	return meta
end

-- Render placeholder on RawInlines
function RawInline (elem)
	if elem.format == "tex" then 
		local raw = elem.text
		_, _, cmd = string.find(raw, "\\([%a_]+)")

		-- Select only \TK or \needcite LaTeX commands and leave rest untouched
		if cmd == "TK" or cmd == "needcite" then 

			-- Construct text inside of note
			if cmd == "needcite" then cmd = "NEED CITATION" end
			_, _, det = string.find(raw, "%[(.-)]")
			if det ~= nil then 
				txt = (cmd .. ": " .. det)
			else
				txt = cmd
			end

			-- Create inline based on document format
			-- HTML
			if FORMAT:match 'html' then
				str = pandoc.RawInline(
					"html",
					("<span class='placeholder'>" .. txt .. "</span>")
				)
			-- LaTeX
			elseif FORMAT:match 'latex' then
				if det ~= nil then
					txt = ("[" .. det .. "]{" .. cmd .. "}")
				else
					txt = ("{" .. cmd .. "}")
				end
				str = pandoc.RawInline("latex", ("\\placeholder" .. txt))
			-- Other
			else
				str = pandoc.Strong("{{" .. txt .. "}}")
			end
			return str
		end
	end
end

return {
	{Meta = addHeaderIncludes},
	{RawInline = RawInline}
}
