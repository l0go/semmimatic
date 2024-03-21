package pages;

import haxe.ui.events.MouseEvent;
import haxe.ui.containers.dialogs.Dialog;

using haxe.ui.animation.AnimationTools;

@:build(haxe.ui.ComponentBuilder.build("assets/captcha.xml"))
class Captcha extends Dialog {
	final correctImages = [
		"george" => true,
		"zeta" => true, 
		"notbilly" => true,
		"bulby" => true,
		"dazkind" => true,
	];
	var selectedImages: Map<String, Bool> = [];
	public var onComplete: () -> Void;

	public function new() {
		super();
		for (image in captchaImages.findComponents(haxe.ui.components.Image)) {
			selectedImages.set(image.id, false);
			if (correctImages.get(image.id) == null) {
				correctImages.set(image.id, false);
			}

			image.borderColor = "blue";
			image.onClick = (_) -> {
				selectedImages.set(image.id, !selectedImages[image.id]);
				image.borderSize = image.borderSize > 0 ? 0 : 1.5;
				checkBtn.disabled = !anySelected();
			};
		}
	}

	@:bind(checkBtn, MouseEvent.CLICK)
	function onCheck(_) {
		if (check()) {
			this.hide();
			if (onComplete != null) onComplete();
		} else {
			this.shake();
			checkBtn.disabled = true;
			for (image in captchaImages.findComponents(haxe.ui.components.Image)) {
				image.borderSize = 0;
				selectedImages.set(image.id, false);
			}
		}
	}

	function anySelected(): Bool {
		for (value in selectedImages) {
			if (value) return true;
		}
		return false;
	}

	function check(): Bool {
		for (key => value in correctImages) {
			if (selectedImages[key] != value) {
				return false;
			}
		}
		return true;
	}

}
