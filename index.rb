require "httparty"
require "JSON"


quiz = {
    name: "",
    types: [],
    answer: "",
    image: ""
}

base_api = "https://pokeapi.co/api/v2"
pokemon_endpoint = "/pokemon/"
type_endpoint = "/type/"

pokemon_id = rand(1..150)
final_uri = base_api +
            pokemon_endpoint +
            pokemon_id.to_s
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
    puts "Something went wrong"
    exit
end

data = JSON.parse(response.body)

quiz[:name] = data["species"]["name"]
quiz[:types].push data["types"][0]["type"]["name"]
quiz[:answer] = data["types"][0]["type"]["name"]
quiz[:image] = data["sprites"]["front_default"]

open("image.png", "wb") do |file|
    file << open(quiz[:image]).read
end
