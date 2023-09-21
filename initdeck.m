%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}

function output = initdeck(deckNum) 
%{
initdeck: Checks that the input is a positive, scalar, numberic, int and
          creates multiple empty card structures to make a full deck. 
          Multiple decks may be created if desired.
input: deckNum -- The number of decks to create.
output: varName -- A card structure array containing the desired number of
                   cards.
%}
% nargin used to check that there is only one input.
if nargin ~= 1
    % the error message only runs if the number of inputs is NOT one.
    error("Incorrect umber of inputs! This funciton only takes one input!");
end

% if statement does more error checking to make sure deckNum is valid.
if deckNum < 0 || rem(deckNum,1) ~= 0 || isnumeric(deckNum) ~= 1  
    error("Incorrect input! Enter a positive integer value!\n");
end

% creating the cards - each card is a structure with fields 'suit',
% 'value', and 'score'. all the cards are added to a row array, which is the output.
cardValues = ["2", "3", "4", "5", "6", "7" "8", "9", "10", "Jack", "Queen", "King", "Ace"];
cardSuits = ["Clubs", "Diamonds", "Hearts", "Spades"];
cardScore = linspace(2,14,13);
% the values from each of the following arrays will be assigned to indices
% in singleDeck to create the deck of cards.

singleDeck = struct('suit', [], 'value', [], 'score', []);
% elements will be added to singleDeck using the for loops below.
counter = 0;
% counter intialized at 0
for i = 1:4
    for j = 1:13
        % the inner loop iterates 13 times and the outer loop iterates
        % through the inner loop 4 times, leading to a total of 52 iterations, or
        % 52 cards.
        counter = counter + 1;
        % counter increases by 1 with every iteration.
        % counter is used to index each element of singleDeck
        singleDeck(counter).suit = cardSuits(i);
        singleDeck(counter).value = cardValues(j);
        singleDeck(counter).score = cardScore(j);
        % values for each field are assigned using the dot opeartor
        % and assigned to indices of the arrays outside of the for loop.
    end
end

% use repmat func for multiple decks 
% assign repmat func to output
output = repmat(singleDeck, deckNum);
% passing singleDeck and deckNum as the arguements for repmat yields a 
% an nxm array where n = deckNum and m = 52 
end