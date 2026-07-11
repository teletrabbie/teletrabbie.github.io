const siteSentences = [
  "Geniesse jeden Moment auf und neben dem Feld.",
  "Aktive Körperspannung und Angriffsposition.",
  "Denke und handle wie ein Elite-Spieler.",
  "Ultimate ist und bleibt ein Teamsport.",
  "Mein Handeln oder Unterlassen hat Einfluss auf das Team. Das gilt im positiven und/oder negativen Sinne.",
  "Sei aktiv auf dem Feld, aber nicht unnötig aktivistisch, sonst störst Du die guten Aktionen deiner Mitspieler.",
  "Orientierung auf dem Feld: wo ist Disc? Wo ist Gegenspieler? Was machen Mitspieler?",
  "Ich bin noch nicht an meine Grenzen angekommen. Denke dabei langfristig und riskiere keine Verletzungen.",
  "Sinnvolle, aktive Unterstützung an Sideline.",
  "In D: bleibt hart am Gegner dran. Du musst immer Doppelt so viel arbeiten, wie Angreifer.",
  "In D: ich kann die ersten 2-3 Sekunden etwas poachy stehen (beim Dump), aber danach wieder enger, um einfachen Reset zu verhindern.",
  "In D: dauerhaftes und SEHR aktives Orbitting, um proaktiv den gefährdeten Raum zu schützen.",
  "In D: ich muss immer agieren statt nur reagieren und den Gegner nach und nach nerven/zermürben.",
  "In O: wo werden sich demnächst gute Räume zum angreifen ergeben?",
  "Handling: wo möchte Runner die Scheibe gern hin haben?",
  "Handling: Speedcheck und Fokus auf Runner.",
  "Handling: Fakes und Ausfallschritte sind extrem wichtig.",
  "Handling: schneller Snapp/Release der Disc.",
  "Handling: flexibel bleiben.",
  "Handling: bei BEdarf wegfaken und Dump auslösen.",
  "Handling: verarsche den Mark, denn er sieht den Runner und dessen Laufrichtung nicht.",
  "Nutze die Lefties als Superpower.",
  "Trau dich die Insides auf Bruchseite, denn du kannst das.",
  "Give and go mit gleichgesinnten durchziehen.",
  "Deine Motivation und Spirit ist wichtig fürs ganze Team und kann dies hochziehen."
];

function getRandomSentence() {
  const randomIndex = Math.floor(Math.random() * siteSentences.length);
  return siteSentences[randomIndex];
}

document.addEventListener("DOMContentLoaded", () => {
  const target = document.getElementById("random-sentence");

  if (target) {
    target.textContent = getRandomSentence();
  }
});
