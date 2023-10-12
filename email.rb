require 'mail'

def enviar_email(nome, email_destinatario, email_remetente, assunto, mensagem)
  options = { :address              => "smtp.gmail.com",
              :port                 => 587,
              :user_name            => 'testeanrb@gmail.com',
              :password             => 'rnsa mysf nfys ecap',
              :authentication       => 'plain',
              :enable_starttls_auto => true  }

  Mail.defaults do
    delivery_method :smtp, options
  end

  begin
    mail = Mail.new do
      from    "#{nome} <#{email_remetente}>"
      reply_to email_remetente
      to      email_destinatario
      subject assunto
      body    mensagem
    end

    mail.deliver!

    puts "E-mail enviado com sucesso!"

    rescue Net::SMTPAuthenticationError
      puts "Erro de autenticação. Verifique se o endereço de e-mail do remetente e as credenciais estão corretos."
    rescue Net::SMTPError, StandardError => e
      puts "Erro ao enviar o e-mail. Verifique se o endereço de e-mail do destinatário está correto."
  end
end

loop do
  puts "Por favor, insira o seu nome:"
  nome = gets.chomp

  puts "Por favor, insira o e-mail do destinatário:"
  email_destinatario = gets.chomp

  puts "Por favor, insira o seu e-mail:"
  email_remetente = gets.chomp

  puts "Por favor, insira o assunto do e-mail:"
  assunto = gets.chomp

  puts "Por favor, insira a mensagem do e-mail:"
  mensagem = gets.chomp

  enviar_email(nome, email_destinatario, email_remetente, assunto, mensagem)

  puts "Deseja enviar outro e-mail? (s/n)"
  resposta = gets.chomp.downcase
  break unless resposta == 's'
end
