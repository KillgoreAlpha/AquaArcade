extends Node

var water = 1.0
var pollution = 0.0
var water_quality = 1.0

var mountain = 10000
var snow = 0.5
var metal = 5

var ampears = 10
var ampears_produced = 1
var ampear_quality = 1.0
var ampear_groves = 1

var bots = 1
var productivity = 1.0

var beaconProgress = 0
var synthesizerBuilt = false
var synthesizerRunning = false
var synthesizerLevel = 0

var policy_time = 0
var win_progress = 0
var difficulty = 100
var win_game = false
var lose_game = false

# Win Condition Modifier
var winmod = 0
# Win Condition Difficulty Modifier
var windiffmod = 0
# Water Modifier
var watermod = 0
# Pollution Modifier
var pollutionmod = 0
# Water Quality Modifier
var waterqualmod = 0
# Mountain Modifier
var mountainmod = 0
# Snow Modifier
var snowmod = 0
# Metal Modifier
var metalmod = 0
# Ampear Modifier
var ampearmod = 0
# Ampear Quality Modifier
var ampearqualmod = 0
# Ampears Produced Modifier
var ampearprodmod = 0
# Ampear Grove Modifier
var grovemod = 0
# Bots Modifier
var botsmod = 0
# Productivity Modifier
var prodmod = 0

var policy1 = false
var policy2 = false
var policy3 = false

var allEvents = {0: [0, "It’s the beginning of the water year, and with it comes the choice of optimization. A couple of Farmechs have pitched a couple of differing ideas for improving the Ampear harvest. One Farmech says that they need to expand the farmland since they’re reaching the maximum capacity on the number of crops that could be planted. The other insists that they must enter a fallow period, in which they don’t plant anything for a period to allow the soil a chance to recover. Thus, the choice is turned over to you as their superior.", "Expand the Orchards", "Fallow the Soil","Placeholder","Placeholder"],
1: [1, "It’s the beginning of the water year, and with it comes the opportunity to designate new priorities. Your team of Research-Rs have come up with a project that’d make the mountain more efficient in providing runoff into the water reservoir. It’ll involve either shaping the mountain into a more controlled stream of water or building a gutter to transport the water safely. Which do you think would be better?", "Terraform the Mountain", "Construct the Gutter","Placeholder","Placeholder"], 
2: [2, "It’s the beginning of the water year, and with it comes the perfect time to increase productivity. This cycle, you have already made plans to help expedite the process of constructing the beacon. You had two primary directives already put to paper during the last year, so now is the time to choose. One plan involves rapidly producing more Olmechas to increase the productivity of all projects, while the other involves digging into the exterior of the mountain to glean more metal. It’s your call.", "Mass Production", "Heightened Mining","Placeholder","Placeholder"],
3: [3, "After assessing your current status, you realized it’s high time to begin working on the Pioneer Initiative’s end goal: the construction of the Beacon. This project will take multiple years to complete, but starting now will help progress that further. You’ll have to start by clearing a sufficient amount of earth to make the base of the beacon. Do you wish to begin?", "Begin Construction", "Delay Construction","Placeholder","Placeholder"], 
4: [4, "An alarming discovery has been made: there’s been a large influx of native bug species desecrating your Ampear orchards! Luckily, some of your Research-Rs have developed a very potent anti-pest solution, but they’re uncertain of how it would affect the environment due to a lack of testing. You can always have the Farmechas manually gun down the bugs, but you’ll likely lose some in the process regardless. What do you think?", "Use Pesticides", "Manual Removal","Placeholder","Placeholder"],
5: [5, "After a quick look through your blueprint database, you’ve decided that if you are going to build any of these factories, you’ll probably create the Lubricant Synthesizer. It increases production, but it’ll take some time to fully realize and metal to complete.", "Begin Construction", "Delay Construction","Placeholder","Placeholder"], 
6: [6, "Outside your office, you suddenly hear a large rumbling noise. You look out the window, and there are cracks in the ground snaking towards your structures! After doing some quick calculations, you deduce that the orchards and the mines are likely to be damaged by this disaster. What do you do?", "Prioritize Ampear Trees", "Prioritize Metal Mines","Placeholder","Placeholder"],
7: [7, "After a section of the mountain wall caved in during mining, a group of Mine-Rs have found an underwater reservoir! You’ll have to dig out tunnels leading to the primary water processing plant, but you’ll get a pretty big boost in water!", "Develop Reservoir", "Leave it Be","Placeholder","Placeholder"], 
8: [8, "Outside your office, you suddenly hear a large rumbling noise. You look out the window, and there are boulders from the mountains barreling towards your orchards! After doing some quick calculations, you deduce that you can mitigate damage to the orchards, but there’s a high chance of damaged robots being the outcome of this disaster. What do you do?", "Protect the Orchards", "Protect the People","Placeholder","Placeholder"],
9: [9, "After a frantic message from a Research-R, you made a quick trip to the water processing plant. What you find there shocks you. The water is almost brown! Apparently there’s been a buildup in pollution in the entire reservoir, that’s been happening right under your nose. There’s solutions, but none of them are cheap.", "Overclock Cleansing", "Flush out Impurities","Placeholder","Placeholder"], 
10: [10, "Your Lubricant Synthesis project has been completed! Now you can get a lot more productivity out of each bot. Now that you notice it though, the factory is a little dangerously close to the stream…", "Begin Production", "Delay Production","Placeholder","Placeholder"],
11: [11, "Now that the Lubricant Synthesizer has been active for a few seasons, you’ve taken steps to increase the potential productivity of the factory. Now that those preparations are complete, you find yourself contemplating how this’d effect the environment…", "Ramp Production", "Cease Production","Placeholder","Placeholder"], 
12: [12, "After assessing your current status, you realized it’s high time to continue working on the Pioneer Initiative’s end goal: the construction of the Beacon. This  time, you’ll have to contribute a lot of metal to continue construction. Do you wish to begin now?", "Begin Construction", "Delay Construction","Placeholder","Placeholder"],
13: [13, "After assessing your current status, you realized it’s high time to continue working on the Pioneer Initiative’s end goal: the construction of the Beacon. This  time, you’ll have to mine out a significant portion of the mountain to extract the necessary minerals. Do you wish to begin now?", "Begin Construction", "Delay Construction","Placeholder","Placeholder"], 
14: [14, "An emergency notification goes off in your office; it appears that the pipe connecting the underground reservoir to the water plant has broken down!", "Cut Off Flow", "Emergency Patching","Placeholder","Placeholder"]
}

func _process(delta):
	if win_progress >= 100:
		win_progress = 100
		win_game = true
	if water <= 0.0:
		water = 0.0
		lose_game = true
	if water > 1.0:
		water = 1.0
	if pollution < 0.0:
		pollution = 0.0
	if pollution >= 1.0:
		pollution = 1.0
		lose_game = true
	if water_quality <= 0.0:
		water_quality = 0.0
		lose_game = true
	if water_quality > 1.0:
		water_quality = 1.0
	if metal < 0:
		metal = 0
	if ampears < 0:
		ampears = 0
	if ampears_produced < 0:
		ampears_produced = 0
	if ampear_quality < 0:
		ampear_quality = 0
	if ampear_groves < 0:
		ampear_groves = 0
	if bots < 1:
		bots = 1
	if productivity < 0.0:
		productivity = 0.0
