#$game_variables for Master key Settings.
KEY                 = 100
REGION              = 'Kanto'
STARTER_TYPE        = 7

#Array for Key Settings.
GAME_DIFFICULTY     = 0
STARTER_SELECT      = 1
STARTER_FORM        = 2
PLAYER_CHARACTER    = 3
STORY_MODE          = 4
POKEDEX             = 5
CAPTURE_EXP         = 6
INFINITY_ENERGY     = 7
GYM_CHALLENGE       = 8
SHADOW_POKEMON      = 9
MAGIKARP_PATTERNS   = 10
RARE_SPAWNS         = 11
SPECIAL_NPC         = 12
VOICE_ACTING        = 13
DIVERSE_ENCOUNTERS  = 14
BATTLER_APPEARANCE  = 15
#exp share, exp all, exp always, exp never
#fishing rod

#List of cheat codes:
#Payday = Max money
#Goldstar = Shiny Pokemon


#Run only at the start of a New Game.
def read_key

  #Default values
  $game_variables[KEY] = [
    'normal',   #GAME_DIFFICULTY
    'Default',  #STARTER_SELECT
    'Default',  #STARTER_FORM
    1,          #PLAYER_CHARACTER
    false,      #STORY_MODE
    false,      #POKEDEX
    false,      #CAPTURE_EXP
    false,      #INFINITY_ENERGY
    false,      #GYM_CHALLENGE
    false,      #SHADOW_POKEMON
    false,      #MAGIKARP_PATTERNS
    false,      #RARE_SPAWNS
    false,      #SPECIAL_NPC
    false,      #VOICE_ACTING
    false,      #DIVERSE_ENCOUNTERS
    0       #BATTLER_APPEARANCE
  ]

  #Selects the Starter Pokemon the player can choose from.
  
  #Checks if "Key" file exists and converts information into variables and switches.
  if(File.exist?('key.txt'))
    key = Hash.new
    File.readlines('key.txt').each do |line|
    var,val = line.chomp.split('=')
    key[var] = val
    end
  end

  #$game_variables[KEY][GAME_DIFFICULTY] = key['GAME_DIFFICULTY'].downcase if key.has_key?('GAME_DIFFICULTY') && ['easy','normal','hard'].include?(key['GAME_DIFFICULTY'].downcase)
  #$game_variables[PLAYER_CHARACTER] = key['PLAYER_CHARACTER'].to_i if key.has_key?('PLAYER_CHARACTER') && ("0".."3").include?(key['PLAYER_CHARACTER'])
  #$game_variables[PLAYER_CHARACTER] = key['PLAYER_CHARACTER'].downcase if key.has_key?('PLAYER_CHARACTER') && ['ash'].include?(key['PLAYER_CHARACTER'].downcase)
  #$game_switches[STORY_MODE] = key.has_key?('STORY_MODE') && key['STORY_MODE'].downcase == 'on' ? true : false
  #$game_switches[STORY_MODE] = true if data.has_key?('STORY_MODE') && data['STORY_MODE'].downcase == 'true'
  #$game_switches[POKEDEX] = true if key.has_key?('POKEDEX') && key['POKEDEX'].downcase == 'national'
  #$game_switches[INFINITY_ENERGY] = true if key.has_key?('INFINITY_ENERGY') && key['INFINITY_ENERGY'].downcase == 'active'
  #$game_switches[CAPTURE_EXP] = true if key.has_key?('CAPTURE_EXP') && key['CAPTURE_EXP'].downcase == 'true'
  #$game_switches[SHADOW_POKEMON] = true if key.has_key?('SHADOW_POKEMON') && key['SHADOW_POKEMON'].downcase == 'true'
  #$game_switches[MAGIKARP_PATTERNS] = true if key.has_key?('MAGIKARP_PATTERNS') && key['MAGIKARP_PATTERNS'].downcase == 'true'
  #$game_switches[RARE_SPAWNS] = true if key.has_key?('RARE_SPAWNS') && key['RARE_SPAWNS'].downcase == 'true'
  #$game_switches[SPECIAL_NPC] = true if key.has_key?('SPECIAL_NPC') && key['SPECIAL_NPC'].downcase == 'true'
  #$game_switches[VOICE_ACTING] = true if key.has_key?('VOICE_ACTING') && key['VOICE_ACTING'].downcase == 'true'
  $game_variables[KEY][BATTLER_APPEARANCE] = true if key.has_key?('MOEMON') && key['MOEMON'].casecmp?("On")

  if key.has_key?('BATTLER_APPEARANCE')
    key['BATTLER_APPEARANCE'].casecmp?("Moemon") ? $game_variables[KEY][BATTLER_APPEARANCE] = 500 : get_form.casecmp?('Pokemusu') ? $game_variables[KEY][BATTLER_APPEARANCE] = 1000 : $game_variables[KEY][BATTLER_APPEARANCE] = 0
  end
