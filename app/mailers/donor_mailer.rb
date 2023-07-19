class DonorMailer < ApplicationMailer
   default from: "from@example.com"

   def donation_email
     @donation = params[:donation]
     mail(to: @donation.email, subject: 'Mil grcias por tu dinacion')
   end
end
