# mines.rb

## Como jogar
    git clone git@github.com:ottohenrique/mines2.git
    cd mines
    ruby mines.rb

## Comandos

* p (play)

  Abre uma célula nas coordenadas X, Y. Não permite abrir uma célula já aberta ou com flag (`?`).

* f (flag)

  Marca uma célula como dúvidosa nas coordenadas X, Y. Não permite marcar como flag uma célula já aberta.

* s (score)

  Exibe o total de flags colocadas, o total de células abertas e quantas jogadas ainda estão disponíveis.

* q (quit)

  Sai do jogo.
  
* ? (ajuda)

  Exibe um texto com essa explicação dos comandos
  
## Testes

Para executar os testes do código:

    ./run_tests.sh


## Gameplay

[![asciicast](https://asciinema.org/a/136782.png)](https://asciinema.org/a/136782)

[![asciicast](https://asciinema.org/a/136781.png)](https://asciinema.org/a/136781)

## Gameplay (old school)
	$ ruby mines.rb
	    0   1   2   3   4   5   6   7
	0 [ . | . | . | . | . | . | . | . ]
	1 [ . | . | . | . | . | . | . | . ]
	2 [ . | . | . | . | . | . | . | . ]
	3 [ . | . | . | . | . | . | . | . ]
	4 [ . | . | . | . | . | . | . | . ]
	x > 0
	y > 0
	    0   1   2   3   4   5   6   7
	0 [   |   | 1 | . | . | . | . | . ]
	1 [   |   | 2 | . | . | . | . | . ]
	2 [   |   | 3 | . | . | . | . | . ]
	3 [   |   | 2 | . | . | . | . | . ]
	4 [   |   | 1 | . | . | . | . | . ]
	x > 3
	y > 6
	    0   1   2   3   4   5   6   7
	0 [   |   | 1 | . | . | . | 1 |   ]
	1 [   |   | 2 | . | 3 | 1 | 1 |   ]
	2 [   |   | 3 | . | 3 |   |   |   ]
	3 [   |   | 2 | . | 3 | 1 |   |   ]
	4 [   |   | 1 | . | . | 1 |   |   ]
	x > 2
	y > 3
	mines.rb:31:in `play': Booooom! (RuntimeError)
		from mines.rb:101:in `<main>'
