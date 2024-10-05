package org.agriopredict.common;

import java.security.SecureRandom;

public class RandomStringGenerator {

	private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	public static String generateUserId(int length) {
		SecureRandom random = new SecureRandom();
		StringBuilder userId = new StringBuilder("USR"); // Prefix

		for (int i = 0; i < length; i++) {
			int randomIndex = random.nextInt(CHARACTERS.length());
			userId.append(CHARACTERS.charAt(randomIndex));
		}
		return userId.toString();
	}
}
