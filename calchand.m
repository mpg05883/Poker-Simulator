%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}
function handRank = calchand(hand)
%{
calchand: Validates that the input is a hand structure array with FIVE
          elements and ranks the hand according to poker rules.
input: hand -- a hand structure array of FIVE hands. 
output: handRank -- an int that corresponds to poker rules.
%}

% checking input: 
% nargin used to check that there is only one input.
if nargin ~= 1
    % the error message only runs if the number of inputs is NOT one.
    error("Incorrect umber of inputs! This funciton only takes one input!");
end
fields = {'suit', 'value', 'score'};
fieldCheck = isfield(hand, fields);
% use isfield() to validate that the field names are correct.
booleanCheck = any(fieldCheck(:) > 0);
% use any() and the colon operator to check that ALL the values in
% fieldCheck are true.
if booleanCheck ~= 1 || length(hand) ~= 5
    % if the field names are correct and hand's length is EXACTLY 5,
    % the code below will not run.
    error("Invalid input: The input must be a hand structure array of at least ten hands with field names 'suit', 'value', and 'score'.");
    % if the field names are not correct, the error message will be displayed.    
end

% initialize handRanking as an array and add rankings returned from local
% functions
% return the greatest element
% if none of the hand rankings are found, handRanking = 0
rank = 0;

% checking for one pair:
if ispair(hand) == 1
    rank = 1;
end

% checking for two pairs
if istwopair(hand) == 1
    rank = 2;
end

% checking for three of a kind:
if isthree(hand) == 1
    rank = 3;
end

% checking for straight:
if isstraight(hand) == 1
    rank = 4;
end

% checking for flush
if isflush(hand) == 1
    rank = 5;
end

% checking for full house:
if ispair(hand) == 1 && isthree(hand) == 1 
    rank = 6;
end

% checking for four of a kind:
if isfour(hand) == 1
    rank = 7;
end

% checking for straight flush:
if isstraight(hand) == 1 && isflush(hand) == 1
    rank = 8;
end

% checking for royal flush:

% checking for five of a kind:
% if isfive(hand) == 1
%     rankArray = 9;
%     message = "You have a three of a kind! You win 35x your bet!";
% end

% return highest value
handRank = rank;

% Local Functions:
sortedHand = zeros(1,5); 
% sortedHand is a global variable used by multiple local functions.

function sortedHand = sorthand(hand)
handArray = zeros(1,5);
    % handArray is initialized as a 1x5 array of zeros using zeros().
    for i = 1:5
       % the for loop iterates through each cards's score and adds it to
       % handArray.
       handArray(i) = hand(i).score;
    end
    sortedHand = sort(handArray);
    % handArray is sorted in numerical order from least to greatest using
    % sort().
end

function pairPresent = ispair(hand)
%{
ispair: checks if there is a pair of hands higer than a Jack in the hand.
input: hand - a hand structure array of FIVE hands. 
output: pairPresent - a boolean that returns TRUE is there is a pair and FALSE is there is not a pair
 %}
    sortedHand = sorthand(hand);
    for i = 1:4
        if sortedHand(i) >= 11 && sortedHand(i) == sortedHand(i+1)
            % if the hand's value is 11 or greater, then is is a Jack or
            % higher. this means it is a valid hand for a pair.
            % if index 1's value then they all have the same value and are
            % a pair.
            pairPresent = 1;
            % if these conditions are met, then there is a pair present and
            % isPair returns as true.
        else
            pairPresent = 0;
            % if both conditions cannot be met, then a pair is not present
            % and isPair returns as false.
        end
    end
end
    
function twoPairPresent = istwopair(hand)
%{
ispair: checks if there are two pairs in the hand.
input: hand - a hand structure array of FIVE hands. 
output: pairPresent - a boolean that returns TRUE is there is are two pairs
and FALSE is there are not two pairs.
 %}
    sortedHand = sorthand(hand);
    for i = 1:4
        if sortedHand(i) >= 11 && sortedHand(i) == sortedHand(i+1)
            % if the hand's value is 11 or greater, then is is a Jack or
            % higher. this means it is a valid hand for a pair.
            % if index 1's value then they all have the same value and are
            % a pair.
            twoPairPresent = 1;
            % if these conditions are met, then there is a pair present and
            % isPair returns as true.
        else
            twoPairPresent = 0;
            % if both conditions cannot be met, then a pair is not present
            % and isPair returns as false.
        end
    end
end

function straightPresent = isstraight(hand)
%{
isstraight: checks if there is the hands values are sequential
input: hand - a hand structure array of FIVE hands. 
output: straightPresent - a boolean that returns TRUE is there is a
straight and FALSE is there is not a straight
 %}
    handArray = zeros(1,5);
    % handArray is initialized as a 1x5 array of zeros using zeros().
    for i = 1:5
       % the for loop iterates through each hand's score and adds it to
       % handArray.
       handArray(i) = hand(i).score;
    end
    sortedHand = sort(handArray);
    % handArray is sorted in numerical order from least to greatest using
    % sort().
    for i = 1:4
        if sortedHand(i+1) - sortedHand(i) == 0
            % testing sequences: their hand values when subtracted should be 1
            straightPresent = 1;
            % if these conditions are met, then there is a pair present and
            % isPair returns as true.
        else
            straightPresent = 0;
            % if both conditions cannot be met, then a pair is not present
            % and isPair returns as false.
        end
    end
