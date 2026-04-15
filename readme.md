[English version of this readme is available in the file readme.en.md](./readme.en.md)

# Ensimmäiset Playwright-testit 🎭

Tämän tehtävän tarkoituksena on kirjoittaa ensimmäiset testit Playwright-työkalulla. Tehtävässä testataan yksinkertaisen web-sivuston toiminnallisuuksia, eli kirjautumista ja rekisteröitymistä. Tavoitteina on oppia suorittamaan operaatioita (actions) kuten tekstin syöttämistä ja painikkeiden painamista, sekä tarkastamaan (assert) tuloksia, kuten virheilmoituksia ja onnistumisviestejä.

Tässä tehtävässä käytettävä esimerkkisivusto on toteutettu testauksen harjoittelua varten, joten se ei noudata kaikkia tavanomaisia tuotantokäytössä olevien web-sivustojen oletuksia. Suurimpana eroavaisuutena sivuston kautta tehdyt rekisteröitymiset ja kirjautumiset **ovat voimassa vain saman selaimen sisällä**. Rekisteröitymiset ja kirjautumiset eivät siis vaikuta eri selainten tai testitapausten välillä.

Playwright suorittaa testejä rinnakkain ja suoritusten järjestys ei ole taattu, joten testiselain nollataan aina jokaisen testin alussa. Yhdessä testissä tekemäsi rekisteröityminen tai kirjautuminen ei siis ole voimassa enää seuraavissa testitapauksissa.

> *"Playwright creates a browser context for each test. Browser context is equivalent to a brand new browser profile. This delivers full test isolation with zero overhead."*
>
> https://playwright.dev/

