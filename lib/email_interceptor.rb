 class EmailInterceptor # au moment ou mon message est envoyé, ça modifie le destinataire, en developpement
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = [ 'paul@takeawaytrips.com' ]
  end
end
