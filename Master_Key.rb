####################::Reading Key File::####################

KEY                 = 100       #Variable used to store Key file inputs.
STARTER_TYPE        = 7         #Variable used in Pokemon Essentials for "Starter choice".

#Array for Key Settings.
GAME_DIFFICULTY     = 0
STARTER_SELECT      = 1
STARTER_FORM        = 2
PLAYER_CHARACTER    = 3
STORY_MODE          = 4
POKEDEX             = 5
CAPTURE_EXP         = 6
INFINITY_ENERGY     = 7
SHADOW_POKEMON      = 8
MAGIKARP_PATTERNS   = 9
RARE_SPAWNS         = 10
VOICE_ACTING        = 11
DIVERSE_ENCOUNTERS  = 12
BATTLER_APPEARANCE  = 13
CHEAT_CODES         = 14
#exp share, exp all, exp always, exp never
#fishing rod

#List of cheat codes:
#Payday = Max money
#Goldstar = Shiny Pokemon


#Run only at the start of a New Game.
def read_key

  #Checks if "Key" file exists and converts information into variables.
  if(File.exist?('key.txt'))
    key = Hash.new
    File.readlines('key.txt').each do |line|
    var,val = line.chomp.split('=')
    key[var] = val
    end
  end

####################::Applying Key File Variables::####################
  
  #Default values
  $game_variables[KEY] = [
    'normal',                                                 #GAME_DIFFICULTY
    ['BULBASAUR','CHARMANDER','SQUIRTLE','PIKACHU','EEVEE'],  #STARTER_SELECT
    'Default',                                                #STARTER_FORM
    1,                                                        #PLAYER_CHARACTER
    false,                                                    #STORY_MODE
    false,                                                    #POKEDEX (Regional = false, National = true)
    false,                                                    #CAPTURE_EXP
    false,                                                    #INFINITY_ENERGY
    false,                                                    #SHADOW_POKEMON
    false,                                                    #ADDITIONAL_PATTERNS
    false,                                                    #RARE_SPAWNS
    false,                                                    #VOICE_ACTING
    false,                                                    #DIVERSE_ENCOUNTERS
    0,                                                        #BATTLER_APPEARANCE
    false,                                                    #CHEAT_CODES
  ]
  
  $game_variables[KEY][GAME_DIFFICULTY]     = key['GAME_DIFFICULTY'].downcase if key.has_key?('GAME_DIFFICULTY') && ['easy','normal','hard'].include?(key['GAME_DIFFICULTY'].downcase)
  $game_variables[KEY][PLAYER_CHARACTER]    = key['PLAYER_CHARACTER'].to_i if key.has_key?('PLAYER_CHARACTER') && ("0".."3").include?(key['PLAYER_CHARACTER'])
  $game_variables[KEY][PLAYER_CHARACTER]    = key['PLAYER_CHARACTER'].downcase if key.has_key?('PLAYER_CHARACTER') && ['ash'].include?(key['PLAYER_CHARACTER'].downcase)
  $game_switches[KEY][STORY_MODE]           = key.has_key?('STORY_MODE') && key['STORY_MODE'].downcase == 'on' ? true : false
  $game_switches[KEY][INFINITY_ENERGY]      = key.has_key?('INFINITY_ENERGY') && key['INFINITY_ENERGY'].downcase == 'on' ? true : false
  $game_switches[KEY][CAPTURE_EXP]          = key.has_key?('CAPTURE_EXP') && key['CAPTURE_EXP'].downcase == 'on' ? true : false
  $game_switches[KEY][SHADOW_POKEMON]       = key.has_key?('SHADOW_POKEMON') && key['SHADOW_POKEMON'].downcase == 'on' ? true : false
  $game_switches[KEY][ADDITIONAL_PATTERNS]  = key.has_key?('ADDITIONAL_PATTERNS') && key['ADDITIONAL_PATTERNS'].downcase == 'on' ? true : false
  $game_switches[KEY][RARE_SPAWNS]          = key.has_key?('RARE_SPAWNS') && key['RARE_SPAWNS'].downcase == 'on' ? true : false
  $game_switches[KEY][VOICE_ACTING]         = key.has_key?('VOICE_ACTING') && key['VOICE_ACTING'].downcase == 'on' ? true : false
  $game_switches[KEY][DIVERSE_ENCOUNTERS]   = key.has_key?('DIVERSE_ENCOUNTERS') && key['DIVERSE_ENCOUNTERS'].downcase == 'on' ? true : false
  $game_switches[KEY][CHEAT_CODES]          = key.has_key?('STORY_MODE') && key['CHEAT_CODES'].downcase == 'on' ? true : false
	
	$PokemonGlobal.encounter_version = 1 if key.has_key?('POKEDEX') && key['POKEDEX'].casecmp?('National')

  if key.has_key?('BATTLER_APPEARANCE')
    key['BATTLER_APPEARANCE'].casecmp?("Moemon") ? $game_variables[KEY][BATTLER_APPEARANCE] = 500 : get_form.casecmp?('Pokemusu') ? $game_variables[KEY][BATTLER_APPEARANCE] = 1000 : $game_variables[KEY][BATTLER_APPEARANCE] = 0
  end

  if key.has_key?('STARTER_SELECT')
    pkmn_list = []
    #Note: Add Random without Legendary/Mythical Pokemon.
    GameData::Species.each { |species| pkmn_list.push(species.id) if species.form == 0 }
    $game_variables[KEY][STARTER_SELECT]  = ['BULBASAUR','CHARMANDER','SQUIRTLE','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Kanto')
    $game_variables[KEY][STARTER_SELECT]  = ['CHIKORITA','CYNDAQUIL','TOTODILE','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Johto')
    $game_variables[KEY][STARTER_SELECT]  = ['TREECKO','TORCHIC','MUDKIP','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Hoenn')
    $game_variables[KEY][STARTER_SELECT]  = ['TURTWIG','CHIMCHAR','PIPLUP','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Sinnoh')
    $game_variables[KEY][STARTER_SELECT]  = ['SNIVY','TEPIG','OSHAWOTT','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Unova')
    $game_variables[KEY][STARTER_SELECT]  = ['CHESPIN','FENNEKING','FROAKIE','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Kalos')
    $game_variables[KEY][STARTER_SELECT]  = ['ROWLET','LITTEN','POPPLIO','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Alola')
    $game_variables[KEY][STARTER_SELECT]  = ['GROOKEY','SCORBUNNY','SOBBLE','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Galar')
    $game_variables[KEY][STARTER_SELECT]  = ['ROWLET_1','CYNDAQUIL_1','OSHAWOTT_1','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Hisui')
    $game_variables[KEY][STARTER_SELECT]  = ['SPRIGATITO','FUECOCO','QUAXLY','PIKACHU','EEVEE'] if key['STARTER_SELECT'].casecmp?('Gen9')
    $game_variables[KEY][STARTER_SELECT]  = Array.new(5, key['STARTER_SELECT'].upcase) if GameData::Species.exists?(key['STARTER_SELECT'].upcase)
    $game_variables[KEY][STARTER_SELECT]  = [pkmn_list.shuffle.slice(0..4)] if key['STARTER_SELECT'].casecmp?('Random')
    $game_variables[KEY][STARTER_FORM]    = key['STARTER_FORM'].upcase if key.has_key?('STARTER_SELECT')
  end
