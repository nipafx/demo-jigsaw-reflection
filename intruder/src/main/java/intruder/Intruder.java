package intruder;

import java.lang.reflect.Method;
import java.lang.Module;

public class Intruder {

	public static void main(String[] args) throws ClassNotFoundException {
		Class<?> owner = Class.forName("owner.Owner");
		invokeMethods(owner);
//		open(owner, "owner");
//		invokeMethods(owner);
	}

	private static void invokeMethods(Class<?> owner) {
		invoke(owner, "public");
		invoke(owner, "protected");
		invoke(owner, "default");
		invoke(owner, "private");
		System.out.println();
	}

	private static void open(Class<?> type, String packageName) {
		Module owningModule = type.getModule();
		Module intruderModule = Intruder.class.getModule();
		try {
			owningModule.addOpens(packageName, intruderModule);
			System.out.printf("Opened %s/%s to %s.%n", owningModule, packageName, intruderModule);
		} catch (Exception ex) {
			System.out.printf(
					"Could not open %s/%s to %s: %s%n", owningModule, packageName, intruderModule, ex.getMessage());
		}
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
