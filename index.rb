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
