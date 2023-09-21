%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}

function [topCard, restOfDeck] = dealcard(shuffledDeck)
%{
dealcard: Same validation as dealcard.m. Returns the first card of the deck
           and the rest of the deck seperately.
input: shuffledDeck -- The card structure array where the elements are in 
                       random order.
outputs: topCard -- The first element of the card structure array.
         restOfDeck -- The card structure array without topCard.
%}

% checking input: 
% nargin used to check that there is only one input.
if nargin ~= 1
    % the error message only runs if the number of inputs is NOT one.
    error("Incorrect umber of inputs! This funciton only takes one input!");
end
fields = {'suit', 'value', 'score'};
fieldCheck = isfield(shuffledDeck, fields);
% use isfield() to validate that the field names are correct.
booleanCheck = any(fieldCheck(:) > 0);
% use any() and the colon operator to check that ALL the values in
% fieldCheck are true.
if booleanCheck ~= 1 || length(shuffledDeck) < 10
    % if the field names are correct and shuffledDeck has 10 or more
    % cards, the code below will not run.
    error("Invalid input: The input must be a card structure array of at least ten cards with field names 'suit', 'value', and 'score'.");
    % if the field names are not correct, the error message will be displayed.    
end

% dealing cards: 
topCard = shuffledDeck(1);
% assign topCard to the first element of shuffledDeck.
restOfDeck = shuffledDeck(2:length(shuffledDeck));
% assign restOfDeck to everything besides the first element of
% shuffledDeck.
end