end

####################::Generating Starter Pokemon::####################

def get_starter(var) #Grass/Fire/Water/Electric/Normal
  $game_variables[STARTER_TYPE] = var.downcase
  get_pkmn = $game_variables[KEY][STARTER_SELECT][0] if var.casecmp?("Grass")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][1] if var.casecmp?("Fire")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][2] if var.casecmp?("Water")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][3] if var.casecmp?("Electric")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][4] if var.casecmp?("Normal")
  get_form = $game_variables[KEY][STARTER_FORM]

#Sets the form of the Starter Pokémon based on species and key file.
#Note: Add Regional form for pre-evolutions.
#Note: Add Gender forms.
#Nore: Correct form numbers to match BPS/pokemon_forms.txt
  form = 0 
  if get_pkmn == ('RAICHU' || 'RATTATA' || 'RATICATE' || 'SANDSHREW' || 'SANDSLASH' || 'VULPIX'|| 'NINETALES' ||
    'DIGLETT' || 'DUGTRIO' || 'PERSIAN' || 'GEODUDE' || 'GRAVERLER' || 'GOLEM' || 'GRIMER' || 'MUK' ||
    'EXEGGUTOR' || 'MAROWAK')
  get_form.casecmp?('ALOLAN') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == ('PONYTA' || 'SLOWPOKE' || 'SLOWBRO' || 'SLOWKING' || 'RAPIDASH' || 'FARFETCHD' || 'WEEZING' ||
    'MRMIME' || 'ARTICUNO' || 'ZAPDOS' || 'MOLTRES' || 'CORSOLA'|| 'ZIGZAGOON' ||'LINOONE' || 'Yamask' ||
    'Stunfisk')
  get_form.casecmp?('GALARIAN') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == ('GROWLITHE' || 'VOLTORB' || 'ZORUA' || 'ZOROARK' || 'BRAVIARY')
    get_form.casecmp?('HISUIAN') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'PICHU'
    get_form.casecmp?('SPIKEY-EARED') ? form = 3 : get_form.casecmp?('Random') ? form = rand(3) : form = 0
  end
  if get_pkmn == 'PIKACHU'
    pikachu_form = {
    'PARTNER'     => 2,
    'COSPLAY'     => 3,
    'ROCK STAR'   => 4, 
    'BELLE'       => 5,
    'POP STAR'    => 6, 
    'PH. D'       => 7,
    'LIBRE'       => 8,
    'ORIGIAL CAP' => 9,
    'HOENN CAP'   => 10,
    'SINNOH CAP'  => 11,
    'UNOVA CAP'   => 12,
    'KALOS CAP'   => 13,
    'ALOLA CAP'   => 14,
    'PARTNER CAP' => 15,
    'WORLD CAP'   => 16,
    'BALLOON'     => 17,
    'SURFBOARD'   => 18
    }
    pikachu_form.has_key?(get_form.upcase) ? form = pikachu_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(19) : form = 0)
  end
  if get_pkmn == 'EEVEE'
    get_form.casecmp?('PARTNER') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'DEOXYS'
    deoxys_form = {
    'ATTACK FORME'  => 1,
    'DEFENSE FORME' => 2,
    'SPEED FORME'   => 3
    }
    deoxys_form.has_key?(get_form.upcase) ? form = deoxys_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(3) : form = 0)
  end
  if get_pkmn == ('BURMY' || 'WORMADAM')
    pkmn_form = {
    'SAND CLOAK'  => 1,
    'TRASH CLOAK' => 2
    }
    burmy_form.has_key?(get_form.upcase) ? form = burmy_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(3) : form = 0)
  end
  if get_pkmn == 'ROTOM'
    rotom_form = {
    'CUT ROTOM'   => 1,
    'FROST ROTOM' => 2,
    'HEAT ROTOM'  => 3, 
    'SPIN ROTOM'  => 4,
    'WASH ROTOM'  => 5
    }
    rotom_form.has_key?(get_form.upcase) ? form = rotom_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(6) : form = 0)
  end
  if get_pkmn == ('TORNADUS' || 'THUNDURUS' || 'LANDORUS' || 'ENAMORUS')
    get_form.casecmp?('Therian') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'GRENINJA'
    get_form.casecmp?('Battle Bond') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'VIVILLON'
    vivillon_form = {
    'CONTINENTAL PATTERN' => 1,
    'ELEGANT PATTERN'     => 2,
    'GARDEN PATTERN'      => 3, 
    'HIGH PLAINS PATTERN' => 4,
    'ICY SNOW PATTERN'    => 5,
    'JUNGLE PATTERN'      => 6,
    'MARINE PATTERN'      => 7,
    'MEADOW PATTERN'      => 8,
    'MODERN PATTERN'      => 9,
    'MONSOON PATTERN'     => 10,
    'OCEAN PATTERN'       => 11,
    'POLAR PATTERN'       => 12,
    'RIVER PATTERN'       => 13,
    'SANDSTORM PATTERN'   => 14,
    'SAVANNA PATTERN'     => 15,
    'SUN PATTERN'         => 16,
    'TUNDRA PATTERN'      => 17,
    'FANCY PATTERN'       => 18,
    'POKEBALL PATTERN'    => 19
    }
    vivillon_form.has_key?(get_form.upcase) ? form = vivillon_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(20) : form = 0)
  end
  if get_pkmn == ('FLABEBE' || 'FLORGES')
    flabebe_form = {
    'YELLOW FLOWER' => 1,
    'ORANGE FLOWER' => 2,
    'BLUE FLOWER'   => 3, 
    'WHITE FLOWER'  => 4
    }
    flabebe_form.has_key?(get_form.upcase) ? form = flabebe_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(5) : form = 0)
  end
  if get_pkmn == 'FLOETTE'
    floette_form = {
    'YELLOW FLOWER'   => 1,
    'ORANGE FLOWER'   => 2,
    'BLUE FLOWER'     => 3, 
    'WHITE FLOWER'    => 4,
    'ETERNAL FLOWER'  => 5
    }
    floette_form.has_key?(get_form.upcase) ? form = floette_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(6) : form = 0)
  end
  #get_pkmn has bug with defined Pokemon, default, or random

  if get_pkmn == 'ALCREMIE'
    alcremie_form = {
      'STRAWBERRY RUBY CREAM'     => 7,
      'STRAWBERRY MATCHA CREAM'   => 14,
      'STRAWBERRY MINT CREAM'     => 21,
      'STRAWBERRY LEMON CREAM'    => 28,
      'STRAWBERRY SALTED CREAM'   => 35,
      'STRAWBERRY RUBY SWIRL'     => 42,
      'STRAWBERRY CARAMEL SWIRL'  => 49,
      'STRAWBERRY RAINBOW SWIRL'  => 56,
      'BERRY VANILLA CREAM'       => 1,
      'BERRY RUBY CREAM'          => 8,
      'BERRY MATCHA CREAM'        => 15,
      'BERRY MINT CREAM'          => 22,
      'BERRY LEMON CREAM'         => 29,
      'BERRY SALTED CREAM'        => 36,
      'BERRY RUBY SWIRL'          => 43,
      'BERRY CARAMEL SWIRL'       => 50,
      'BERRY RAINBOW SWIRL'       => 57,
      'LOVE VANILLA CREAM'        => 2,
      'LOVE RUBY CREAM'           => 9,
      'LOVE MATCHA CREAM'         => 16,
      'LOVE MINT CREAM'           => 23,
      'LOVE LEMON CREAM'          => 30,
      'LOVE SALTED CREAM'         => 37,
      'LOVE RUBY SWIRL'           => 44,
      'LOVE CARAMEL SWIRL'        => 51,
      'LOVE RAINBOW SWIRL'        => 58,
      'STAR VANILLA CREAM'        => 3,
      'STAR RUBY CREAM'           => 10,
      'STAR MATCHA CREAM'         => 17,
      'STAR MINT CREAM'           => 24,
      'STAR LEMON CREAM'          => 31,
      'STAR SALTED CREAM'         => 38,
      'STAR RUBY SWIRL'           => 45,
      'STAR CARAMEL SWIRL'        => 52,
      'STAR RAINBOW SWIRL'        => 59,
      'CLOVER VANILLA CREAM'      => 4,
      'CLOVER RUBY CREAM'         => 11,
      'CLOVER MATCHA CREAM'       => 18,
      'CLOVER MINT CREAM'         => 25,
      'CLOVER LEMON CREAM'        => 32,
      'CLOVER SALTED CREAM'       => 39,
      'CLOVER RUBY SWIRL'         => 46,
      'CLOVER CARAMEL SWIRL'      => 53,
      'CLOVER RAINBOW SWIRL'      => 60,
      'FLOWER VANILLA CREAM'      => 5,
      'FLOWER RUBY CREAM'         => 12,
      'FLOWER MATCHA CREAM'       => 19,
      'FLOWER MINT CREAM'         => 26,
      'FLOWER LEMON CREAM'        => 33,
      'FLOWER SALTED CREAM'       => 40,
      'FLOWER RUBY SWIRL'         => 47,
      'FLOWER CARAMEL SWIRL'      => 54,
      'FLOWER RAINBOW SWIRL'      => 61,
      'RIBBON VANILLA CREAM'      => 6,
      'RIBBON RUBY CREAM'         => 13,
      'RIBBON MATCHA CREAM'       => 20,
      'RIBBON MINT CREAM'         => 27,
      'RIBBON LEMON CREAM'        => 34,
      'RIBBON SALTED CREAM'       => 41,
      'RIBBON RUBY SWIRL'         => 48,
      'RIBBON CARAMEL SWIRL'      => 55,
      'RIBBON RAINBOW SWIRL'      => 62
    }
    alcremie_form.has_key?(get_form.upcase) ? form = alcremie_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(63) : form = 0)
  end

  cmd = 0
  loop do
    cmd = pbMessage(_INTL("Choose " + get_pkmn.to_s.capitalize + "?"),[
      ("Yes"),
      ("No")
      ],-1,nil,cmd)
    case cmd
    when 0 then
      form > 0 ? pbAddToPartySilent(get_pkmn.to_s + '_' + form.to_s,5) : pbAddToPartySilent(get_pkmn,5)
      $Trainer.last_pokemon.form = 0 if form == 0
      $Trainer.last_pokemon.form += $game_variables[KEY][BATTLER_APPEARANCE]
      break
    when 1 then break
    when -1 then break
    end
  end
