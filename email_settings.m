%Tested with Gmail
%Make sure you visit https://myaccount.google.com/security#signin and in the section "Apps with account access" change "Allow less secure apps" to ON

%Change the following details
email_address = '???@gmail.com';
user_name = '???';
password = '???';


setpref('Internet','SMTP_Server', 'smtp.gmail.com');
setpref('Internet','E_mail', email_address);
setpref('Internet','SMTP_Username', user_name);
setpref('Internet','SMTP_Password', password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');