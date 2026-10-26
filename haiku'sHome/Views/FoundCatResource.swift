//
//  FoundCatResource.swift
//  haiku'sHome
//
//  Created by Sabrina C. Sales on 28/12/2023.
//

import SwiftUI

struct FoundCatResource: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Health (First Check-up)")
                    .bold()
                Text( """
Take the kitty you’ve found to a nearby or trusted veterinary clinic to make sure all is well. Most vets provide rescue rates/fees so make sure you explain this to them. You may want to ask the vet to check the following points:
❏ Teeth (Esp. if the breath smells bad or you see a visible problem with the mouth.)
❏ Skin (Esp. Ringworm)
❏ Parvovirus (Esp. for kittens.)
❏ Trio Test (Esp. for cats that appear visibly ill. This test is to check for FIV, Feline Corona, FeLV.)
❏ Ears (Esp. for mites.)

""")
                
                Text("Health (Follow-up)")
                    .bold()
                    
                Text("""
These are the points you may want to discuss with your vet if you are looking to find a home for the cat you’ve rescued.
❏ Vaccination (eg. Rabies and PCH vaccinations are specific to the UAE; note that each country has a different brand of vaccine/requirements of vaccines)
❏ Microchip
❏ Deworming
❏ Neuter/Spay
❏ Resolved any other relevant health issues (e.g. ringworm, ear mites).

""")
                Text("Foster Home")
                    .bold()
                Text("""
If you are unable to look after the cat you’ve found in your own home long-term, begin to look for a foster home. You may want to start by asking friends and family, or posting on your own social media pages. Please note, the cat is safe enough in a spare room, maid’s room, or bathroom in your own home short-term. It is better than them being returned outside, especially if they are injured.

When speaking to potential fosters/adopters, please remember to thoroughly vet people who you do not know - get a sense of whether you think they’ll do a good job looking after the cat, will they have time for it, do they have space for it etc. The foster is just providing space and time. Once you decide to rescue a cat, you will be responsible for the vet bills and visits as well as providing items for the cat’s care and finding it a home. Some volunteers may offer to help you cover vet bills and expenses so do make sure you try to get the word out to family and friends and find your local cat community groups to post in.

""")
                Text("Items to provide to your foster if they don’t already have them:")
                    .bold()
                Text("""
❏ Litter box, scoop & litter
❏ Food & water dishes
❏ Cat biscuits and Treats (wet food only if it is needed due to special diet or having to administer medication)
❏ Toys
❏ Blanket
❏ Bed
❏ Scratching Post
❏ Brush

""")
                
                Text("Adoption")
                    .bold()
                Text("""
When it comes to finding a home for the cat you’ve rescued, you have two options: a local UAE adoption or an international adoption.

Local Adoptions:
+ You can meet your adopters in person.
+ No flights, so the whole process is less expensive.
- It takes much longer to find suitable adopters.

International Adoptions:
+ You find suitable adopters quickly.
+ There is a much lower chance of cats being dumped or returned to you.
- You need to meet your adopters virtually.
- Flights are expensive.

""")
                Text("Vetting Potential Adopters")
                    .bold()
                Text("""
When considering potential adopters it is really important to make sure you ask them lots of questions. You may want to create a questionnaire, or copy and paste some questions to them in a message. Remember, the cat you have rescued is relying on you to make a decision about their future home, so please make the best one possible!
❏ Have you thought about where to put the cat’s belongings eg. litter box?
❏ Is your house safe for cats e.g. If you live on a high floor, are you willing to get the balcony netted or keep the
door closed?
❏ Are you willing to pay an adoption fee?
❏ About how many hours are you away from home?
❏ About how many hours of playtime do you think you can provide your cat?
❏ Do you have experience looking after cats?
❏ Are you or is anyone in your home allergic to cats?
❏ What will you do if your cat gets sick?
❏ What will you do if you move house or country?
❏ Why are you interested in adopting a cat?
If you’re happy with the responses it may be worth moving forward to a phone call, an in-person meeting, or a virtual meeting via Zoom. Also remember to ask a potential adopter for pictures of their home, or a video tour. If you’re moving forward with an international adoption, it is even more important to see what the potential adopters home looks like so you can assess if it is the right fit and sufficiently safe for your rescued cat.

""")
                Text("Relocation")
                    .bold()
                Text("""
If you have chosen to move forward with an international adoption, you will start to consider how you might relocate your rescued cat. In some situations you may require a flight buddy, and in others you may be permitted to have your rescued cat fly on its own.

""")
                Text("Finalising the Adoption")
                    .bold()
                Text("""
Local Adoption:
Before you finalize the adoption, ensure you have given the potential adopter a chance to have a 2-3 week adoption trial. An adoption trial ensures that both parties have had a chance to test whether this is the right fit.
When both parties have decided they want to go ahead with the adoption, ensure you have done the following:
❏ Prepared and signed an adoption contract;
❏ Switched the ownership under the microchip at your respective veterinary clinic (this can be done via email);
❏ Settled the agreed upon adoption fee.
*Tip: Keep the veterinary bills from your appointments with your rescued cat. The adopter can pay the cost of whatever you have spent on: a spay/neuter, vaccinations, microchip, and deworming. These are the costs they would have had to cover anyway if they want to have a cat.

International Adoption:
When both parties feel comfortable moving forward with the adoption, make sure to settle the following:
❏ The adoption fee (when it will be paid and how much);
❏ The contract (prepare and sign the contract electronically);
❏ The flight details (when and where their new kitty will fly);
❏ Where to register their pet’s new microchip;
❏ Where to purchase pet insurance (if applicable).

""")
                
                Text("""
Thank you for the important work you are doing and best of luck on your journey! Picking up a stray or injured cat and rescuing it through to the end is not easy, but it is very rewarding.
                     
"Saving one cat will not change the world, but surely for that one cat, the world will change forever.”
""")
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .navigationBarTitle("I found a cat that needs help!")
    }
}


#Preview {
    FoundCatResource()
}