end

####################::Modify Wild Enconters::####################

#Note: Need to add encounter methods.
EVENT_ENCOUNTER = false #To disable encounter modifier set to "true".
TEMP_LEVEL			= 1 #Used to store the level of a wild Pokemon before being modified.
WILD_MELTAN 		= 0 #The number of encounters to be changed to Meltan.
RARE_SPAWN			= 0 
DO_NOT_MODIFY 	= [
'ARTICUNO',
'ZAPDOS',
'MOLTRES',
'MEWTWO',
'MEM',
]

#Note: Add remaining Rare Spawns.
RARE_POKEMON = { #Map # => [[[Regional-1,lvl],[Regional-2,lvl],[[National-1,lvl],[National-2,lvl]]
	12 => [[['BULBASUAR',5..8]],[['TREECKO',5..8],['GROOKEY',5..8]]]	#Viridian Forest
}
			
Events.onWildPokemonCreate += proc { |_sender, e|
  pokemon = e[0]
  #Checks if the Wild Pokemon can be modified.
  if EVENT_ENCOUNTER || DO_NOT_MODIFY.include?(pokemon.species)
    #Determines if Meltan can spawn.
    if Wild_Meltan >0 &&
      $game_map.terrain_tag($game_player.x, $game_player.y) == :Grass &&
      GameData::EncounterType.get($PokemonTemp.encounterType).type != :fishing
      Wild_Meltan -= 1              #Reduces the number of Meltan left for the player to encounter.
      TEMP_LEVEL = pokemon.level    #Saves the wild Pokemon's level.
      pokemon.species = :MELTAN     #Changes the species to Meltan.
      pokemon.level = TEMP_LEVEL    #Adjust Meltan's level to match that of the wild Pokemon.
      pokemon.item = nil 
      pokemon.calc_stats            
      pokemon.reset_moves
    #Determines if the Pokemon should be a Rare Spawn.
    elsif RARE_SPAWN > 0 && RARE_ENCOUNTER_TABLE.key?($game_map.map_id) && rand(20) == 0
      pokemon.species = RARE_ENCOUNTER_TABLE[$game_map.map_id][$PokemonGlobal.encounter_version].sample[0]
      pokemon.level = rand(RARE_ENCOUNTER_TABLE[$game_map.map_id][$PokemonGlobal.encounter_version].sample[1])
      pokemon.item = nil 
      pokemon.calc_stats            
      pokemon.reset_moves
    #Checks if wild Pokemon is a Ditto.
    elsif rand(100) == 0
      ditto_item_chance = rand(20)    
      pokemon.item = :METALPOWDER if ditto_item_chance == 0
      pokemon.item = :QUICKPOWDER if ditto_item_chance >= 10
      pokemon.item = nil if pokemon.item != (:METALPOWDER || :QUICKPOWDER)
      #Note: Change Ditto's apperence when captured to match BATTLER_APPEARANCE setting.
      IS_DITTO = true
    else
      IS_DITTO = false
    end
    if pokemon.species == :MAGIKARP && ADDITIONAL_PATTERNS
      pokemon.form = rand(32)
    end
  pokemon.form += $game_variables[KEY][BATTLER_APPEARANCE]
  end
}
	
