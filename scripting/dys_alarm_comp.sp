#include <sourcemod>
#include <sdktools>

static char g_alarmSound[] = "cyber/alarm.wav";

public Plugin myinfo = {	
	name = "Dys Comp Cyber Alarm Fix",
	description = "Changes Cyber Alarm behaviour to make more sense",
	author = "bauxite",
	version = "0.1.0",
	url = "",
};

public void OnPluginStart()
{
	AddNormalSoundHook(SoundHook);
}

public Action SoundHook(int clients[MAXPLAYERS], int& numClients, char sample[PLATFORM_MAX_PATH], int& entity, int& channel, float& volume, int& level, int& pitch, int& flags, char soundEntry[PLATFORM_MAX_PATH], int& seed)
{   
	if(StrEqual(g_alarmSound, sample, false))
	{
		int team = GetEntProp(entity, Prop_Send, "m_Team");
		
		for(int i = 1; i <= MaxClients; i++)
		{
			if(IsClientInGame(i) && GetClientTeam(i) == team) 
			{
				EmitSoundToClient(i, g_alarmSound);
			}
		}
		
		return Plugin_Stop;
	}

	return Plugin_Continue;
}
