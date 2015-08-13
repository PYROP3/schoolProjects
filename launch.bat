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
echo Opening determinants
ruby determinants.rb
echo 
goto start
:1
echo Opening Electrons
ruby Electrons.rb
echo 
goto start
:2
echo Opening Equationator
ruby Equationator.rb
echo 
goto start
:3
echo Opening matricesmultiplication
ruby matricesmultiplication.rb
echo 
goto start
:4
echo Opening Percentage
ruby Percentage.rb
echo 
goto start
:5
echo Opening PGInfiniteSum
ruby PGInfiniteSum.rb
echo 
goto start
:6
echo Opening PGValueFinder
ruby PGValueFinder.rb
echo 
goto start
:7
echo Opening resistor
ruby resistors.rb
echo 
goto start
:8
echo Opening revResistors2
ruby revResistors2.rb
echo 
goto start
:9
echo Opening Solver
ruby Solver.rb
echo 
goto start
