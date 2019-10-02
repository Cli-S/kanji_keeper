import Kuroshiro from "kuroshiro";
import KuromojiAnalyzer from "kuroshiro-analyzer-kuromoji";

const kuroshiro = new Kuroshiro();

kuroshiro.init(new KuromojiAnalyzer({ dictPath: "/dict" })).then(async () => {
  const kanjiCards = document.querySelectorAll('.kanji-card');

  kanjiCards.forEach(async (element) => {
    if(element.classList.contains('has-furigana')) {
      return;
    } else {
      const furiganaKanji = element.querySelector('.furigana-card').innerHTML;
      const result = await kuroshiro.convert(furiganaKanji, { to: "hiragana", mode: "furigana" });
      const furiganafy = element.querySelector('.add-furigana');
      furiganafy.innerHTML = result;
      element.classList.add('has-furigana');
    }
  })
});

