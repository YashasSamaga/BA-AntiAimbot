//BustAim DEMO Gamemode

#include <a_samp>
#include <zcmd>
#include <sscanf2>

#define BUSTAIM_MAX_PING 600
#define BUSTAIM_MAX_PL_PERCENT_ALLOWED 5

#include "..\include\BustAim.inc"
#include "..\include\colors.inc"
////////////////////////////////////////////////////////////////////////////////
new Text:td;

static ConnectMessageText[5][MAX_PLAYER_NAME + 19];

static Text:ConnectMessage1;
static Text:ConnectMessage2;
static Text:ConnectMessage3;
static Text:ConnectMessage4;
static Text:ConnectMessage5;

static ids[MAX_PLAYERS];
////////////////////////////////////////////////////////////////////////////////
public OnPlayerSuspectedForAimbot(playerid,hitid,weaponid,warnings)
{
	new str[144],nme[MAX_PLAYER_NAME],wname[32],Float:Wstats[BUSTAIM_WSTATS_SHOTS];
	
	ids[playerid]++;
	GetPlayerName(playerid,nme,sizeof(nme));
	GetWeaponName(weaponid,wname,sizeof(wname));
	if(warnings & WARNING_OUT_OF_RANGE_SHOT)
	{
	    format(str,256,"[%d]%s(%d) fired shots from a distance greater than the %s's fire range(Normal Range:%d)",ids[playerid],nme,playerid,wname,BustAim::GetNormalWeaponRange(weaponid));
		SendClientMessageToAll(-1,str);
		BustAim::GetRangeStats(playerid,Wstats);
		format(str,256,"Shooter to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendClientMessageToAll(-1,str);
	}
	if(warnings & WARNING_PROAIM_TELEPORT)
	{
	    format(str,256,"[%d]%s(%d) is using proaim (Teleport Detected)",ids[playerid],nme,playerid);
		SendClientMessageToAll(-1,str);
		BustAim::GetTeleportStats(playerid,Wstats);
		format(str,256,"Bullet to Victim Distance(SA Units): 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendClientMessageToAll(-1,str);
	}
	if(warnings & WARNING_RANDOM_AIM)
	{
	    format(str,256,"[%d]%s(%d) is suspected to be using aimbot(Hit with Random Aim with %s)",ids[playerid],nme,playerid,wname);
		SendClientMessageToAll(-1,str);
		BustAim::GetRandomAimStats(playerid,Wstats);
		format(str,256,"Random Aim Offsets: 1)%f 2)%f 3)%f",Wstats[0],Wstats[1],Wstats[2]);
		SendClientMessageToAll(-1,str);
	}
	if(warnings & WARNING_BACKWARD_SHOT)
	{
	    format(str,256,"[%d]%s(%d) shot a player behind him with %s.",ids[playerid],nme,playerid,wname);
		SendClientMessageToAll(-1,str);
	}
	if(warnings & WARNING_CONTINOUS_SHOTS)
	{
	    format(str,256,"[%d]%s(%d) has fired 10 shots continously with %s(%d)",ids[playerid],nme,playerid,wname,weaponid);
		SendClientMessageToAll(-1,str);
	}
	return 0;
}
////////////////////////////////////////////////////////////////////////////////
main()
{	
	ConnectMessage1 = TextDrawCreate(480,290, " ");
	TextDrawSetProportional(ConnectMessage1,1);
	TextDrawColor(ConnectMessage1,COLOR_WHITE);
	TextDrawFont(ConnectMessage1,1);
	TextDrawLetterSize(ConnectMessage1,0.169999, 1.199999);
	TextDrawSetShadow(ConnectMessage1, 1);
	ConnectMessage2 = TextDrawCreate(480,300, " ");
	TextDrawSetProportional(ConnectMessage2,1);
	TextDrawColor(ConnectMessage2,COLOR_WHITE);
	TextDrawFont(ConnectMessage2,1);
	TextDrawLetterSize(ConnectMessage2, 0.169999, 1.199999);
	TextDrawSetShadow(ConnectMessage2, 1);
	ConnectMessage3 = TextDrawCreate(480,310, " ");
	TextDrawSetProportional(ConnectMessage3,1);
	TextDrawColor(ConnectMessage3,COLOR_WHITE);
	TextDrawFont(ConnectMessage3,1);
	TextDrawLetterSize(ConnectMessage3, 0.169999, 1.199999);
	TextDrawSetShadow(ConnectMessage3, 1);
	ConnectMessage4 = TextDrawCreate(480,320, " ");
	TextDrawSetProportional(ConnectMessage4,1);
	TextDrawColor(ConnectMessage4,COLOR_WHITE);
	TextDrawFont(ConnectMessage4,1);
	TextDrawLetterSize(ConnectMessage4,0.169999, 1.199999);
	TextDrawSetShadow(ConnectMessage4, 1);
	ConnectMessage5 = TextDrawCreate(480,330, " ");
	TextDrawSetProportional(ConnectMessage5,1);
	TextDrawColor(ConnectMessage5,COLOR_WHITE);
	TextDrawFont(ConnectMessage5,1);
	TextDrawLetterSize(ConnectMessage5,0.169999, 1.199999);
	TextDrawSetShadow(ConnectMessage5, 1);
    AddPlayerClass(1, 1958.33, 1343.12, 15.36, 269.15, 26, 36, 28, 150, 0, 0); // The Truth
}
public OnGameModeInit()
{
	SetGameModeText("BustAim Test Server");
 	td = TextDrawCreate(480,350,"");
 	
	TextDrawFont(td,1);
	TextDrawLetterSize(td,0.169999, 1.199999);
	TextDrawSetShadow(td, 0);
	TextDrawSetOutline(td,1);
    TextDrawBackgroundColor(td,0x000000FF);
	return 1;
}
public OnGameModeExit()
{

	return 1;
}
public OnPlayerRequestClass(playerid, classid)
{
    SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}
public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}
static stock UpdateConnectMessages(playerid,name[],reason)
{
	new rsn[9];
	new string[sizeof(rsn) + MAX_PLAYER_NAME + 10];

	if(reason == 1)
	{
	    rsn = "~y~KICK:";
	}
	else if(reason == 2)
	{
	    rsn = "~y~TIME:";
	}
	else if(reason == 3)
	{
	    rsn = "~r~QUIT:";
	}
	else if(reason == 4)
	{
	    rsn = "~g~JOIN:";
	}
	else
	{
	    rsn = "~b~BUG:";
	}
	format(string,sizeof(string),"%s~w~%s(%d)",rsn,name,playerid);
	ConnectMessageText[0] = ConnectMessageText[1];
	ConnectMessageText[1] = ConnectMessageText[2];
	ConnectMessageText[2] = ConnectMessageText[3];
	ConnectMessageText[3] = ConnectMessageText[4];
	ConnectMessageText[4] = string;

	TextDrawSetString(ConnectMessage1,ConnectMessageText[0]);
	TextDrawSetString(ConnectMessage2,ConnectMessageText[1]);
	TextDrawSetString(ConnectMessage3,ConnectMessageText[2]);
	TextDrawSetString(ConnectMessage4,ConnectMessageText[3]);
	TextDrawSetString(ConnectMessage5,string);
}
public OnPlayerConnect(playerid)
{
	new str[24];
	ids[playerid] = 0;
	GetPlayerName(playerid,str,24);
    UpdateConnectMessages(playerid,str,4);
    TextDrawShowForPlayer(playerid,td);
    TextDrawShowForPlayer(playerid,ConnectMessage1);
	TextDrawShowForPlayer(playerid,ConnectMessage2);
	TextDrawShowForPlayer(playerid,ConnectMessage3);
	TextDrawShowForPlayer(playerid,ConnectMessage4);
	TextDrawShowForPlayer(playerid,ConnectMessage5);

	return 1;
}
public OnPlayerUpdate(playerid)
{
    new str[256],nme[24];
	format(str,256,"Packet Loss:");
	for(new i = 0;i < 8;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        GetPlayerName(i,nme,24);
	        format(str,256,"%s~n~~g~%s(%d):~r~%f",str,nme,i,NetStats_PacketLossPercent(i));
	    }
	}
	TextDrawSetString(td,str);
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    new str[24];
	GetPlayerName(playerid,str,24);
    switch(reason)
	{
	    case 0:UpdateConnectMessages(playerid,str,2);
	    case 1:UpdateConnectMessages(playerid,str,3);
	    case 2:UpdateConnectMessages(playerid,str,1);
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
    GivePlayerWeapon(playerid, 24, 5000);
    GivePlayerWeapon(playerid, 26, 5000);
    GivePlayerWeapon(playerid, 28, 9999);
    GivePlayerWeapon(playerid, 31, 5000);
    SetPlayerArmour(playerid,100);
	return 1;
}
COMMAND:profile(playerid,params[])
{
	new id;
    if(sscanf(params, "u",id))
	{
	    return SendClientMessage(playerid, 0xFF0000AA, "Usage:/profile [PlayerID/Name]");
	}
    new allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns;
    BustAim::GetPlayerProfile(id,allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns);
	new str[144],name[MAX_PLAYER_NAME];
	GetPlayerName(id,name,MAX_PLAYER_NAME);
	format(str,144,"BustAim Profile of %s(%d):Complete Profile:Stats of all weapons",name,id);
	SendClientMessage(playerid,COLOR_GREEN,str);
	format(str,144,"Fired:%d Hits:%d HitPercentage:%.2f MaxContinousShots:%d Bullets OutOfRangeWarns:%d AimWarns:%d TeleportWarns:%d BackwardShotWarns:%d",allshots,hitshots,((hitshots*100.0)/allshots),max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns);
	SendClientMessage(playerid,COLOR_GREEN,str);
	return 1;
}
COMMAND:wprofile(playerid,params[])
{
    new id,wid;
    if(sscanf(params, "ui",id,wid))
	{
	    return SendClientMessage(playerid, 0xFF0000AA, "Usage:/wprofile [PlayerID/Name] [WeaponID]");
	}
    new allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns;
    BustAim::GetPlayerWeaponProfile(playerid,wid,allshots,hitshots,max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns);
	new str[144],name[MAX_PLAYER_NAME],wname[32];
	GetPlayerName(id,name,MAX_PLAYER_NAME);
	GetWeaponName(wid,wname,32);
	format(str,144,"BustAim Weapon Profile of %s(%d):Stats of Weapon %s(%d)",name,id,wname,wid);
	SendClientMessage(playerid,COLOR_GREEN,str);
	format(str,144,"Fired:%d Hits:%d HitPercentage:%.2f MaxContinousShots:%d Bullets OutOfRangeWarns:%d AimWarns:%d TeleportWarns:%d BackwardShotWarns:%d",allshots,hitshots,((hitshots*100.0)/allshots),max_cont_shots,out_of_range_warns,random_aim_warns,proaim_tele_warns,backward_shot_warns);
	SendClientMessage(playerid,COLOR_GREEN,str);
	return 1;
}
COMMAND:reset(playerid,params[])
{
    BustAim::ResetPlayerProfile(playerid);
    SendClientMessage(playerid,COLOR_GREEN,"Your profile has been reset for all weapons");
	return 1;
}
COMMAND:wreset(playerid,params[])
{
	new tmp;
	if(sscanf(params, "i",tmp))
	{
	    return SendClientMessage(playerid, 0xFF0000AA, "Usage:/wprofile [WeaponID]");
	}
    BustAim::ResetPlayerWeaponProfile(playerid,tmp);
    SendClientMessage(playerid,COLOR_GREEN,"Your weapon profile has been reset.");
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason)
{
   SendDeathMessage(killerid,playerid,reason);
}