Tässä dokumentissa löytyy toteutettaviin testitapauksiin ja testattavaan sivustoon liittyvät tiedot, ja pääasiallinen materiaali testien kirjoittamiseksi löytyy [Playwrightin dokumentaatiosta](https://playwright.dev/docs/writing-tests). Tekstimuotoisen dokumentaation lisäksi voit hyödyntää lukuisia videoita ja tutoriaaleja, joita löytyy esimerkiksi Playwrightin [YouTube-kanavalta](https://www.youtube.com/@Playwrightdev/videos).

Suosittelemme tässä tehtävässä katsomaan videon [Generating Playwright Tests in VS Code](https://www.youtube.com/watch?v=LM4yqrOzmFE), jossa näytetään sekä testien "nauhoittamista" että elementtien paikallistamista sivulta hyödyntäen VS Code:n "Pick locator" -toimintoa.

Jos et katsonut vielä edellisessä tehtävässä videota [Introduction to Playwright for End-to-End Testing with Debbie O'Brien (JS Drops, youtube.com)](https://youtu.be/lCb9JoZFpHI), suosittelemme katsomaan sen, jotta saat yleiskuvan Playwrightin ja sen työkalujen käytöstä.


## Tehtävän ja testauksen lähtökohdat

Tässä tehtävässä oletetaan, että olet suorittanut aikaisemman tehtävän, jossa harjoiteltiin Playwright-projektin luontia ja asennusta sekä testien suorittamista. Jos et ole vielä tehnyt sitä, suosittelemme aloittamaan siitä. Testit voidaan suorittaa niin komentoriviltä, Visual Studio Code -editorista kuin Playwrightin UI-työkalusta, joten tiettyä tapaa ei ole erikseen määritelty.

Tehtävärepositorio sisältää jo valmiiksi Playwright-projektin pohjan, jonka voit asentaa ja käynnistää seuraavasti:

```bash
npm install
npx playwright test
```

Testien suorittaminen edellyttää myös selainten asentamista, minkä olet toivottavasti tehnyt jo aikaisemmassa tehtävässä. Tarvittaessa [asenna testiselain Playwrightin ohjeita seuraten](https://playwright.dev/docs/browsers).


## Testattava sivusto

Testauksen kohteena toimii esimerkkisivusto https://authentication-6o1.pages.dev/, joka sisältää pienen määrän ominaisuuksia palveluun kirjautumiseksi ja käyttäjätunnusten luomiseksi. Sivusto on pyritty luomaan samalla yksinkertaiseksi, mutta myös laadukkaaksi, jotta se toimisi hyvänä ensimmäisenä testauskohteena. Laadun osalta esimerkiksi eri kenttien labelit ja virheilmoitukset on pyritty toteuttamaan niin, että niitä on helppo yksilöidä ja käsitellä ohjelmallisesti testeissä.

Sivustoa on tarkoitus testata "black box" -mallilla, eli testien kirjoittamiseksi ei ole tarkoitus perehtyä sivuston lähdekoodiin tai verkkoliikenteeseen. HTML-rakenteiden tutkiminen on kuitenkin tarpeen, jotta saat suoritettua testeissä tarvitsemasi operaatiot tekstikentille ja painikkeille.


### Rekisteröityminen

Sivustolle rekisteröityminen onnistuu osoitteessa https://authentication-6o1.pages.dev/signUp. Testisivustossa on painikkeet myös ulkoisten palveluiden hyödyntämiseen rekisteröitymisessä, mutta niihin ei ole toteutettu toiminnallisuutta.

Rekisteröityminen tällä lomakkeella luo uuden käyttäjätunnuksen, joka on voimassa vain yhden selaimen tai testitapauksen sisällä.

> [!TIP]
> Mikäli haluat hyödyntää Playwrightin edistyneempiä ominaisuuksia, voit myös tallentaa rekisteröitymisen ja kirjautumisen tilan ja uudelleenkäyttää sitä eri testeissä. Tällainen lähestymistapa on erityisen hyödyllistä laajemmissa testisarjoissa, joissa halutaan välttää kirjautumisen toistaminen jokaisessa testissä.
>
> Lue aiheesta lisää sivulta https://playwright.dev/docs/auth.


### Kirjautuminen

Kirjautuminen onnistuu osoitteessa https://authentication-6o1.pages.dev/. Kirjautumisen jälkeen käyttäjä ohjataan osoitteeseen https://authentication-6o1.pages.dev/dashboard, jossa näytetään tervetuloa-viesti. Kuten rekisteröityminen, myös kirjautuminen on voimassa vain saman istunnon sisällä.

Itse luotavien tunnusten lisäksi sivustolla on valmiita tunnuksia, jotka ovat aina voimassa:

| Name     | Username             | Password                           | Env variables in GitHub \*         |
|----------|----------------------|------------------------------------|------------------------------------|
| Jane Doe | jane.doe@example.com | `ItWorksOnMyMac1!`                 | `JANE_USERNAME`, `JANE_PASSWORD`   |
| John Doe | john.doe@example.com | `AllTestsPass1!`                   | `JOHN_USERNAME`, `JOHN_PASSWORD`   |
| Alice    | alice@example.com    | `}3jc\xJnQ=E=+Q_y/%Hd311bW#6{_Oyj` | `ALICE_USERNAME`, `ALICE_PASSWORD` |
| Bob      | bob@example.com      | `nUL9zA3q=Nt7\N,0?CL&c74U,Ic)0)dN` | `BOB_USERNAME`, `BOB_PASSWORD`     |

Voit käyttää näitä tunnuksia niissä testitapauksissa, joissa tarvitset olemassa olevan käyttäjän kirjautumista tai rekisteröitymistä, tai haluat varmistaa, että samalla tunnuksella ei voi rekisteröityä uudelleen.

\* *Lue lisää ympäristömuuttujien käytöstä tämän dokumentin loppuosasta.*


## Omien testien toteuttaminen

Kun olet saanut projektin riippuvuudet asennettua ja kokeillut testauksen kohteena olevaa sivustoa, voit aloittaa omien testien kirjoittamisen. Tässä tehtävässä tavoitteena on kirjoittaa testitapaukset sivuston rekisteröitymiseen ja kirjautumiseen. Voit kirjoittaa testit joko yhteen tiedostoon tai eri tiedostoihin, riippuen siitä, miten haluat järjestää testitapauksesi. Tiedostojesi tulee noudattaa Playwrightin testitiedostojen nimeämiskäytäntöä, eli niiden tulee päättyä `.spec.ts`- tai `.spec.js`-päätteeseen.

Suorita omia testejäsi sitä mukaa, kun kirjoitat niitä, jotta voit varmistaa, että ne toimivat odotetusti. Voit suorittaa testit joko yksittäin tai kaikki kerralla riippuen siitä, miten haluat testata niitä. Voit myös käyttää Playwrightin UI-työkalua testien suorittamiseen, jos haluat seurata testien suoritusta visuaalisesti.


## Testitapaukset

Johda seuraavista vaatimuksista testitapaukset ja kirjoita niille Playwright-testit. Kussakin testitapauksessa tulee tehdä tarkoituksenmukaiset toimet (actions) ja tehdä vaadittavat tarkastukset (asserts), jotta voidaan varmistaa, että testattava toiminnallisuus toimii odotetusti. Testitapauksissa tulee huomioida myös tyypilliset virhetilanteet ja niiden käsittely.


### Kirjautuminen

1. Palvelun etusivulla tulee olla kirjautumislomake, jossa on kentät sähköpostille ja salasanalle sekä kirjautumispainike
2. Rekisteröity käyttäjä voi kirjautua sisään sähköpostilla ja salasanalla
    * Kirjautuminen tulee olla kirjainkoosta riippumaton sähköpostikentälle, mutta salasanan kirjainkoon tulee olla täsmälleen oikein
3. Onnistuneen kirjautumisen jälkeen käyttäjä ohjataan osoitteeseen `/dashboard`, jossa näytetään tervetuloa-viesti
4. Kirjautumisen tulee estää luvaton pääsy
    * Sekä sähköposti että salasana ovat pakollisia
    * Puuttuvat tai virheelliset arvot tulee näyttää virheilmoituksina (virheellinen sähköposti tai salasanan pituus)
    * Epäonnistunut kirjautuminen pitää käyttäjän kirjautumissivulla ja näyttää virheilmoituksen
5. Käyttäjät eivät voi päästä suoraan osoitteeseen `/dashboard` ilman onnistunutta kirjautumista
    * käyttäjä tulee ohjata takaisin kirjautumissivulle
    * käyttäjälle tulee näyttää virheilmoitus
6. Kun kirjautunut käyttäjä kirjautuu ulos, hänet ohjataan takaisin kirjautumissivulle


### Rekisteröityminen

1. Rekisteröityminen tulee olla mahdollista sekä suoraan osoitteessa `/signUp` että etusivun linkin kautta
2. Nimi, sähköposti ja salasana ovat pakollisia rekisteröitymisessä
    * Puuttuvat tai virheelliset tiedot tulee näyttää virheilmoituksina
3. Rekisteröitymistä yritettäessä jo rekisteröidyllä sähköpostilla tulee näyttää virheilmoitus
    * Rekisteröityminen on kirjainkoosta riippumaton sähköpostikentälle, joten vain kirjainkoosta poikkeavan sähköpostin käyttö ei voi johtaa onnistuneeseen rekisteröitymiseen
4. Rekisteröityminen vaadituilla tiedoilla luo uuden käyttäjätilin
    * Rekisteröitymisen jälkeen tulee näyttää onnistumisviesti
    * Rekisteröitymisen jälkeen käyttäjä ohjataan kirjautumissivulle
5. Rekisteröitymisessä luotu tili tulee olla käytettävissä kirjautumiseen heti sen jälkeen (saman selainistunnon sisällä)


### Ohjeita ja esimerkkejä

Näiden testien kirjoittamisen myötä tavoitteena on oppia tekemään sivun sisällölle erilaisia toimenpiteitä hyödyntäen Playwrightin tarjoamia toimintoja. Lue lisää testien kirjoittamisesta [Playwrightin dokumentaatiosta (playwright.dev)](https://playwright.dev/docs/writing-tests).

Mikäli haluat tutkia esimerkkejä Playwright-testeistä, olemme lisänneet tähän repositorioon valmiiksi [demo-todo-app.spec.ts](./tests-examples/demo-todo-app.spec.ts)-tiedoston, jossa on esimerkkejä toimintojen ja tarkastusten käytöstä. Voit käyttää sitä apuna testien kirjoittamisessa ja soveltaa sen esimerkkejä omiin testitapauksiisi. Jos haluat suorittaa kyseisen tiedoston testejä, joudut siirtämään sen ensin `tests`-kansioon, jotta Playwright tunnistaa sen testitiedostoksi. Älä kuitenkaan lähetä kyseistä esimerkkitiedostoa tests-hakemistossa GitHubiin, jotta siinä olevat testit eivät sekoitu omiin ratkaisuihisi.

> [!NOTE]
> *demo-todo-app.spec.ts* on Playwrightin esimerkki, joka on lisensoitu [Apache 2.0 -lisenssillä](https://github.com/microsoft/playwright/blob/main/LICENSE). Se on lainattu tähän tehtävään opetus- ja esimerkkimateriaaliksi.


### Käyttäjätunnukset ja salasanat ympäristömuuttujissa

Käyttäjätunnusten, salasanojen ja API-avainten kirjoittaminen selkokielisinä testitapauksiin ei ole suositeltavaa, sillä ne voivat olla alttiita vahingossa julkaisemiselle. Tässä tapauksessa testijärjestelmän salasanat ovat julkisia, joten ongelma ei ole merkittävä, mutta on hyvä harjoitella myös salasanojen käsittelyä turvallisesti.

Parempi tapa käsitellä salasanoja voisi olla salaisuuksien tallentaminen ympäristömuuttujiin tai salaisuuksiksi. Playwrightin testit voivat käyttää ympäristömuuttujia, joten voit tallentaa salasanat esimerkiksi `.env`-tiedostoon ja lukea ne testitapauksissa ympäristömuuttujista. Luomasi `.env`-tiedosto puolestaan voidaan rajata versionhallinnan ulkopuolelle [.gitignore-tiedoston](./.gitignore) avulla.

Suosittelemme tutustumaan ympäristömuuttujiin ja hyödyntämään niitä tässä tehtävässä. Voit lukea lisää ympäristömuuttujista [Playwrightin dokumentaatiosta (playwright.dev)](https://playwright.dev/docs/test-parameterize#env-files). Tiedostopohjaisia ympäristömuuttujia varten tarvitset lisäksi [dotenv-paketin](https://www.npmjs.com/package/dotenv), joka tulee ottaa käyttöön [playwright.config.ts](./playwright.config.ts)-tiedoston yläosassa.

> [!NOTE]
> Jotta muuttujat toimivat oikein sekä omassa kehitysympäristössäsi että GitHub actions -arvioinnissa, vain seuraavat ympäristömuuttujat ovat tuettuja:
>
> * `JANE_USERNAME` & `JANE_PASSWORD`
> * `JOHN_USERNAME` & `JOHN_PASSWORD`
> * `ALICE_USERNAME` & `ALICE_PASSWORD`
> * `BOB_USERNAME` & `BOB_PASSWORD`


## Tehtävän automaattinen arviointi

Kun olet kirjoittanut testitapaukset ja varmistanut, että ne toimivat odotetusti, voit palauttaa tehtävän automaattista tarkastusta varten. Lisää luomasi testitiedostot versionhallintaan ja lähetä muutokset GitHubiin `git status`, `git add`, `git commit` ja `git push` -komennoilla. `push`-komennon jälkeen käynnistyy GitHub action -automaattitarkastus, joka suorittaa testit ja antaa niistä palautteen. Näet palautteen GitHub-repositoriosi actions-välilehdeltä.

Automaattisessa tarkastuksessa käytetään Chrome-selainta ja testit suoritetaan yksi kerrallaan headless-tilassa. Suosittelemme varmistamaan, että testit toimivat paikallisesti seuraavalla komennolla ennen palautusta:

```bash
npx playwright test --reporter="list,html" --project=chromium
```

Palautettuasi tehtävän testisi pisteytetään sen mukaan, kuinka hyvin ne todentavat edellä listattuja vaatimuksia. On siis oleellista, että testeissäsi syötät sekä oikeita että virheellisiä tietoja ja tarkistat, että sivuston tila sekä siinä näkyvät viestit toimivat oikein. Tarvittaessa tutki actions-välilehden raporttia ja testituloksia, jotta voit täydentää testejäsi kattamaan lisää testitapauksia. Voit palauttaa tehtävän uudelleen useita kertoa tehtävän määräaikaan asti.


## Materiaalista

Tämän tehtävän on kehittänyt Teemu Havulinna ja se on lisensoitu [Creative Commons BY-NC-SA -lisenssillä](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Tehtävän luonnissa on luotu hyödyntämällä kielimalleja ja tekoälytyökaluja, kuten GitHub Copilot ja ChatGPT.
