state("KSP")
{
	// 1.0.5 MainMenu pointer, kind of visibility state of the menu
	int new_start : 0x00A32B30, 0x0, 0x0,  0x8,  0x14, 0xB8;
	// 1.0.5 Returns string (as int) from game MultiOptionDialog called when game asked, whether you want to overwrite the existing one.
	int ow_start : 0x00A32B30, 0x0, 0x14, 0x14, 0x10, 0x14, 0xC; // 7274564 - "dialog is shown"
	int ab_name : "mono.dll", 0x0020A554, 0x10, 0x774, 0x4, 0x14, 0x20, 0x10, 0x8, 0x10, 0xC; // contextual (current) astrobody name. 7667789 = mun
	// astrobodies:
	// 7667789 = mun
	// 6619211 = kerbin
	byte landstate : "mono.dll", 0x0020A554, 0x10, 0x774, 0x4, 0x14, 0x101; // contextual (current) astrobody name. 7667789 = mun
	byte splashstate : "mono.dll", 0x0020A554, 0x10, 0x774, 0x4, 0x14, 0x102; // contextual (current) astrobody name. 7667789 = mun

}

startup 
{
	vars.astrobodies = new Dictionary<int, string>()
	{
		{7667789, ""}, // mun
		{6619211, ""}, // kerbin
	};
	
	refreshRate = 30;
}

init
{
	vars.split = 2;
	vars.b_ml = false;
	vars.b_kl = false;
	print("MODULES: "+modules[0]);    
	print("OW_START:"+(current.ow_start));  
	print("AB_NAME:"+(current.ab_name));  
	print("LAND:"+(current.landstate));  
	print("SPLIT:"+(vars.split));  
}

start
{
	vars.split = 2;
	vars.b_ml = false;
	vars.b_kl = false;
	if((current.ow_start != old.ow_start && old.ow_start == 7274564) // obviously triggered when cancel is pressed too.
		)  // also triggered when ESC (rather, any mainmenu state was changed) is pressed.
	//if(false) 
	{ 
		return true; 
	}
}

update
{
	
}



split
{
	
	if(current.landstate != old.landstate || current.splashstate > old.splashstate)
	{
		print("L/S CHANGED: l("+current.landstate+") s("+current.splashstate+")FOR "+current.ab_name+" SPLIT "+vars.split+"");
	}
	if((current.landstate > old.landstate || current.splashstate > old.splashstate) && current.ab_name == 7667789 && !vars.b_ml && vars.split == 2)
	{
		vars.split += 1;
		print("MUNSPLIT:"+(vars.split));
		vars.b_ml = true;
		return true;
	}
	if((current.landstate > old.landstate || current.splashstate > old.splashstate) && current.ab_name == 6619211 && !vars.b_kl && vars.split == 3)
	{
		vars.split += 1;
		print("KERBINSPLIT:"+(vars.split)); 
		vars.b_kl = true;
		return true;
	}
}

reset
{
	if((current.ow_start != old.ow_start && old.ow_start == 7274564) // obviously triggered when cancel is pressed too.
		)  // also triggered when ESC (rather, any mainmenu state was changed) is pressed.
	//if(false) 
	{ 
		return true; 
	}
}

isLoading
{
	return true;
}