#Note: Diverse Encounters may get scraped.

#Events.onWildPokemonCreate += proc { |_sender, e|
#  pokemon = e[0]
#  if $game_switches[DIVERSE_ENCOUNTERS] == true
#    Diverse_Move_Pool = []
#    #Creates a list of legal moves the wild Pokemon can know. 
#    Diverse_Move_Pool = pokemon.species_data.tutor_moves + pokemon.species_data.egg_moves
#    level_up = pokemon.species_data.moves.clone
#    while level_up != []
#      Diverse_Move_Pool.push(level_up[0][1])
#      level_up.delete_at(0)
#    end
#    #Adds/Removes attacks based on the Pokemon encountered.
#    Diverse_Move_Pool.delete(:VOLTTACKLE) if Diverse_Move_Pool.include?(:VOLTTACKLE)
#    Diverse_Move_Pool = [:SPLASH] if pokemon.species == :MAGIKARP && rand(3) != 0
#    if pokemon.species == :SMEARGLE
#      GameData::Move.each { |m| Diverse_Move_Pool.push(m.id) if m.id.is_a?(Symbol) }
#      Diverse_Move_Pool.delete(:STRUGGLE) if Diverse_Move_Pool.include?(:STRUGGLE)
#      Diverse_Move_Pool.delete(:MIRRORMOVE) if Diverse_Move_Pool.include?(:MIRRORMOVE)
#      Diverse_Move_Pool.delete(:SLEEPTALK) if Diverse_Move_Pool.include?(:SLEEPTALK)
#      Diverse_Move_Pool.delete(:CHATTER) if Diverse_Move_Pool.include?(:CHATTER)
#      Diverse_Move_Pool.delete(:CRAFTYSHIELD) if Diverse_Move_Pool.include?(:CRAFTYSHIELD)
#      #These moves can be sketched, but a wild Smeargle has no means of doing so.
#      Diverse_Move_Pool.delete(:EXPLOSION) if Diverse_Move_Pool.include?(:EXPLOSION)
#      Diverse_Move_Pool.delete(:SELFDESTRUCT) if Diverse_Move_Pool.include?(:SELFDESTRUCT)
#    end
#    #Forces the wild Pokemon to forget all its known moves.
#    [1, 2, 3, 4].each do pokemon.forget_move_at_index(0) end
#    #Generates new moves.
#    for i in [1, 2, 3, 4] do
#      random_move = Diverse_Move_Pool.uniq.sample
#      pokemon.learn_move(random_move)
#      Diverse_Move_Pool.delete(random_move)
#    end
#    #Applies exceptions and reset
#    pokemon.learn_move(:VOLTTACKLE) if pokemon.species == (:PIKACHU || :RAICHU || :PICHU) && pokemon.item == :LIGHTBALL
#    pokemon.forget_move_at_index(1) if pokemon.level < 20 && rand(4) == 0
#    Diverse_Move_Pool.clear
#  end
#}