#end

  #Selects the Starter Pokemon the player can choose from.
  pkmn_list = []
  #Need to add option for Pokemusu.
  #Add Hisui forms.
  GameData::Species.each { |species| pkmn_list.push(species.id) if species.form == 0 }
  $game_variables[KEY][STARTER_SELECT] = ['PIKACHU','CHARMANDER','SQUIRTLE','PIKACHU','EEVEE'] if REGION == 'Kanto'
  $game_variables[KEY][STARTER_SELECT] = ['CHIKORITA','CYNDAQUIL','TOTODILE','PIKACHU','EEVEE'] if REGION == 'Johto'
  $game_variables[KEY][STARTER_SELECT] = ['TREECKO','TORCHIC','MUDKIP','PIKACHU','EEVEE'] if REGION == 'Hoenn'
  $game_variables[KEY][STARTER_SELECT] = ['TURTWIG','CHIMCHAR','PIPLUP','PIKACHU','EEVEE'] if REGION == 'Sinnoh'
  $game_variables[KEY][STARTER_SELECT] = ['SNIVY','TEPIG','OSHAWOTT','PIKACHU','EEVEE'] if REGION == 'Unova'
  $game_variables[KEY][STARTER_SELECT] = ['CHESPIN','FENNEKING','FROAKIE','PIKACHU','EEVEE'] if REGION == 'Kalos'
  $game_variables[KEY][STARTER_SELECT] = ['ROWLET','LITTEN','POPPLIO','PIKACHU','EEVEE'] if REGION == 'Alola'
  $game_variables[KEY][STARTER_SELECT] = ['GROOKEY','SCORBUNNY','SOBBLE','PIKACHU','EEVEE'] if REGION == 'Galar'
  $game_variables[KEY][STARTER_SELECT] = ['SPRIGATITO','FUECOCO','QUAXLY','PIKACHU','EEVEE'] if REGION == 'Galar'
  $game_variables[KEY][STARTER_SELECT] = [pkmn_list.shuffle.slice(0..4)] if key.has_key?('STARTER_SELECT') && key['STARTER_SELECT'].casecmp?("Random")
  $game_variables[KEY][STARTER_SELECT] = Array.new(5, key['STARTER_SELECT'].upcase) if key.has_key?('STARTER_SELECT') && GameData::Species.exists?(key['STARTER_SELECT'].upcase)
  $game_variables[KEY][STARTER_FORM] = key['STARTER_FORM'].upcase if key.has_key?('STARTER_SELECT')
end

def get_starter(var) #Grass/Fire/Water/Electric/Normal
  $game_variables[STARTER_TYPE] = var.downcase
  get_pkmn = $game_variables[KEY][STARTER_SELECT][0] if var.casecmp?("Grass")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][1] if var.casecmp?("Fire")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][2] if var.casecmp?("Water")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][3] if var.casecmp?("Electric")
  get_pkmn = $game_variables[KEY][STARTER_SELECT][4] if var.casecmp?("Normal")
  get_form = $game_variables[KEY][STARTER_FORM]

