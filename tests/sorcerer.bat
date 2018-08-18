@echo off
rm -rf working
mkdir working

REM Pack the test data
tapetool2 --sorcerer binReader --filename:testdata.txt packData setHeader --filename:"TESTD" --loadAddr:0x0123 --startAddr:0x0456 --fileid:0x55 --filetype:0x66 working\testdata.blocks.txt 

REM Convert it to audio 
tapetool2 --sorcerer working\testdata.blocks.txt renderAudio --profileWave:..\profile.wav --sampleRate:44100 working\testdata.300.wav

REM Parse it back again
tapetool2 --sorcerer working\testdata.300.wav parseAudio working\testdata.300.blocks.txt

REM Comparse blocks
fc working\testdata.blocks.txt working\testdata.300.blocks.txt
IF ERRORLEVEL 1 GOTO :FAIL

REM Convert it to audio 
tapetool2 --sorcerer working\testdata.blocks.txt renderAudio --baud:1200 --profileWave:..\profile.wav --sampleRate:44100 --waveShape:sine working\testdata.1200.wav

REM Parse it back again
tapetool2 --sorcerer working\testdata.1200.wav parseAudio --baud:1200 working\testdata.1200.blocks.txt

REM Comparse blocks
fc working\testdata.blocks.txt working\testdata.1200.blocks.txt
IF ERRORLEVEL 1 GOTO :FAIL

@echo "***** TESTS PASSED *****"
goto :EXIT

:FAIL
@echo "***** TESTS FAILED *****"

:EXIT