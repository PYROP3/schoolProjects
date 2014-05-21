pauling = [2,2,6,2,6,2,10,6,2,10,6,2,14,10,6,2,14,10,6];
letters = ["s","s","p","s","p","s","d","p","s","d","p","s","f","d","p","s","f","d","p"];
bigNums = [1,2,2,3,3,4,3,4,5,4,5,6,4,5,6,7,5,6,7];
elements = ["hydrogen","helium","lithium","beryllium","boron","carbon","nitrogen","oxygen","fluorine","neon","sodium","magnesium","aluminum","silicon","phosporus","sulfur","chlorine","argon","potassium","calcium","scandium","titanium","vanadium","chromium","manganese","iron","cobalt","nickel","copper","zinc","gallium","germanium","arsenic","selenium","bromine","krypton","rubidium","strontium","yttrium","zirconium","niobium","molybdenum","technetium","ruthenium","rhodium","palladium","silver","cadmium","indian","tin","antimony","tellurium","iodine","xenon","cesium","barium","lanthanum","cerium","praseodymium","neodymium","promethium","samarium","europium","gadolinium","terbium","dysprosium","holmium","erbium","thulium","ytterbium","lutetium","hafnium","tantalum","tungsten","rhenium","osmium","iridium","platinum","gold","mercury","thallium","lead","bismuth","polonium","astatine","radon","francium","radio","actin","thorium","protactinium","uranium","neptunium","plutonium","americium","curium","berkelium","californium","einsteinium","fermium","mendelevium","nobelium","lawrencium","rutherfordium","dúbnio","seaborgium","bohrium","hássio","meitnério","darmstádtio","roentgênio","copernicium","-no name-","flerovium","-no name-","livermorium","-no name-","-no name-"];
rep = ["H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar", "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd","Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fr", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Cn", "--", "Fl", "--", "Lv", "--", "--"];
family = [1, 18, 1, 2, 13, 14, 15, 16, 17, 18, 1, 2, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
nonMetals = [1,2,5,6,7,8,9,10,14,15,16,17,18,33,34,35,36,52,53,54,85,86];
while true
	puts ""
	elecs =[]
	elecsToGo = 999
	while elecsToGo > 118
		print "Protons: "
		elecsToGo = gets.chomp.to_i
		if elecsToGo > 118
			puts "Proton limit is 118"
		end
	end
	elementNum = elecsToGo
	puts "Detected element: " + elements[elecsToGo-1]
	puts "Representation: " + rep[elecsToGo-1]
	i=0
	while elecsToGo > 0
		if elecsToGo > pauling[i]
			elecsToGo = elecsToGo - pauling[i]
			elecs[i] = pauling[i].to_i
			i=i+1
		else
			elecs[i] = elecsToGo
			elecsToGo = 0
		end
	end
	puts "Electronic distribution:"
	n=0
	while n<elecs.length
		if elecs[n]!=0
			print bigNums[n].to_s
			print letters[n].to_s
			print elecs[n].to_s
			if n+1 != elecs.length
				print ", "
			end
		end
		n = n+1
	end
	n = n-1
	puts ""
	print "Family: "+family[elementNum-1].to_s
	puts ""
	print "Type: "
	if letters[n] == "s"
		puts "representative"
	elsif letters[n] == "p"
		puts "representative"
	elsif letters[n] == "d"
		puts "transition"
	elsif letters[n] == "f"
		puts "transition"
	end
	print "Metal or Nonmetal: "
	if nonMetals.include? elementNum
		puts "Nonmetal"
	else
		puts "Metal"
	end
end