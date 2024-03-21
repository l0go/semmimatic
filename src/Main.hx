package;

import haxe.ui.HaxeUIApp;
import haxe.ui.Toolkit;

class Main {
	public static function main() {
		final app = new HaxeUIApp();
		Toolkit.theme = 'semmi';
		app.ready(() -> {
			app.addComponent(new MainView());
			app.start();
		});
	}
}
