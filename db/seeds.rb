Tasting.destroy_all
Invitation.destroy_all
Party.destroy_all
User.destroy_all
Wine.destroy_all


kat = User.create name: "Kat", username: "kitkat", password: "Pwpw123", email: "leightkt@gmail.com"
sam = User.create name: "Sam", username: "allstar", password: "Pwpw123", email: "sam.chen8975@gmail.com"

party1 = Party.create date: "2021-02-04", location: "228 Galapago Street", time: "18:00"
party2 = Party.create date: "2021-02-04", location: "228 Galapago Street", time: "20:00"
party3 = Party.create date: "2021-02-14", location: "My House", time: "20:00"

invite1 = Invitation.create(user: kat, party: party1, host: true)
invite2 = Invitation.create(user: sam, party: party1, host: false)
invite3 = Invitation.create(user: sam, party: party2, host: true)
invite4 = Invitation.create(user: kat, party: party2, host: false)
invite5 = Invitation.create(user: sam, party: party3, host: true)

crimes = Wine.create(brand: "19 crimse", name: "The Banished", variety: "Red Blend", year: 2021, wine_type: "red")
snoop = Wine.create(brand: "19 crimse", name: "Snoop Cli Red", variety: "Red Blend", year: 2021, wine_type: "red")

Tasting.create(wine: crimes, user: kat, party: party1, notes: "So good", letter: "A", rating: 7)
Tasting.create(wine: snoop, user: sam, party: party1, notes: "Yum", letter: "B", rating: 9)