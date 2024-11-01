function generate(initialSyllables, midSyllables, standardSyllables){

    //declare name length min and max
    let min = 1
    let max = 3

    //declare arrays for building names
    let firstName = ""
    let lastName = ""
    let charSpecies = ""
    let occupation = ""
    let planet = ""

    //generate a first and last name lengths for the generator
    firstLength = Math.round(Math.random()*(max - min) + min)
    console.log(firstLength)
    
    lastLength = Math.round(Math.random()*(max - min) + min)
    console.log(lastLength)
    
    for(i = 0; i < firstLength; i++){

        //firstlength already generated. for each iteration, generate an index to choose from the first syll array
        let firstIndex = Math.floor(Math.random()*initialSyllables.length)
        console.log(`generated first syllables index is ${firstIndex}`)
        //if it's the first syllable of a two syll name, allow for x`
        if(i === 0 && firstLength === 2){
            firstName += initialSyllables[firstIndex]
            //otherwise, if it's the middle syllable of a 3-syl name, allow for the -
        } else if(firstLength === 3 && i === 1){
            firstName += midSyllables[firstIndex]
            //in all other cases, use the standard syllables
        } else {
            firstName += standardSyllables[firstIndex]
        }
    
    }
    for(i = 0; i < lastLength; i++){

        //lastlength already generated. for each iteration, generate an index to choose from the last syll array
        let lastIndex = Math.floor(Math.random()*initialSyllables.length)
        console.log(`generated last syllables index is ${lastIndex}`)
        //if it's the last syllable of a two syll name, allow for x`
        if(i === 0 && lastLength === 2){
            lastName += initialSyllables[lastIndex]
            //otherwise, if it's the middle syllable of a 3-syl name, allow for the -
        } else if(lastLength === 3 && i === 1){
            lastName += midSyllables[lastIndex]
            //in all other cases, use the standard syllables
        } else {
            lastName += standardSyllables[lastIndex]
        }
    
    }
    occupation = occupations[Math.floor(Math.random()*occupations.length)]
    console.log(occupation)
   
    charSpecies = species[Math.floor(Math.random()*species.length)]
    console.log(charSpecies)
    
    planet = planets[Math.floor(Math.random()*planets.length)]
    console.log(planet)
       
    result.innerText = `Your character is ${firstName} ${lastName}, a ${charSpecies} ${occupation} ${planet}`
    // console.log(rxName)
}
