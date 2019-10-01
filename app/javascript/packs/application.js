import Kuroshiro from "kuroshiro";
import KuromojiAnalyzer from "kuroshiro-analyzer-kuromoji";

const kuroshiro = new Kuroshiro();
kuroshiro.init(new KuromojiAnalyzer({ dictPath: "/dict" })).then(async () => {
    const kanjiCards = document.querySelectorAll('.kanji-card');

    kanjiCards.forEach(async (expression) => {
      const furiganaKanji = expression.querySelector('.furigana-card').innerHTML;
      const result = await kuroshiro.convert(furiganaKanji, { to: "hiragana", mode: "furigana" });
      const furiganafy = expression.querySelector('.add-furigana');
      furiganafy.innerHTML = result;
    })
});