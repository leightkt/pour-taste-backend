Tasting.destroy_all
Party.destroy_all
User.destroy_all
Wine.destroy_all


kat = User.create name: "Kat", username: "kitkat", password: "Pwpw123", email: "leightkt@gmail.com"
sam = User.create name: "Sam", username: "allstar", password: "Pwpw123", email: "sam.chen8975@gmail.com"

party1 = Party.create(user_id: kat.id, date: "Mon Feb 15 2021 18:25:15 GMT-0700", location: "228 Galapago Street", time: "18:00")
party2 = Party.create(user_id: sam.id, date: "Mon Feb 15 2021 18:25:15 GMT-0700", location: "228 Galapago Street", time: "20:00")

crimes = Wine.create(brand: "19 crimse", name: "The Banished", variety: "Red Blend", year: 2021, wine_type: "red")
snoop = Wine.create(brand: "19 crimse", name: "Snoop Cli Red", variety: "Red Blend", year: 2021, wine_type: "red")

Tasting.create(wine: crimes, user: kat, party: party1, notes: "So good", letter: "A", rating: 7)
Tasting.create(wine: snoop, user: kat, party: party1, notes: "Yum", letter: "B", rating: 9)