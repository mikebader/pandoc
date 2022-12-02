--- placeholder: Create filter for text placeholders
--
-- Creates a filter to look for the commands \TK and \needcite.
--
-- * \TK indicates something necessary to include in the text
-- * \needcite indicates that a citation is needed
--
-- The placeholders will be rendered using strong formatting inside double
-- curly braces `{{}}`. Both placeholder commands take an optional LaTeX 
-- argument inside of brackets and the text inside of the the brackets will
-- be printed inside the curly brackets as well.
--

function RawInline (elem)
	if elem.format == "tex" then 
		local raw = elem.text
		_, _, cmd = string.find(raw, "\\([%a_]+)")
		if cmd == "TK" or cmd == "needcite" then 
			if cmd == "needcite" then cmd = "NEED CITATION" end
			str = ("{{" .. cmd) 
			_, _, raw = string.find(raw, "%[(.-)]") 
			if raw ~= nil then
				-- txt ~= nil then 
				str = (str .. ": " .. string.upper(raw)) 
			end
			return pandoc.Strong(str .. "}}")
		end
	end
end
