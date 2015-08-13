@echo off


cls
echo Targeting files at %cd%
pause
:start
cls

echo 0_determinants
echo 1_Electrons
echo 2_Equationator
echo 3_matricesmultiplication
echo 4_Percentage
echo 5_PGInfiniteSum
echo 6_PGValueFinder
echo 7_resistors
echo 8_revResistors2
echo 9_Solver
echo _________________________

set/p fileaddr= File ID: 

if %fileaddr% == 0 goto 0
if %fileaddr% == 1 goto 1
if %fileaddr% == 2 goto 2
if %fileaddr% == 3 goto 3
if %fileaddr% == 4 goto 4
if %fileaddr% == 5 goto 5
if %fileaddr% == 6 goto 6
if %fileaddr% == 7 goto 7
if %fileaddr% == 8 goto 8
if %fileaddr% == 9 goto 9
echo Address not found...
ping localhost -n 2 >nul
goto start

:0
echo Opening determinants...
ping localhost -n 2 >nul
cls
ruby determinants.rb
goto start

:1
echo Opening Electrons...
ping localhost -n 2 >nul
cls
ruby Electrons.rb
goto start

:2
echo Opening Equationator...
ping localhost -n 2 >nul
cls
ruby Equationator.rb
goto start

:3
echo Opening matricesmultiplication...
ping localhost -n 2 >nul
cls
ruby matricesmultiplication.rb
goto start

:4
echo Opening Percentage...
ping localhost -n 2 >nul
cls
ruby Percentage.rb
goto start

:5
echo Opening PGInfiniteSum...
ping localhost -n 2 >nul
cls
ruby PGInfiniteSum.rb
goto start

:6
echo Opening PGValueFinder...
ping localhost -n 2 >nul
cls
ruby PGValueFinder.rb
goto start

:7
echo Opening resistor...
ping localhost -n 2 >nul
cls
ruby resistors.rb
goto start

:8
echo Opening revResistors2...
ping localhost -n 2 >nul
cls
ruby revResistors2.rb
goto start

:9
echo Opening Solver...
ping localhost -n 2 >nul
cls
ruby Solver.rb
goto start
