package pages;

import haxe.ui.containers.Box;
import howler.Howl;

using haxe.ui.animation.AnimationTools;

@:build(haxe.ui.ComponentBuilder.build("assets/loading.xml"))
class Loading extends Box {
	final captions = [
		'loading ;)',
		'checking -> "word"-magic',
		'reading peote-net -> packets',
		'oh listening to KrAfTwErK',
		'readingEnglishDictionary,)',
		'(looking back at perl-times)',
		'you are 5th in line, please be patient!',
		'where .. into botspam?',
		'fractalizing cycles',
		'Übersetzungsmagie',
		'mypaint M A G I C'
	];

	public var onDone: () -> Void;

	public function run() {
		var dialog = new pages.Captcha();

		final loadingSong = new Howl({
			src: ["static/loading.mp3"],
			autoplay: false,
			loop: true
		});

		// uncomment if you want full loading for some reason lmao
		//loadingSong.on("end", () -> {
		haxe.Timer.delay(() -> {
			dialog.showDialog();
			dialog.onComplete = () -> {
				loadingSong.pause();
				onDone();
			};
		}, 25 * 1000);
		
		loadingSong.play();

		nextCaption(0);
	}

	function nextCaption(i: Int = 0) {
		changeCaption(captions[i % captions.length], i);
	}

	function changeCaption(text: String, ?i: Int) {
		loadingCaption.fadeOut(() -> {
			loadingCaption.text = text;		
			loadingCaption.fadeIn(() -> {
				if (i != null) nextCaption(i + 1);
			});
		});
	}
}
