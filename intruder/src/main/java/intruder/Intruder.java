package intruder;

import java.lang.reflect.Method;

public class Intruder {

	public static void main(String[] args) throws ClassNotFoundException {
		Class<?> owner = Class.forName("owner.Owner");
		invoke(owner, "public");
		invoke(owner, "protected");
		invoke(owner, "default");
		invoke(owner, "private");
		System.out.println();
	}

	private static void invoke(Class<?> type, String visibility) {
		System.out.print(visibility + ":");
		try {
			Method owned = type.getDeclaredMethod(visibility + "Method");
			owned.setAccessible(true);
			owned.invoke(null);
			System.out.print(" ✔   ");
		} catch (Exception ex) {
			System.out.print(" ✘   ");
		}
	}

}
