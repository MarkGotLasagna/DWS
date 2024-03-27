# TODO.md (ITA)

## Topics to discuss
- Il grande miglioramento di `n_plot_peaks.m` rispetto le altre versioni è la riduzione considerevole del rumore e l'attestazione dei vaori su di una solgia controllata. Il difetto è che i picchi non sono molto evidenti, per la maggioranza dei casi. La riduzione del rumore fa sì che il fitting della curva sui dati del grafico sia ben formata e comunque riduce le interferenze.

## Questions to be answered
- C'è un modo non distruttivo di __eliminare i picchi iniziali e finali__ sui grafici dovuti al calcolo della norma? Questi potrebbero essere falsi positivi verso la scoperta di eventi transienti.
    - [x] `plotPeaks.m`
    - [x] `p200_plotPeaks.m`
    - [ ] `ln_plotPeaks.m` ha il problema che il filtro a prescindere ritocca gli elementi margine dell'immagine. Quello che succede è che sia che all'inizio o alla fine, ci sono valori che spiccano esageratamente con il potenziale di attivare non volutamente eventuali meccanismi di rilevamento automatico di eventi transienti. C'è un modo di ovviare al problema?
- Le __questioni viste fino adesso__ possono essere materia di discussione nella testi? Possono essere materiale di esposizione in laurea? __Sono utili?__

- <s>Quale è l'__asse temporale di una singola `.tif`__? Stampare sulle ascisse il tempo sarebbe più comodo piuttosto che stampare la colonna dove avviene l'evento.</s>

- <s>"Ho anche notato che __alcuni sample consecutivi sono uguali a coppie. E' vero?__"</s>

## TODO

- <s>`line_camera.m` serve a plottare le immagini `.tif` della _line camera_ come una funzione delle righe rispetto il tempo. Quello che non convince è che nonostante venga applicato un attenuamento gaussiano sui dati per ridurrne il rumore, i __picchi non sono così evidenti come ci si aspetterebbe__.
Obbiettivo: limitare il calcolo della norma/media/scarto-quadratico-medio alla sezione d'interesse dove avviene il picco) per studiare quella sezione. NON è garantito che questo metodo porti a risultati significativi.
- `line_camera.m` potrebbe essere interessante stampare su schermo la regione dell'immagine dove avviene il picco (se avviene a riga 2300 c.a., stampare l'immagine 1800-2700).</s>
