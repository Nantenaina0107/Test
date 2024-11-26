const nodemailer = require('nodemailer');

// Créer et configurer le transporter nodemailer
const transporter = nodemailer.createTransport({
    host: 'sandbox.smtp.mailtrap.io', 
    port:2525,
    auth: {
      user: '71fa84ff630215', 
      pass: "83f6f72b64c9db", 
    },
  });

  function sendEmail(email, nif, res) {
    // Envoi du NIF par email (comme dans l'exemple précédent)
    const mailOptions = {
        from: 'alfredandrianantenaina7@gmail.com',
        to: email,
        subject: 'Votre Numéro d\'Identification Fiscale (NIF)',
        text: `Bonjour,\n\nVotre inscription est finalisée avec succès. Voici votre NIF : ${nif}\n\nMerci.`
    };
    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            // Répondre en cas d'erreur lors de l'envoi de l'email
            if (!res.headersSent) {
              return res.status(500).json({ message: 'Erreur lors de l\'envoi de l\'email', error: error.message });
            }
        } else {
            // Email envoyé avec succès, répondre à la requête
            console.log('Email envoyé: ' + info.response);
            if (!res.headersSent) {
              return res.status(200).json({ message: 'Email envoyé avec succès', info: info.response });
            }
        }
    });    
  }
  module.exports = { sendEmail };