end    

function flushPresent = isflush(hand)
%{
isflush: checks if all the hands have the same suit
input: hand - a hand structure array of FIVE hands. 
output: flushPresent - a boolean that returns TRUE is there is a sequence and FALSE is there is not a sequence
 %}
    for i = 1:4
        if hand(i).suit == hand(i+1).suit
            % if there's a flush, then each hand's should have the same
            % suit as the hand before it 
            flushPresent = 1;
            % if these conditions are met, then there is a pair flush and
            % isFlush returns as true.
        else
            flushPresent = 0;
            % if both conditions cannot be met, then a flush is not present
            % and isFlush returns as false.
        end
    end
end  

% function fhPresent = isfh(hand)
% %{
% isfh: checks if there is a full house
% input: hand - a hand structure array of FIVE hands. 
% output: fhPresent - a boolean that returns TRUE is there is a full house
% and FALSE is there is not a full house
%  %}
%   handArray = zeros(1,5);
%     % handArray is initialized as a 1x5 array of zeros using zeros().
%     for i = 1:5
%        % the for loop iterates through each hand's score and adds it to
%        % handArray.
%        handArray(i) = hand(i).score;
%     end
%     sortedHand = sort(handArray);
%     % handArray is sorted in numerical order from least to greatest using
%     % sort().
%     pairArray = zeros(1,2);
%     threeArray = zeros(1,3);
%     for i = 1:4
%         if sortedHand(i) == sortedHand(i+1)
%             % if the hand's value is 11 or greater, then is is a Jack or
%             % higher. this means it is a valid hand for a pair.
%             % if index 1's value then they all have the same value and are
%             % a pair.
%             pairPresent = 1;
%             % if these conditions are met, then there is a pair present and
%             % isPair returns as true.
%         else
%             pairPresent = 0;
%             % if both conditions cannot be met, then a pair is not present
%             % and isPair returns as false.
%         end
%     end
% end
        

function threePresent = isthree(hand)
%{
isthree: checks if there is a three of a kind
input: hand - a hand structure array of FIVE hands. 
output: threePresent - a boolean that returns TRUE is there is a three of a kind and FALSE is there is not a three of a kind
 %}
    
    for i = 1:3
        if sortedHand(i) == sortedHand(i+1) && sortedHand(i) == sortedHand(i+2)
            % if index 1's value = index 2's value AND index 2's value =
            % index 3's value, then they all have the same value
            % therefore, all three are the same hand and there is a three
            % of a kind
            threePresent = 1;
            % if these conditions are met, then there is a three of a kind present and
            % threePresent returns as true.
        else
            threePresent = 0;
            % if both conditions cannot be met, then a three of a kind present is not present
            % and threePresent returns as false.
        end
    end
end

function fourPresent = isfour(hand)
%{
isfour: checks if there is a four of a kind
input: hand - a hand structure array of FIVE hands. 
output: fourPresent - a boolean that returns TRUE is there is a four of a kind and FALSE is there is not a four of a kind
 %}
    handArray = zeros(1,5);
    % handArray is initialized as a 1x5 array of zeros using zeros().
    for i = 1:5
       % the for loop iterates through each cards's score and adds it to
       % handArray.
       handArray(i) = hand(i).score;
    end
    sortedHand = sort(handArray);
    % handArray is sorted in numerical order from least to greatest using
    % sort().
    for i = 1:2
        if isthree(sortedHand) == 1 && sortedHand(i+2) == sortedHand(i+3)
            % isthree is called on to check the first three elements.
            % sortedHand(i+2) == sortedHand(i+3) is used to check if the
            % last element of the three of a kind equals the hand value of
            % the next element.
            % if all four hand values are equal, then there is a four of a
            % kind.
            fourPresent = 1;
            % if these conditions are met, then there is a three of a kind present and
            % fourPresent returns as true.
        else
            fourPresent = 0;
            % if both conditions cannot be met, then a four of a kind present is not present
            % and fourPresent returns as false.
        end
    end
end

function fivePresent = isfive(hand)
%{
isfour: checks if there is a give of a kind
input: hand - a hand structure array of FIVE hands. 
output: fourPresent - a boolean that returns TRUE is there is a five of a kind and FALSE is there is not a five of a kind
 %}
    handArray = zeros(1,5);
    handArray = hand;
    % handArray is initialized as a 1x5 array of zeros using zeros().
%     for i = 1:5
%        % the for loop iterates through each cards's score and adds it to
%        % handArray.
%        handArray(i) = hand(i).score;
%     end
    sortedHand = sort(handArray);
    % handArray is sorted in numerical order from least to greatest using
    % sort().
    if isfour(sortedHand) == 1 && sortedHand(4) == sortedHand(5)
        % isfour is called on to check the first four elements.
        % sortedHand(4) == sortedHand(5) is used to check if the
        % last element of the four of a kind equals the hand value of
        % the last hand.
        % if all five hand values are equal, then there is a five of a
        % kind.
        fivePresent = 1;
        % if these conditions are met, then there is a three of a kind present and
        % fivePresent returns as true.
    else
        fivePresent = 0;
        % if both conditions cannot be met, then a five of a kind present is not present
        % and fivePresent returns as false.
    end
end



end

