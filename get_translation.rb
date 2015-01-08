# -*- encoding : utf-8 -*-
require 'nokogiri'
require 'eat'
require "unicode_utils/each_grapheme"

lang = ARGV[0]

puts "please supply language e.g. 'Romanian'" if lang.nil?
exit if lang.nil?

@words = {}
@words["thank you"] = {:id => "an_expression_of_gratitude", :category => "manners"}
@words["sorry"] = {:id => "regretful_for_an_action_or_grieved", :category => "manners"}
@words["excuse me"] = {:id => "request_for_attention", :category => "manners"}
@words["excuse me"] = {:id => "request_to_pass", :category => "manners"}
@words["please"] = {:id => "interjection_to_make_a_polite_request", :category => "manners"}
@words["you're welcome"] = {:id => "reply_to_thanks", :category => "manners"}
@words["don't mention it"] = {:id => "it_is_too_trivial_to_warrant_thanks", :category => "manners"}
@words["yes"] = {:id => "word_used_to_indicate_agreement_or_acceptance", :category => "general"}
@words["no"] = {:id => "used_to_show_disagreement_or_negation", :category => "general"}
@words["i don't understand"] = {:id => nil, :category => "general"}
@words["help"] = {:id => nil, :category => "general"}
@words["hello"] = {:id => "greeting", :category => "saluataions"}
@words["how are you? (formal)"] = {:id => nil ,:category => "salutations"}
@words["fine, thank you"] = {:id => nil,:category => "salutations"}
@words["and you?"] = {:id => nil, :category => "salutations"}
@words["my name is Ryan"] = {:id => nil,:category => "salutations"}
@words["good morning"] = {:id => "when_seeing_someone_for_the_first_time_in_the_morning" ,:category => "salutations"}
@words["good afternoon"] = {:id => "greeting_said_in_the_afternoon" ,:category => "salutations"}
@words["good evening"] = {:id => "greeting_said_in_the_evening" ,:category => "salutations"}
@words["good night"] = {:id => "a_farewell" ,:category => "salutations"}
@words["goodbye"] = {:id => "an_utterance_of_goodbye",:category => "salutations"}
@words["nice to meet you"] = {:id => nil, :category => "salutations"}
@words["nice to meet you"] = {:id => nil, :category => "salutations"}
@words["where is the toilet?"] = {:id => "where_is_the_toilet.3F", :category => "general"}
@words["breakfast"] = {:id => "first_meal_of_the_day", :category => "food"}
@words["lunch"] = {:id => "meal_around_midday", :category => "food"}
@words["dinner"] = {:id => nil, :category => "food"}
@words["how much?"] = {:id => "what_is_the_cost.2Fprice", :category => "general"}
@words["what is this?"] = {:id => nil ,:category => "general"}
@words["i am vegetarian"] = {:id => nil ,:category => "food"}
@words["bon appetit!"] = {:id => nil ,:category => "food"}
@words["cheers/good health!"] = {:id => nil ,:category => "food"}
@words["food"] = {:id => "foodstuff", :category => "food"}
@words["vegetable"] = {:id => nil, :category => "food"}
@words["meat"] = {:id => "animal_flesh_used_as_food", :category => "food"}
@words["chicken"] = {:id => "meat", :category => "food"}
@words["pork"] = {:id => "meat_of_a_pig", :category => "food"}
@words["mutton"] = {:id => "the_flesh_of_sheep_used_as_food", :category => "food"}
@words["beef"] = {:id => "having_beef_as_an_ingredient", :category => "food"}
@words["fish"] = {:id => "flesh_of_fish_as_food", :category => "food"}
@words["egg"] = {:id => "egg_of_domestic_fowl_as_food_item", :category => "food"}
@words["fruit"] = {:id => "food", :category => "food"}
@words["bread"] = {:id => "baked_dough_made_from_cereals", :category => "food"}
@words["noodles"] = {:id => nil, :category => "food"}
@words["rice"] = {:id => "seeds_used_as_food", :category => "food"}
@words["water"] = {:id => "serving_of_water", :category => "food"}
@words["coffee"] = {:id => "beverage", :category => "food"}
@words["tea"] = {:id => "cup_of_this_drink", :category => "food"}
@words["beer"] = {:id => "alcoholic_drink_made_of_malt", :category => "food"}
@words["juice"] = {:id => "beverage_made_of_juice", :category => "food"}
@words["vodka"] = {:id => "clear_distilled_alcoholic_liquor", :category => "food"}
@words["expensive"] = {:id => "having_a_high_price_or_cost", :category => "general"}
@words["cheap"] = {:id => "low_in_price", :category => "general"}
@words["good"] = {:id => "pleasant.3B_enjoyable", :category => "general"}
@words["bad"] = {:id => "not_suitable_or_fitting", :category => "general"}
@words["check please"] = {:id => nil ,:category => "food"}
@words["zero"] = {:id => nil, :category => "numbers", :meaning => "0"}
@words["one"] = {:id => "cardinal_number_1", :category => "numbers", :meaning => "1"}
@words["two"] = {:id => nil, :category => "numbers", :meaning => "2"}
@words["three"] = {:id => nil, :category => "numbers", :meaning => "3"}
@words["four"] = {:id => nil, :category => "numbers", :meaning => "4"}
@words["five"] = {:id => nil, :category => "numbers", :meaning => "5"}
@words["six"] = {:id => nil, :category => "numbers", :meaning => "6"}
@words["seven"] = {:id => nil, :category => "numbers", :meaning => "7"}
@words["eight"] = {:id => nil, :category => "numbers", :meaning => "8"}
@words["nine"] = {:id => nil, :category => "numbers", :meaning => "9"}
@words["ten"] = {:id => nil, :category => "numbers", :meaning => "10"}
@words["11"] = {:id => nil, :category => "numbers"}
@words["12"] = {:id => nil, :category => "numbers"}
@words["13"] = {:id => nil, :category => "numbers"}
@words["14"] = {:id => nil, :category => "numbers"}
@words["15"] = {:id => nil, :category => "numbers"}
@words["16"] = {:id => nil, :category => "numbers"}
@words["17"] = {:id => nil, :category => "numbers"}
@words["18"] = {:id => nil, :category => "numbers"}
@words["19"] = {:id => nil, :category => "numbers"}
@words["20"] = {:id => nil, :category => "numbers"}
@words["21"] = {:id => nil ,:category => "numbers"}
@words["32"] = {:id => nil ,:category => "numbers"}
@words["43"] = {:id => nil ,:category => "numbers"}
@words["54"] = {:id => nil ,:category => "numbers"}
@words["65"] = {:id => nil ,:category => "numbers"}
@words["76"] = {:id => nil ,:category => "numbers"}
@words["87"] = {:id => nil ,:category => "numbers"}
@words["98"] = {:id => nil ,:category => "numbers"}
@words["100"] = {:id => nil, :category => "numbers"}
@words["train"] = {:id => "line_of_connected_cars_or_carriages", :category => "things"}
@words["bus"] = {:id => "vehicle", :category => "things"}
@words["station"] = {:id => "place_where_a_vehicle_may_stop", :category => "things"}
@words["bus terminal"] = {:id => nil, :category => "things"}
@words["airplane"] = {:id => "powered_aircraft", :category => "things"}
@words["airport"] = {:id => "a_place_designated_for_airplanes", :category => "things"}
@words["taxi"] = {:id => "vehicle", :category => "things"}
@words["bicycle"] = {:id => "vehicle", :category => "things"}
@words["ticket"] = {:id => "pass_for_transportation", :category => "things"}
@words["hotel"] = {:id => "establishment_providing_accommodation", :category => "things"}
@words["reservation"] = {:id => "arrangement_by_which_something_is_secured_in_advance", :category => "things"}
@words["passport"] = {:id => "official_document", :category => "things"}
@words["now"] = {:id => "at_the_present_time", :category => "time"}
@words["later"] = {:id => "at_some_time_in_the_future", :category => "time"}
@words["earlier"] = {:id => "previously.3B_before_now.3B_sooner", :category => "time"}
@words["morning"] = {:id => "part_of_the_day_between_dawn_and_midday", :category => "time"}
@words["afternoon"] = {:id => "part_of_the_day_between_noon_and_evening", :category => "time"}
@words["evening"] = {:id => "time_of_day_between_dusk_and_night", :category => "time"}
@words["night"] = {:id => "period_between_sunset_and_sunrise", :category => "time"}
@words["yesterday"] = {:id => "day_before_today", :category => "time"}
@words["today"] = {:id => "on_the_current_day", :category => "time"}
@words["tomorrow"] = {:id => "the_day_after_the_present_day", :category => "time"}
@words["1 minute"] = {:id => nil, :category => "time"}
@words["1 hour"] = {:id => nil, :category => "time"}
@words["1 day"] = {:id => nil, :category => "time"}
@words["monday"] = {:id => nil, :category => "time"}
@words["tuesday"] = {:id => nil, :category => "time"}
@words["wednesday"] = {:id => nil, :category => "time"}
@words["thursday"] = {:id => nil, :category => "time"}
@words["friday"] = {:id => nil, :category => "time"}
@words["saturday"] = {:id => nil, :category => "time"}
@words["sunday"] = {:id => nil, :category => "time"}
@words["january"] = {:id => nil, :category => "time"}
@words["february"] = {:id => nil, :category => "time"}
@words["march"] = {:id => nil, :category => "time"}
@words["april"] = {:id => nil, :category => "time"}
@words["may"] = {:id => nil, :category => "time"}
@words["june"] = {:id => nil, :category => "time"}
@words["july"] = {:id => nil, :category => "time"}
@words["august"] = {:id => nil, :category => "time"}
@words["september"] = {:id => nil, :category => "time"}
@words["october"] = {:id => nil, :category => "time"}
@words["november"] = {:id => nil, :category => "time"}
@words["december"] = {:id => nil, :category => "time"}
@words["my hovercraft is full of eels!"] = {:id => nil, :category => "general"}
@words["australia"] = {:id => nil, :category => "proper nouns"}

@lang_key = {}
@lang_key["Russian"] = "ru"
@lang_key["Romanian"] = "ro"

def wiktionary_uri name
	"http://en.wiktionary.org/wiki/#{name.gsub(" ", "_")}"
end

def get_wiki_content name
	@wikipedia_call ||= {}
	@wikipedia_call[name] ||= Nokogiri::XML(eat(wiktionary_uri(name), :timeout => 10))

	@wikipedia_call[name]    
end

def get_translation word, lang
	content = ""
	begin
		content = get_wiki_content(word)
	rescue
		return ""
	end
	
	if @words[word][:id].nil?
		puts content.xpath("//div[contains(@id, 'Translations-')]/@id")
		""
	else
		translation = content.at_xpath("//div[@id='Translations-#{@words[word][:id]}']//li[contains(text(), '#{lang}')]/span[@lang='#{@lang_key[lang]}']/a")
		return "" if translation.nil?
		translation.text()
	end
end

@words.each do |word, key|
	meaning = @words[word][:meaning]
	meaning ||= word

	puts "{'meaning':'#{meaning}','word':'#{get_translation(word, lang)}','ipa':'','category':'#{@words[word][:category]}'}"
end