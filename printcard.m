%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}

function printcard(card)
%{
printcard: Validates that the input is only ONE card and prints the card
          in the form "VALUE of SUIT" e.g. "2 of Spades".
input: card -- The card structure array where the elements are in 
                       random order.
output: none
%}

% checking input: 
% nargin used to check that there is only one input.
if nargin ~= 1
    % the error message only runs if the number of inputs is NOT one.
    error("Incorrect umber of inputs! This funciton only takes one input!");
end
fields = {'suit', 'value', 'score'};
fieldCheck = isfield(card, fields);
% use isfield() to validate that the field names are correct.
booleanCheck = any(fieldCheck(:) > 0);
% use any() and the colon operator to check that ALL the values in
% fieldCheck are true.
if booleanCheck ~= 1 || length(card) ~= 1
    % if the field names are correct and card's length is EXACTLY 1,
    % the code below will not run.
    error("Invalid input: The input must be a card structure array of at least ten cards with field names 'suit', 'value', and 'score'.");
    % if the field names are not correct, the error message will be displayed.    
end

% each card is printed using the for loop
for i = 1:length(card)
    % the value of each field at a given index is accessed using the dot operator
    % and used in the print statement.
    fprintf(card(i).value + " of " + card(i).suit + "\n")
end
end

