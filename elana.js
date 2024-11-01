let greatThings = [
    "She's brave for petting Charlie!", 
    "Her cleavage",
    "Lip synch battles",
    "She loves trying new things",
    "She's the queen.",
    "Her photo bombing ability",
    "She always wants to make others feel special",
    "How she can't let a day go by without dancing",
    "Her incredible high energy",
    "She pushes other people to be their best",
    "She's so easily startled",
    "Her keen sense of style",
    "Her eye for interior design",
    "How Rolo is still her baby, even after Milo and Kaye were born",
    "She always brings back weird gummies from abroad",
    "Her passion for exercising and taking care of herself",
    "Her capacity to love and have compassion",
    "Her ability to make best friends with random people she meets",
    "Her enthusiastic use of digital sign language in photographs",
]

console.log(greatThings.length)

const resultDiv = document.getElementById('result');  // Add this line

function randomThing(arr){
    let thisThingIndex = Math.floor(Math.random()*greatThings.length)
    let thisThing = greatThings[thisThingIndex]
    console.log(thisThing)
    
    resultDiv.innerText = `${thisThing}`  // Changed this line
}

const generateButton = document.getElementById('generateButton');
generateButton.onclick = function() {
    randomThing(greatThings);
};