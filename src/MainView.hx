package;

import haxe.ui.events.MouseEvent;
import haxe.ui.containers.VBox;

using haxe.ui.animation.AnimationTools;
using StringTools;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
	@:bind(home.convertBtn, MouseEvent.CLICK)
	function convert(e) {
		if (home.input.text?.trim().length > 0) {
			pages.selectedId = "loading";
			loading.run();
			loading.onDone = () -> {
				pages.selectedId = "error";
			}
		} else {
			home.input.flash();
		}
	}
}