#Sets the form of the Starter Pokémon based on species and key file.
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
    get_form.casecmp?('SPIKEY-EARED') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'PIKACHU'
    pikachu_form = {
    'PARTNER' => 2,
    'COSPLAY' => 3,
    'ROCK STAR' => 4, 
    'BELLE' => 5,
    'POP STAR' => 6, 
    'PH. D' => 7,
    'LIBRE' => 8,
    'ORIGIAL CAP' => 9,
    'HOENN CAP' => 10,
    'SINNOH CAP' => 11,
    'UNOVA CAP' => 12,
    'KALOS CAP' => 13,
    'ALOLA CAP' => 14,
    'PARTNER CAP' => 15,
    'WORLD CAP' => 16,
    'BALLOON' => 17,
    'SURFBOARD' => 18
    }
    pikachu_form.has_key?(get_form.upcase) ? form = pikachu_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(19) : form = 0)
  end
  if get_pkmn == 'EEVEE'
    get_form.casecmp?('PARTNER') ? form = 1 : get_form.casecmp?('Random') ? form = rand(2) : form = 0
  end
  if get_pkmn == 'DEOXYS'
    deoxys_form = {
    'ATTACK FORME' => 1,
    'DEFENSE FORME' => 2,
    'SPEED FORME' => 3
    }
    deoxys_form.has_key?(get_form.upcase) ? form = deoxys_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(3) : form = 0)
  end
  if get_pkmn == ('BURMY' || 'WORMADAM')
    pkmn_form = {
    'SAND CLOAK' => 1,
    'TRASH CLOAK' => 2
    }
    burmy_form.has_key?(get_form.upcase) ? form = burmy_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(3) : form = 0)
  end
  if get_pkmn == 'ROTOM'
    rotom_form = {
    'CUT ROTOM' => 1,
    'FROST ROTOM' => 2,
    'HEAT ROTOM' => 3, 
    'SPIN ROTOM' => 4,
    'WASH ROTOM' => 5
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
    'ELEGANT PATTERN' => 2,
    'GARDEN PATTERN' => 3, 
    'HIGH PLAINS PATTERN' => 4,
    'ICY SNOW PATTERN' => 5,
    'JUNGLE PATTERN' => 6,
    'MARINE PATTERN' => 7,
    'MEADOW PATTERN' => 8,
    'MODERN PATTERN' => 9,
    'MONSOON PATTERN' => 10,
    'OCEAN PATTERN' => 11,
    'POLAR PATTERN' => 12,
    'RIVER PATTERN' => 13,
    'SANDSTORM PATTERN' => 14,
    'SAVANNA PATTERN' => 15,
    'SUN PATTERN' => 16,
    'TUNDRA PATTERN' => 17,
    'FANCY PATTERN' => 18,
    'POKEBALL PATTERN' => 19
    }
    vivillon_form.has_key?(get_form.upcase) ? form = vivillon_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(20) : form = 0)
  end
  if get_pkmn == ('FLABEBE' || 'FLORGES')
    flabebe_form = {
    'YELLOW FLOWER' => 1,
    'ORANGE FLOWER' => 2,
    'BLUE FLOWER' => 3, 
    'WHITE FLOWER' => 4
    }
    flabebe_form.has_key?(get_form.upcase) ? form = flabebe_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(5) : form = 0)
  end
  if get_pkmn == 'FLOETTE'
    floette_form = {
    'YELLOW FLOWER' => 1,
    'ORANGE FLOWER' => 2,
    'BLUE FLOWER' => 3, 
    'WHITE FLOWER' => 4,
    'ETERNAL FLOWER' => 5
    }
    floette_form.has_key?(get_form.upcase) ? form = floette_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(6) : form = 0)
  end
  #get_pkmn has bug with defined Pokemon, default, or random

  if get_pkmn == 'ALCREMIE'
    alcremie_form = {
      'STRAWBERRY RUBY CREAM' => 7,
      'STRAWBERRY MATCHA CREAM' => 14,
      'STRAWBERRY MINT CREAM' => 21,
      'STRAWBERRY LEMON CREAM' => 28,
      'STRAWBERRY SALTED CREAM' => 35,
      'STRAWBERRY RUBY SWIRL' => 42,
      'STRAWBERRY CARAMEL SWIRL' => 49,
      'STRAWBERRY RAINBOW SWIRL' => 56,
      'BERRY VANILLA CREAM' => 1,
      'BERRY RUBY CREAM' => 8,
      'BERRY MATCHA CREAM' => 15,
      'BERRY MINT CREAM' => 22,
      'BERRY LEMON CREAM' => 29,
      'BERRY SALTED CREAM' => 36,
      'BERRY RUBY SWIRL' => 43,
      'BERRY CARAMEL SWIRL' => 50,
      'BERRY RAINBOW SWIRL' => 57,
      'LOVE VANILLA CREAM' => 2,
      'LOVE RUBY CREAM' => 9,
      'LOVE MATCHA CREAM' => 16,
      'LOVE MINT CREAM' => 23,
      'LOVE LEMON CREAM' => 30,
      'LOVE SALTED CREAM' => 37,
      'LOVE RUBY SWIRL' => 44,
      'LOVE CARAMEL SWIRL' => 51,
      'LOVE RAINBOW SWIRL' => 58,
      'STAR VANILLA CREAM' => 3,
      'STAR RUBY CREAM' => 10,
      'STAR MATCHA CREAM' => 17,
      'STAR MINT CREAM' => 24,
      'STAR LEMON CREAM' => 31,
      'STAR SALTED CREAM' => 38,
      'STAR RUBY SWIRL' => 45,
      'STAR CARAMEL SWIRL' => 52,
      'STAR RAINBOW SWIRL' => 59,
      'CLOVER VANILLA CREAM' => 4,
      'CLOVER RUBY CREAM' => 11,
      'CLOVER MATCHA CREAM' => 18,
      'CLOVER MINT CREAM' => 25,
      'CLOVER LEMON CREAM' => 32,
      'CLOVER SALTED CREAM' => 39,
      'CLOVER RUBY SWIRL' => 46,
      'CLOVER CARAMEL SWIRL' => 53,
      'CLOVER RAINBOW SWIRL' => 60,
      'FLOWER VANILLA CREAM' => 5,
      'FLOWER RUBY CREAM' => 12,
      'FLOWER MATCHA CREAM' => 19,
      'FLOWER MINT CREAM' => 26,
      'FLOWER LEMON CREAM' => 33,
      'FLOWER SALTED CREAM' => 40,
      'FLOWER RUBY SWIRL' => 47,
      'FLOWER CARAMEL SWIRL' => 54,
      'FLOWER RAINBOW SWIRL' => 61,
      'RIBBON VANILLA CREAM' => 6,
      'RIBBON RUBY CREAM' => 13,
      'RIBBON MATCHA CREAM' => 20,
      'RIBBON MINT CREAM' => 27,
      'RIBBON LEMON CREAM' => 34,
      'RIBBON SALTED CREAM' => 41,
      'RIBBON RUBY SWIRL' => 48,
      'RIBBON CARAMEL SWIRL' => 55,
      'RIBBON RAINBOW SWIRL' => 62
    }
    alcremie_form.has_key?(get_form.upcase) ? form = alcremie_form[get_form.upcase] : (get_form.casecmp?('Random') ? form = rand(63) : form = 0)
  end

#    pbMessage(_INTL("Choose " + $game_variables[KEY][STARTER_SELECT][0][0].to_s.capitalize + "?"))
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

#Converts wild Pokemon to Moemon form 500+.

#Events.onWildPokemonCreate += proc { |_sender, e|
#  pokemon = e[0]
#  if $game_variables[KEY][MOEMON] == true
#    pokemon.form = (pokemon.form + 500)
#  end
#}

#Adds patterns from Magikarp Jump.
MultipleForms.register(:MAGIKARP,{
  "getFormOnCreation" => proc { |pkmn|
    next rand(32) if $game_switches[MAGIKARP_PATTERNS] = true
  }
})

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

#Disables the use of items from the bag while in battle. Switch [GYM_CHALLENGE]
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
          if $game_switches[GYM_CHALLENGE] == true
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