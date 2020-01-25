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
  const insertKun = document.querySelector('.kunyomi');
  const insertOn = document.querySelector('.onyomi');
  const insertStroke = document.querySelector('.stroke-order');
  const insertJisho = document.querySelector('.jisho-url');
  const domParser = new DOMParser();
  
  if (insertJisho !== null) {
    fetch('https://kanjiapi.dev/v1/kanji/joyo').then(r => r.json()).then(async (allKanji) => {
      const today = new Date;
      const numberOfTheDay = parseInt(`${today.getDate()}${today.getMonth()}${today.getFullYear()}`);
      const randomKanji = allKanji[numberOfTheDay % allKanji.length + 1];
  //  const dailyConversion = await kuroshiro.convert(randomKanji, { to: "hiragana", mode: "furigana" });
  //  const selectedFurigana = domParser.parseFromString(dailyConversion, "text/html").querySelector("rt").innerText;
  //  const kanjiChecker = Kuroshiro.Util.isHiragana(selectedFurigana);
  //    if (kanjiChecker == true) {
  //      insertFurigana.innerHTML += dailyConversion;
  //    } else {
  //      insertFurigana.innerHTML += randomKanji;
  //    }
      fetch(`https://kanjiapi.dev/v1/kanji/${randomKanji}`).then(r => r.json()).then((definition) => {
        insertFurigana.innerHTML += randomKanji;
        definition['kun_readings'].forEach((element) => {
          const kunyomi = element;
          insertKun.innerHTML += `<p>${kunyomi}</p>`;
        });
        definition['on_readings'].forEach((element) => {
          const onyomi = element;
          insertOn.innerHTML += `<p>${onyomi}</p>`;
        });
        // const kanjiDef = [];
        // definition['meanings'].forEach((element) => {
        //   kanjiDef.push(element);
        // });
        const joiningDef = definition['meanings'].join(', ');
        insertDefinition.innerHTML += `${joiningDef}`;
      });
      insertJisho.innerHTML += `<a href="https://jisho.org/search?utf8=✓&keyword=${randomKanji}">learn more</a>`
    });
  }
});  

const cliConsole = [
  `\n %c made by Cli ✨ c.someponpakdi@gmail.com`,
  'background-image: linear-gradient(to right, #FF768A, #90cedb); padding: 10px 0; font-family: courier;'
];
window.console.log(...cliConsole);