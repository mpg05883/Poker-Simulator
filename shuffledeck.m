%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}

% what to call output variable
function output = shuffledeck(unshuffledDeck)
%{
dealcard: Validates that the input is a card structure array of at least 10
          cards using isfield() and shuffles the elements in the card
          structure array.
input: unshuffledDeck -- The card structure array returned from initdeck
                         where all the cards are ordered by suit.
output: shuffledDeck -- The card structure array where the elements are in 
                        random order.
%}

% checking input: 
% nargin used to check that there is only one input.
if nargin ~= 1
    % the error message only runs if the number of inputs is NOT one.
    error("Incorrect umber of inputs! This funciton only takes one input!");
end
fields = {'suit', 'value', 'score'};
fieldCheck = isfield(unshuffledDeck, fields);
% use isfield() to validate that the field names are correct.
booleanCheck = any(fieldCheck(:) > 0);
% use any() and the colon operator to check that ALL the values in
% fieldCheck are true.
if booleanCheck ~= 1 || length(unshuffledDeck) < 10
    % if the field names are correct and unshuffledDeck has 10 or more
    % cards, the code below will not run.
    error("Invalid input: The input must be a card structure array of at least ten cards with field names 'suit', 'value', and 'score'.");
    % if the field names are not correct, the error message will be displayed.    
end

% use randperm function to generate random order of indices
randomIndices = randperm(length(unshuffledDeck));
% new structure shuffledDeck will be filled using the for loop
shuffledDeck = struct('suit', [], 'value', [], 'score', []);
% use for loop to shuffle each card
% randomIndices generates a random int from 1 to 52*n (where n is the
% number of decks)
% this random int is used to index unshuffled Deck for and assign it to an
% index in shuffledDeck.
% this for loop repeats for 52*n iterations.
for i = 1:length(unshuffledDeck)
    % values in each field of shuffedDeck are reassigned to a random index from
    % unshuffledDeck.
    shuffledDeck(i).suit = unshuffledDeck(randomIndices(i)).suit;
    shuffledDeck(i).value = unshuffledDeck(randomIndices(i)).value;
    shuffledDeck(i).score = unshuffledDeck(randomIndices(i)).score;
end
output = shuffledDeck; 
% set output variable equal to shuffled deck

end

