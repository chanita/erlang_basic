-module(tennis).

-export([tennis/1]).

tennis({0,0}) -> "Love All";
tennis({15,0}) -> "Fifteen Love";
tennis({30,0}) -> "Thirty Love";
tennis({40,0}) -> "Forty Love";
tennis({win,0}) -> "Player 1 Win";
