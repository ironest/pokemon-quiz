require "httparty"
require "JSON"
require "open-uri"

quiz = {
    name: "",
    types: [],
    answer: ""
}

def get_user_input
    while true do    
        answer = gets.chomp.to_i
        if (1..3).include?(answer)
            return answer - 1
        else 
            print "Please enter a valid input: "
        end
    end
end

def get_pokemon_data

    base_api = "https://pokeapi.co/api/v2"
    endpoint = "/pokemon/"
    pokemon_id = rand(1..150).to_s

    final_uri = base_api +
                endpoint +
                pokemon_id

    response = HTTParty.get(
        final_uri,
        {
            body: {
            },
            headers: {
            }
        }
    )
    
    if (response.code != 200)
        puts "Something went wrong while querying the API"
        exit
    end

    return JSON.parse(response.body)

end

data = get_pokemon_data

quiz[:name] = data["species"]["name"]
quiz[:types].push data["types"][0]["type"]["name"]
quiz[:answer] = data["types"][0]["type"]["name"]

while (quiz[:types].length < 3)

    data = get_pokemon_data

    type = data["types"][0]["type"]["name"]

    if not quiz[:types].include?(type)
        quiz[:types].push type
    end

end

quiz[:types].shuffle!

puts "What is #{quiz[:name].capitalize} type? "
puts " 1. #{quiz[:types][0].capitalize}"
puts " 2. #{quiz[:types][1].capitalize}"
puts " 3. #{quiz[:types][2].capitalize}"


guess = get_user_input

if quiz[:answer] == quiz[:types][guess]
    puts "Correct!"
else
    puts "Nope, #{quiz[:name]} is a #{quiz[:answer]} pokemon"
end

