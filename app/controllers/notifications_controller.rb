class NotificationsController < ApplicationController
    def self.sms(to, message)
        client = Nexmo::Client.new(key: Rails.application.secrets.nexmo_api_key, secret: Rails.application.secrets.nexmo_api_secret)
        response = client.send_message(from: "Cola", to: to, text: message )
        if response['messages'][0]['status'] == '0'
            ""
        else
            "Error: #{response['messages'][0]['error-text']}"
        end 
    end 

    def self.tts(to, message)
        uri = URI.parse("https://api.nexmo.com/tts/json")
        response = Net::HTTP.post_form(uri, {api_key: Rails.application.secrets.nexmo_api_key, api_secret: Rails.application.secrets.nexmo_api_secret, to: "+#{to}", from: "7273", text: "#{message}" })
        if response.body.include?("Success")
            ""
        else
           response.body
        end 
    end
end