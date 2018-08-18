rm -rf working
mkdir working

REM Pack the test data
tapetool2 --microbee binReader --filename:testdata.txt packData setHeader --filename:"TESTD" --loadAddr:0x0123 --startAddr:0x0456 --filetype:0x66 working\testdata.300.blocks.txt 

REM Convert it to audio 
tapetool2 --microbee working\testdata.300.blocks.txt renderAudio working\testdata.300.wav

REM Parse it back again
tapetool2 --microbee working\testdata.300.wav parseAudio working\testdata.300out.blocks.txt

REM Comparse blocks
fc working\testdata.300.blocks.txt working\testdata.300out.blocks.txt
IF ERRORLEVEL 1 GOTO :FAIL


REM Pack the test data
tapetool2 --microbee binReader --filename:testdata.txt packData setHeader --filename:"TESTD" --loadAddr:0x0123 --startAddr:0x0456 --filetype:0x66 --speed:255 working\testdata.1200.blocks.txt 

REM Convert it to audio 
tapetool2 --microbee working\testdata.1200.blocks.txt renderAudio working\testdata.1200.wav

REM Parse it back again
tapetool2 --microbee working\testdata.1200.wav parseAudio working\testdata.1200out.blocks.txt

REM Comparse blocks
fc working\testdata.1200.blocks.txt working\testdata.1200out.blocks.txt
IF ERRORLEVEL 1 GOTO :FAIL



@echo "***** TESTS PASSED *****"
goto :EXIT

:FAIL
@echo "***** TESTS FAILED *****"

:EXIT