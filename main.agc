/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

/*
* 	CREATED BY: DEV MIDUZ
*	https://github.com/DevMiduz/AppGameKit_ExpandingGrid
*	devmiduz@gmail.com
*/

/*

	INCLUDES

*/

#include "includes.agc"


/*

	CONSTANTS

*/

/*

	TYPES
		
*/

type EXG_Tile
	index as integer
	status as integer
endtype

type EXG_Row
	// Easier to re-order rows by setting the index and sorting.
	index as integer
	tiles as EXG_Tile[]
endtype

type EXG_Grid
	tileSize as integer
	rows as EXG_Row[]
endtype

/*
	
	FUNCTIONS
	
*/

function EXG_InitGrid(tileSize as integer, rowCount as integer, colCount as integer)
	grid as EXG_Grid
	EXG_InitGridRef(grid, tileSize, rowCount, colCount)
endfunction grid

function EXG_InitGridRef(grid ref as EXG_Grid, tileSize as integer, rowCount as integer, colCount as integer)
	grid.tileSize = tileSize
	grid.rows.length = rowCount - 1
	
	for i = 0 to grid.rows.length
		grid.rows[i].index = i
		grid.rows[i].tiles.length = colCount - 1
		
		for j = 0 to grid.rows[i].tiles.length
			//need to convert these to minus and positive from 0
			grid.rows[i].tiles[j].index = j - (grid.rows[i].tiles.length / 2)
		next j
	next i
endfunction grid

function EXG_DebugGrid(grid ref as EXG_Grid)
	output as String
	
	for i = 0 to grid.rows.length	
		output = str(grid.rows[i].index) + " => "
			
		for j = 0 to grid.rows[i].tiles.length
			output = output + "| " + str(grid.rows[i].tiles[j].index) + " |"
		next j
		
		Log(output)
	next i
endfunction

function EXG_InsertRow()

endfunction

/*

	MAIN PROGRAM

*/

    grid as EXG_Grid
    grid = EXG_InitGrid(8, 11, 11)
    EXG_DebugGrid(grid)

do
    Print( ScreenFPS() )
    
    Sync()
loop
