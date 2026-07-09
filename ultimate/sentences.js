const siteSentences = [
  "Geniesse jeden Moment auf und neben dem Feld.",
  "Aktive Körperspannung und Angriffsposition.",
  "Denke und handle wie ein Elite-Spieler.",
  "Ultimate ist und bleibt ein Teamsport.",
  "Mein Handeln oder Unterlassen hat Einfluss auf das Team. Das gilt im positiven und/oder negativen Sinne.",
  "Sei aktiv auf dem Feld, aber nicht unnötig aktivistisch, sonst störst Du die guten Aktionen deiner Mitspieler"
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