####################::Miscellaneous Scripts::####################

#Disables the use of items from the bag while in Gym Battles.
	
#Set to "true" when starting a Gym Battle, set to false after
GYM_CHALLENGE = false	

class PokeBattle_Battle
 def pbCommandPhaseLoop(isPlayer)
    # NOTE: Doing some things (e.g. running, throwing a Poké Ball) takes up all
    #       your actions in a round.
    actioned = []
    idxBattler = -1
    loop do
      break if @decision!=0   # Battle ended, stop choosing actions
      idxBattler += 1
      break if idxBattler>=@battlers.length
      next if !@battlers[idxBattler] || pbOwnedByPlayer?(idxBattler)!=isPlayer
      next if @choices[idxBattler][0]!=:None    # Action is forced, can't choose one
      next if !pbCanShowCommands?(idxBattler)   # Action is forced, can't choose one
      # AI controls this battler
      if @controlPlayer || !pbOwnedByPlayer?(idxBattler)
        @battleAI.pbDefaultChooseEnemyCommand(idxBattler)
        next
      end
      # Player chooses an action
      actioned.push(idxBattler)
      commandsEnd = false   # Whether to cancel choosing all other actions this round
      loop do
        cmd = pbCommandMenu(idxBattler,actioned.length==1)
        # If being Sky Dropped, can't do anything except use a move
        if cmd>0 && @battlers[idxBattler].effects[PBEffects::SkyDrop]>=0
          pbDisplay(_INTL("Sky Drop won't let {1} go!",@battlers[idxBattler].pbThis(true)))
          next
        end
        case cmd
        when 0    # Fight
          break if pbFightMenu(idxBattler)
        when 1    # Bag
          if $GYM_CHALLENGE
            pbDisplay(_INTL("Items may not be used."))
          else
            if pbItemMenu(idxBattler,actioned.length==1)
              commandsEnd = true if pbItemUsesAllActions?(@choices[idxBattler][1])
              break
            end
          end
        when 2    # Pokémon
          break if pbPartyMenu(idxBattler)
        when 3    # Run
          # NOTE: "Run" is only an available option for the first battler the
          #       player chooses an action for in a round. Attempting to run
          #       from battle prevents you from choosing any other actions in
          #       that round.
          if pbRunMenu(idxBattler)
            commandsEnd = true
            break
          end
        when 4    # Call
          break if pbCallMenu(idxBattler)
        when -2   # Debug
          pbDebugMenu
          next
        when -1   # Go back to previous battler's action choice
          next if actioned.length<=1
          actioned.pop   # Forget this battler was done
          idxBattler = actioned.last-1
          pbCancelChoice(idxBattler+1)   # Clear the previous battler's choice
          actioned.pop   # Forget the previous battler was done
          break
        end
        pbCancelChoice(idxBattler)
      end
      break if commandsEnd
    end
  end
end 
