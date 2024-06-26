if not exist ./obj mkdir obj

@rem debug build: this also enabled the ingame editor
fpc -Mobjfpc -g -gl -S2 -Sg -Sc -Sh -XS -Xt -FU./obj LODE.PAS
@rem fpc -Mobjfpc -g -gl -S2 -Sg -Sc -Sh -XS -Xt -FU./obj -Fu"../SDL2-for-Pascal/units" LODE.PAS

@rem release build
@rem fpc -Mobjfpc -S2 -Sg -Sc -Sh -XS -Xt -FU./obj -Fu"../SDL2-for-Pascal/units" DEFLECTOR.PAS

@if %ERRORLEVEL% GEQ 1 EXIT /B %ERRORLEVEL%

LODE.EXE