%{
Michael Gee
ITP 168 Fall 2021
Homework 4
mpgee@usc.edu
%}
clear;clc

% playing the game:
continueGame = 0;
% continueGame is used as the condition for the while loop below.
cash = 100; % cash initialized at 100.
while continueGame == 0
    % the while loops repeats the game until the user decides to stop playing
    % or if the user runs out of money.
    
    % getting input:
    validInput = 0;
    % validInput is used as the condition for the while loop below.
    % the while loops asks for input until a valid number for deckNum is given.
    unshuffledDeck = struct('suit', [], 'value', [], 'score', []);
    % unshuffledDeck is initialized as a structure with empty arrays so it can
    % be accssed outside of the while loop
    shuffledDeck = struct('suit', [], 'value', [], 'score', []);
    % unshuffledDeck is initialized as a structure with empty arrays so it can
    % be accssed outside of the while loop
    while validInput == 0
        deckNum = input("How many decks would you like to play? ");
        if deckNum > 0 && rem(deckNum,1) == 0
            % the if statement error chekcs that deckNum is greater than 0 and an int. 
            unshuffledDeck = initdeck(deckNum);
            % deckNum is passed through initdeck and returns one or more row vectors of
            % cards 
            shuffledDeck = shuffledeck(unshuffledDeck);
            % unshuffledDeck is passed through shuffledeck and returns in a
            % randomized order
            validInput = 1;
            % validInput is set to 1, ending the while loop.
        else
            % the else statement runs if deckNum doesn't satisfy BOTH
            % conditions.
            fprintf("Incorrect input! Enter a positive integer value!\n");
            % the print statement tells the user their input is invalid and the
            % while loop asks for input again.
        end
    end
    
    % taking bets:
    fprintf("You have $" + cash + "\n");
    % the amount of cash the user has is displayed using this print statement.
    validBet = 0; 
    % validBet is the condition used to take input for bets.
    while validBet == 0
        % while loop used to repeat input statement until valid input is given.
        bet = input("Place your bet: $");
        if bet > 0 && bet <= cash && rem(bet,1) == 0
            % if input > 0 AND input <= cash AND  a whole number, then the input is valid.
            % rem(bet,1) is used to check that the remainder of the input
            % divided by 1 is 0, proving that the input is a whole numer.
            cash = cash - bet;
            % the bet money is subtracted from the user's total cash.
            validBet = 1;
            % validBet = 1 ends the while loop.
        else
            fprintf("Invalid bet! Must be positive integer! Cannot exceed current cash!/n");
            % if ONE of the conditions is not met, then the input is invalid
            % and the user is asked to give input again.
        end
    end
    
    % dealing cards to hand:
    hand = struct('suit', [], 'value', [], 'score', []);
    % hand is initialized as a structure with empty arrays.
    for i = 1:5
        % each indice from 1 to 5 of hand is assigned a value from
        % shuffledDeck
        [hand(i), shuffledDeck] = dealcard(shuffledDeck);
        fprintf(i + ": ");
        printcard(hand(i));
        % each card in the hand is displayed using printcard()
    end
    
    % a = topCard, b = restOfDeck
    % [a,b] = dealcard(unshuffledDeck)
    
    % firstRank is the hand ranking before the user is asked if they want
    % to exchange their cards.
    % if statements are used to run the appropriate print statement telling
    % th user how their hand ranks.
    firstRank = calchand(hand);
    if firstRank == 2
        fprintf("You currently have a pair!");
    elseif firstRank == 3
        fprintf("You currently have a three of a kind!");
    elseif firstRank == 4
        fprintf("You currently have a straight!");
    elseif firstRank == 5
        fprintf("You currently have a flush!");
    elseif firstRank == 6
        fprintf("You currently have a full house!");
    elseif firstRank == 7
        fprintf("You currently have a four of a kind!");
    elseif firstRank == 8
        fprintf("You currently have a straight flush!");
    elseif firstRank == 9
        fprintf("You currently have a royal flush!");
    elseif firstRank == 10
        fprintf("You currently have a five of a kind!");
    else
        fprintf("You currently have nothing! Jacks or Higher to win!");
    end
    
    % swapping cards:
    validSwap = 0;
    % validSwap is the condition used to run the while loop below.
    while validSwap == 0
        % the user is asked to input an array of the indices they'd like to
        % swap.
        swapArray = input("\nSwap cards using index values and [], or 0 to keep all your cards: ");
        % swapArray is an array provided by the user telling which card
        % indices they'd like to replace
        if length(swapArray) > 5
            % if an array greater than 5 is inputted, then it is an invalid
            % array because the player cannot hold more than 5 cards.
            fprintf("\nToo many indices inputted! Try again!\n");
            % the user is told their input is invalid and the while loop
            % repeats until a valid input is given
        elseif isvector(swapArray) == 0
            % if the user does not give their input in brackets, then
            % isvector(swapArray) returns false.
            fprintf("\nInvalid input! Try again!\n");
            % the user is told their input is invalid and the while loop
            % repeats until a valid input is given
        elseif swapArray == 0
            % if the user inputs "[0]", then they do not want to swap any
            % cards.
            validSwap = 1;
            % validSwap = 1 ends the while loop.
        elseif unique(swapArray) ~= length(swapArray)
            % unique returns swapArray without duplicate values
            % if they return different lengths, then it means there were
            % duplicate values in swapArray.
            fprintf("\nDuplicates found! Try again!\n");
            % the user is told their input was invalid and the while
            % loop repeats.
