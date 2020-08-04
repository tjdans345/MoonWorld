package email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("moonspub0326", "dnwjd13212!@#");
	
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
