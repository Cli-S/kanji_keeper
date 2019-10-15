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
  });
  
  const insertFurigana = document.querySelector('.needs-furi');
  const insertDefinition = document.querySelector('.word-definition');
  const domParser = new DOMParser();
  
  fetch('https://kanjiapi.dev/v1/kanji/all').then(r => r.json()).then(async (allKanji) => {
    const today = new Date;
    const numberOfTheDay = parseInt(`${today.getDate()}${today.getMonth()}${today.getFullYear()}`);
    const randomKanji = allKanji[numberOfTheDay % allKanji.length];
    const dailyConversion = await kuroshiro.convert(randomKanji, { to: "hiragana", mode: "furigana" });
    const selectedFurigana = domParser.parseFromString(dailyConversion, "text/html").querySelector("rt").innerText;
    const kanjiChecker = Kuroshiro.Util.isHiragana(selectedFurigana);
    if (kanjiChecker == true) {
      insertFurigana.innerHTML += dailyConversion;
    } else {
      insertFurigana.innerHTML += randomKanji;
    }
    fetch(`https://kanjiapi.dev/v1/words/${randomKanji}`).then(r => r.json()).then((definition) => {
      console.log(definition)
      definition.forEach((element) => {
        const kanjiDef = element['meanings'][0]['glosses'][0];
        insertDefinition.innerHTML += `<p>${kanjiDef}</p>`;
      });
    });
  });
});  