%         elseif isempty(find(swapArray, 0)) ~= 0 
%             fprintf("\nInvalid input! 1Try again!\n");
% 
%         elseif isempty(find(swapArray, 6)) ~= 0
%             % if an element in swapArray is less than 1 or greater
%             % than 5, then it is invalid. This is because swapArray
%             % can only hold indices that correspond to hand and hand
%             % has a length of 5.
%             fprintf("\nInvalid input! 2Try again!\n");
%             % the user is told their input was invalid and the while
%             % loop repeats.
        else
            % if the input meets all the criteria, then the input is
            % ordered numerically from least to greatest in case the user
            % did not order their indices from least to greatest.
            swapArray = sort(swapArray);
            % if the input is valid, then the cards are swapped using the for
            % loop below.
            for i = 1:length(swapArray)
                % range is set to the number of elements in swapArray because
                % the inidices start at 1
                a = swapArray(i);
                % each indice is assigned to a
                [hand(a), shuffledDeck] = dealcard(shuffledDeck);
                % hand(a) replaces the card at THAT index with another card from
                % the deck using dealcard()
                validSwap = 1;
                % validSwap = 1 ends the while loop.
            end
        end      
    end
    
    
    % after the user swaps or does not swap cards, their hand is ranked
    % again using calchand() and assigned to secondRank
    secondrank = calchand(hand);
    for i = 1:5
        % the cards are printed like before
        fprintf("\n" + i + ": ");
        printcard(hand(i));
    end
    
    % if and elseif statements are used to print the game's outcome,
    % multiply the user's cash accordinly, and update the user's cash
    % each if and elseif statement depends on the hand's rank.
    if secondrank == 1
        fprintf("You have a pair! You win 1x your bet! ");
    elseif secondrank == 2
        cash = cash + bet*2;
        fprintf("You have two pairs! You win 2x your bet! ");
    elseif secondrank == 3
        cash = cash + bet*3;
        fprintf("You have a three of a kind! You win 3x your bet! ");
    elseif secondrank == 4
        cash = cash + bet*5;
        fprintf("You have a straight! You win 5x your bet!" );
    elseif secondrank == 5
        cash = cash + bet*7;
        fprintf("You have a flush! You win 7x your bet! ");
    elseif secondrank == 6
        cash = cash + bet*8;
        fprintf("You full house! You win 8x your bet! ");
    elseif secondrank == 7
        cash = cash + bet*10;
        fprintf("You have a four of a kind! You win 10x your bet! ");
    elseif secondrank == 8
        cash = cash + bet*15;
        fprintf("You have a straight flush! You win 15x your bet! ");
    elseif secondrank == 9
        cash = cash + bet*20;
        fprintf("You have a royal flush! You win 20x your bet! ");
    elseif secondrank == 10
        cash = cash + bet*35;
        fprintf("You have a five of a kind! You win 35x your bet! ");
    else
        fprintf("You have nothing! You Lose!\n");
    end
    
    % if the user runs out of cash then they cannot play any longer
    if cash == 0
        fprintf("You are out of money!\nThank you for playing! Here is your cash: $" + cash + "\n");
        % the print statement tells the user they are out of money
        continueGame = 1;
        % continueGame = 1 keeps the game from repeating
    else
        validEnding = 0;
        % validEnding used as condition for while loop below.
        while validEnding == 0
            % while loop used to repeat input statement until user gives
            % valid input.
            keepPlaying = input("\nPlay again? (y/n): ", 's');
            fprintf("You have $" + cash +".");
            % the user is asked if they'd like to play again
            keepPlaying = lower(keepPlaying);
            % the user's input is made lowercase in case they inputted an
            % uppercase letter
            if keepPlaying == 'n' 
                % if keepPlaying = 'n', then the game ends
                fprintf("Thank you for playing!\nHere is your cash: $" + cash + "\n");
                % print statement displays final amount of cash.
                validEnding = 1;
                continueGame = 1;
                % continueGame = 1 keeps the game from repeating
            elseif keepPlaying == 'y'
                fprintf("\nStarting next game... \n")
                validEnding = 1;
            else 
                % if the user does not input 'n' or 'y', then their input is
                % invalid
                fprintf("Invalid input. Please type 'y' or 'n'\n")
                % print statement tells the user their input is invalid 
            end
        end
    end
end







