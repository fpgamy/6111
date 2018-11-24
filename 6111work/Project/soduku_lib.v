//
// DEFINITIONS
//
`define RESET_GRID(GRID, VALUE) \
GRID[0][0] = VALUE;\
GRID[0][1] = VALUE;\
GRID[0][2] = VALUE;\
GRID[0][3] = VALUE;\
GRID[0][4] = VALUE;\
GRID[0][5] = VALUE;\
GRID[0][6] = VALUE;\
GRID[0][7] = VALUE;\
GRID[0][8] = VALUE;\
GRID[1][0] = VALUE;\
GRID[1][1] = VALUE;\
GRID[1][2] = VALUE;\
GRID[1][3] = VALUE;\
GRID[1][4] = VALUE;\
GRID[1][5] = VALUE;\
GRID[1][6] = VALUE;\
GRID[1][7] = VALUE;\
GRID[1][8] = VALUE;\
GRID[2][0] = VALUE;\
GRID[2][1] = VALUE;\
GRID[2][2] = VALUE;\
GRID[2][3] = VALUE;\
GRID[2][4] = VALUE;\
GRID[2][5] = VALUE;\
GRID[2][6] = VALUE;\
GRID[2][7] = VALUE;\
GRID[2][8] = VALUE;\
GRID[3][0] = VALUE;\
GRID[3][1] = VALUE;\
GRID[3][2] = VALUE;\
GRID[3][3] = VALUE;\
GRID[3][4] = VALUE;\
GRID[3][5] = VALUE;\
GRID[3][6] = VALUE;\
GRID[3][7] = VALUE;\
GRID[3][8] = VALUE;\
GRID[4][0] = VALUE;\
GRID[4][1] = VALUE;\
GRID[4][2] = VALUE;\
GRID[4][3] = VALUE;\
GRID[4][4] = VALUE;\
GRID[4][5] = VALUE;\
GRID[4][6] = VALUE;\
GRID[4][7] = VALUE;\
GRID[4][8] = VALUE;\
GRID[5][0] = VALUE;\
GRID[5][1] = VALUE;\
GRID[5][2] = VALUE;\
GRID[5][3] = VALUE;\
GRID[5][4] = VALUE;\
GRID[5][5] = VALUE;\
GRID[5][6] = VALUE;\
GRID[5][7] = VALUE;\
GRID[5][8] = VALUE;\
GRID[6][0] = VALUE;\
GRID[6][1] = VALUE;\
GRID[6][2] = VALUE;\
GRID[6][3] = VALUE;\
GRID[6][4] = VALUE;\
GRID[6][5] = VALUE;\
GRID[6][6] = VALUE;\
GRID[6][7] = VALUE;\
GRID[6][8] = VALUE;\
GRID[7][0] = VALUE;\
GRID[7][1] = VALUE;\
GRID[7][2] = VALUE;\
GRID[7][3] = VALUE;\
GRID[7][4] = VALUE;\
GRID[7][5] = VALUE;\
GRID[7][6] = VALUE;\
GRID[7][7] = VALUE;\
GRID[7][8] = VALUE;\
GRID[8][0] = VALUE;\
GRID[8][1] = VALUE;\
GRID[8][2] = VALUE;\
GRID[8][3] = VALUE;\
GRID[8][4] = VALUE;\
GRID[8][5] = VALUE;\
GRID[8][6] = VALUE;\
GRID[8][7] = VALUE;\
GRID[8][8] = VALUE

`define GEN_GUESS(M)\
-M & M

`define OR_GRID(GRID) \
GRID[0][0] |\
GRID[0][1] |\
GRID[0][2] |\
GRID[0][3] |\
GRID[0][4] |\
GRID[0][5] |\
GRID[0][6] |\
GRID[0][7] |\
GRID[0][8] |\
GRID[1][0] |\
GRID[1][1] |\
GRID[1][2] |\
GRID[1][3] |\
GRID[1][4] |\
GRID[1][5] |\
GRID[1][6] |\
GRID[1][7] |\
GRID[1][8] |\
GRID[2][0] |\
GRID[2][1] |\
GRID[2][2] |\
GRID[2][3] |\
GRID[2][4] |\
GRID[2][5] |\
GRID[2][6] |\
GRID[2][7] |\
GRID[2][8] |\
GRID[3][0] |\
GRID[3][1] |\
GRID[3][2] |\
GRID[3][3] |\
GRID[3][4] |\
GRID[3][5] |\
GRID[3][6] |\
GRID[3][7] |\
GRID[3][8] |\
GRID[4][0] |\
GRID[4][1] |\
GRID[4][2] |\
GRID[4][3] |\
GRID[4][4] |\
GRID[4][5] |\
GRID[4][6] |\
GRID[4][7] |\
GRID[4][8] |\
GRID[5][0] |\
GRID[5][1] |\
GRID[5][2] |\
GRID[5][3] |\
GRID[5][4] |\
GRID[5][5] |\
GRID[5][6] |\
GRID[5][7] |\
GRID[5][8] |\
GRID[6][0] |\
GRID[6][1] |\
GRID[6][2] |\
GRID[6][3] |\
GRID[6][4] |\
GRID[6][5] |\
GRID[6][6] |\
GRID[6][7] |\
GRID[6][8] |\
GRID[7][0] |\
GRID[7][1] |\
GRID[7][2] |\
GRID[7][3] |\
GRID[7][4] |\
GRID[7][5] |\
GRID[7][6] |\
GRID[7][7] |\
GRID[7][8] |\
GRID[8][0] |\
GRID[8][1] |\
GRID[8][2] |\
GRID[8][3] |\
GRID[8][4] |\
GRID[8][5] |\
GRID[8][6] |\
GRID[8][7] |\
GRID[8][8]

`define RESET_PREVS(ARR, VAL) \
ARR[1] <= VAL;\
ARR[2] <= VAL;\
ARR[3] <= VAL;\
ARR[4] <= VAL;\
ARR[5] <= VAL;\
ARR[6] <= VAL;\
ARR[7] <= VAL;\
ARR[8] <= VAL;\
ARR[9] <= VAL;\
ARR[10] <= VAL;\
ARR[11] <= VAL;\
ARR[12] <= VAL;\
ARR[13] <= VAL;\
ARR[14] <= VAL;\
ARR[15] <= VAL;\
ARR[16] <= VAL;\
ARR[17] <= VAL;\
ARR[18] <= VAL;\
ARR[19] <= VAL;\
ARR[20] <= VAL;\
ARR[21] <= VAL;\
ARR[22] <= VAL;\
ARR[23] <= VAL;\
ARR[24] <= VAL;\
ARR[25] <= VAL;\
ARR[26] <= VAL;\
ARR[27] <= VAL;\
ARR[28] <= VAL;\
ARR[29] <= VAL;\
ARR[30] <= VAL;\
ARR[31] <= VAL;\
ARR[32] <= VAL;\
ARR[33] <= VAL;\
ARR[34] <= VAL;\
ARR[35] <= VAL;\
ARR[36] <= VAL;\
ARR[37] <= VAL;\
ARR[38] <= VAL;\
ARR[39] <= VAL;\
ARR[40] <= VAL;\
ARR[41] <= VAL;\
ARR[42] <= VAL;\
ARR[43] <= VAL;\
ARR[44] <= VAL;\
ARR[45] <= VAL;\
ARR[46] <= VAL;\
ARR[47] <= VAL;\
ARR[48] <= VAL;\
ARR[49] <= VAL;\
ARR[50] <= VAL;\
ARR[51] <= VAL;\
ARR[52] <= VAL;\
ARR[53] <= VAL;\
ARR[54] <= VAL;\
ARR[55] <= VAL;\
ARR[56] <= VAL;\
ARR[57] <= VAL;\
ARR[58] <= VAL;\
ARR[59] <= VAL;\
ARR[60] <= VAL;\
ARR[61] <= VAL;\
ARR[62] <= VAL;\
ARR[63] <= VAL;\
ARR[64] <= VAL;\
ARR[65] <= VAL;\
ARR[66] <= VAL;\
ARR[67] <= VAL;\
ARR[68] <= VAL;\
ARR[69] <= VAL;\
ARR[70] <= VAL;\
ARR[71] <= VAL;\
ARR[72] <= VAL;\
ARR[73] <= VAL;\
ARR[74] <= VAL;\
ARR[75] <= VAL;\
ARR[76] <= VAL;\
ARR[77] <= VAL;\
ARR[78] <= VAL;\
ARR[79] <= VAL;\
ARR[80] <= VAL;\
ARR[81] <= VAL;\
ARR[82] <= VAL;\
ARR[83] <= VAL;\
ARR[84] <= VAL;\
ARR[85] <= VAL;\
ARR[86] <= VAL;\
ARR[87] <= VAL;\
ARR[88] <= VAL;\
ARR[89] <= VAL;\
ARR[90] <= VAL;\
ARR[91] <= VAL;\
ARR[92] <= VAL;\
ARR[93] <= VAL;\
ARR[94] <= VAL;\
ARR[95] <= VAL;\
ARR[96] <= VAL;\
ARR[97] <= VAL;\
ARR[98] <= VAL;\
ARR[99] <= VAL;\
ARR[100] <= VAL;\
ARR[101] <= VAL;\
ARR[102] <= VAL;\
ARR[103] <= VAL;\
ARR[104] <= VAL;\
ARR[105] <= VAL;\
ARR[106] <= VAL;\
ARR[107] <= VAL;\
ARR[108] <= VAL;\
ARR[109] <= VAL;\
ARR[110] <= VAL;\
ARR[111] <= VAL;\
ARR[112] <= VAL;\
ARR[113] <= VAL;\
ARR[114] <= VAL;\
ARR[115] <= VAL;\
ARR[116] <= VAL;\
ARR[117] <= VAL;\
ARR[118] <= VAL;\
ARR[119] <= VAL;\
ARR[120] <= VAL;\
ARR[121] <= VAL;\
ARR[122] <= VAL;\
ARR[123] <= VAL;\
ARR[124] <= VAL;\
ARR[125] <= VAL;\
ARR[126] <= VAL;\
ARR[127] <= VAL;\
ARR[128] <= VAL;\
ARR[129] <= VAL;\
ARR[130] <= VAL;\
ARR[131] <= VAL;\
ARR[132] <= VAL;\
ARR[133] <= VAL;\
ARR[134] <= VAL;\
ARR[135] <= VAL;\
ARR[136] <= VAL;\
ARR[137] <= VAL;\
ARR[138] <= VAL;\
ARR[139] <= VAL;\
ARR[140] <= VAL;\
ARR[141] <= VAL;\
ARR[142] <= VAL;\
ARR[143] <= VAL;\
ARR[144] <= VAL;\
ARR[145] <= VAL;\
ARR[146] <= VAL;\
ARR[147] <= VAL;\
ARR[148] <= VAL;\
ARR[149] <= VAL;\
ARR[150] <= VAL;\
ARR[151] <= VAL;\
ARR[152] <= VAL;\
ARR[153] <= VAL;\
ARR[154] <= VAL;\
ARR[155] <= VAL;\
ARR[156] <= VAL;\
ARR[157] <= VAL;\
ARR[158] <= VAL;\
ARR[159] <= VAL;\
ARR[160] <= VAL;\
ARR[161] <= VAL;\
ARR[162] <= VAL;\
ARR[163] <= VAL;\
ARR[164] <= VAL;\
ARR[165] <= VAL;\
ARR[166] <= VAL;\
ARR[167] <= VAL;\
ARR[168] <= VAL;\
ARR[169] <= VAL;\
ARR[170] <= VAL;\
ARR[171] <= VAL;\
ARR[172] <= VAL;\
ARR[173] <= VAL;\
ARR[174] <= VAL;\
ARR[175] <= VAL;\
ARR[176] <= VAL;\
ARR[177] <= VAL;\
ARR[178] <= VAL;\
ARR[179] <= VAL;\
ARR[180] <= VAL;\
ARR[181] <= VAL;\
ARR[182] <= VAL;\
ARR[183] <= VAL;\
ARR[184] <= VAL;\
ARR[185] <= VAL;\
ARR[186] <= VAL;\
ARR[187] <= VAL;\
ARR[188] <= VAL;\
ARR[189] <= VAL;\
ARR[190] <= VAL;\
ARR[191] <= VAL;\
ARR[192] <= VAL;\
ARR[193] <= VAL;\
ARR[194] <= VAL;\
ARR[195] <= VAL;\
ARR[196] <= VAL;\
ARR[197] <= VAL;\
ARR[198] <= VAL;\
ARR[199] <= VAL;\
ARR[200] <= VAL;\
ARR[201] <= VAL;\
ARR[202] <= VAL;\
ARR[203] <= VAL;\
ARR[204] <= VAL;\
ARR[205] <= VAL;\
ARR[206] <= VAL;\
ARR[207] <= VAL;\
ARR[208] <= VAL;\
ARR[209] <= VAL;\
ARR[210] <= VAL;\
ARR[211] <= VAL;\
ARR[212] <= VAL;\
ARR[213] <= VAL;\
ARR[214] <= VAL;\
ARR[215] <= VAL;\
ARR[216] <= VAL;\
ARR[217] <= VAL;\
ARR[218] <= VAL;\
ARR[219] <= VAL;\
ARR[220] <= VAL;\
ARR[221] <= VAL;\
ARR[222] <= VAL;\
ARR[223] <= VAL;\
ARR[224] <= VAL;\
ARR[225] <= VAL;\
ARR[226] <= VAL;\
ARR[227] <= VAL;\
ARR[228] <= VAL;\
ARR[229] <= VAL;\
ARR[230] <= VAL;\
ARR[231] <= VAL;\
ARR[232] <= VAL;\
ARR[233] <= VAL;\
ARR[234] <= VAL;\
ARR[235] <= VAL;\
ARR[236] <= VAL;\
ARR[237] <= VAL;\
ARR[238] <= VAL;\
ARR[239] <= VAL;\
ARR[240] <= VAL;\
ARR[241] <= VAL;\
ARR[242] <= VAL;\
ARR[243] <= VAL;\
ARR[244] <= VAL;\
ARR[245] <= VAL;\
ARR[246] <= VAL;\
ARR[247] <= VAL;\
ARR[248] <= VAL;\
ARR[249] <= VAL;\
ARR[250] <= VAL;\
ARR[251] <= VAL;\
ARR[252] <= VAL;\
ARR[253] <= VAL;\
ARR[254] <= VAL;\
ARR[255] <= VAL;\
ARR[256] <= VAL;\
ARR[257] <= VAL;\
ARR[258] <= VAL;\
ARR[259] <= VAL;\
ARR[260] <= VAL;\
ARR[261] <= VAL;\
ARR[262] <= VAL;\
ARR[263] <= VAL;\
ARR[264] <= VAL;\
ARR[265] <= VAL;\
ARR[266] <= VAL;\
ARR[267] <= VAL;\
ARR[268] <= VAL;\
ARR[269] <= VAL;\
ARR[270] <= VAL;\
ARR[271] <= VAL;\
ARR[272] <= VAL;\
ARR[273] <= VAL;\
ARR[274] <= VAL;\
ARR[275] <= VAL;\
ARR[276] <= VAL;\
ARR[277] <= VAL;\
ARR[278] <= VAL;\
ARR[279] <= VAL;\
ARR[280] <= VAL;\
ARR[281] <= VAL;\
ARR[282] <= VAL;\
ARR[283] <= VAL;\
ARR[284] <= VAL;\
ARR[285] <= VAL;\
ARR[286] <= VAL;\
ARR[287] <= VAL;\
ARR[288] <= VAL;\
ARR[289] <= VAL;\
ARR[290] <= VAL;\
ARR[291] <= VAL;\
ARR[292] <= VAL;\
ARR[293] <= VAL;\
ARR[294] <= VAL;\
ARR[295] <= VAL;\
ARR[296] <= VAL;\
ARR[297] <= VAL;\
ARR[298] <= VAL;\
ARR[299] <= VAL;\
ARR[300] <= VAL;\
ARR[301] <= VAL;\
ARR[302] <= VAL;\
ARR[303] <= VAL;\
ARR[304] <= VAL;\
ARR[305] <= VAL;\
ARR[306] <= VAL;\
ARR[307] <= VAL;\
ARR[308] <= VAL;\
ARR[309] <= VAL;\
ARR[310] <= VAL;\
ARR[311] <= VAL;\
ARR[312] <= VAL;\
ARR[313] <= VAL;\
ARR[314] <= VAL;\
ARR[315] <= VAL;\
ARR[316] <= VAL;\
ARR[317] <= VAL;\
ARR[318] <= VAL;\
ARR[319] <= VAL;\
ARR[320] <= VAL;\
ARR[321] <= VAL;\
ARR[322] <= VAL;\
ARR[323] <= VAL;\
ARR[324] <= VAL;\
ARR[325] <= VAL;\
ARR[326] <= VAL;\
ARR[327] <= VAL;\
ARR[328] <= VAL;\
ARR[329] <= VAL;\
ARR[330] <= VAL;\
ARR[331] <= VAL;\
ARR[332] <= VAL;\
ARR[333] <= VAL;\
ARR[334] <= VAL;\
ARR[335] <= VAL;\
ARR[336] <= VAL;\
ARR[337] <= VAL;\
ARR[338] <= VAL;\
ARR[339] <= VAL;\
ARR[340] <= VAL;\
ARR[341] <= VAL;\
ARR[342] <= VAL;\
ARR[343] <= VAL;\
ARR[344] <= VAL;\
ARR[345] <= VAL;\
ARR[346] <= VAL;\
ARR[347] <= VAL;\
ARR[348] <= VAL;\
ARR[349] <= VAL;\
ARR[350] <= VAL;\
ARR[351] <= VAL;\
ARR[352] <= VAL;\
ARR[353] <= VAL;\
ARR[354] <= VAL;\
ARR[355] <= VAL;\
ARR[356] <= VAL;\
ARR[357] <= VAL;\
ARR[358] <= VAL;\
ARR[359] <= VAL;\
ARR[360] <= VAL;\
ARR[361] <= VAL;\
ARR[362] <= VAL;\
ARR[363] <= VAL;\
ARR[364] <= VAL;\
ARR[365] <= VAL;\
ARR[366] <= VAL;\
ARR[367] <= VAL;\
ARR[368] <= VAL;\
ARR[369] <= VAL;\
ARR[370] <= VAL;\
ARR[371] <= VAL;\
ARR[372] <= VAL;\
ARR[373] <= VAL;\
ARR[374] <= VAL;\
ARR[375] <= VAL;\
ARR[376] <= VAL;\
ARR[377] <= VAL;\
ARR[378] <= VAL;\
ARR[379] <= VAL;\
ARR[380] <= VAL;\
ARR[381] <= VAL;\
ARR[382] <= VAL;\
ARR[383] <= VAL;\
ARR[384] <= VAL;\
ARR[385] <= VAL;\
ARR[386] <= VAL;\
ARR[387] <= VAL;\
ARR[388] <= VAL;\
ARR[389] <= VAL;\
ARR[390] <= VAL;\
ARR[391] <= VAL;\
ARR[392] <= VAL;\
ARR[393] <= VAL;\
ARR[394] <= VAL;\
ARR[395] <= VAL;\
ARR[396] <= VAL;\
ARR[397] <= VAL;\
ARR[398] <= VAL;\
ARR[399] <= VAL;\
ARR[400] <= VAL;\
ARR[401] <= VAL;\
ARR[402] <= VAL;\
ARR[403] <= VAL;\
ARR[404] <= VAL;\
ARR[405] <= VAL;\
ARR[406] <= VAL;\
ARR[407] <= VAL;\
ARR[408] <= VAL;\
ARR[409] <= VAL;\
ARR[410] <= VAL;\
ARR[411] <= VAL;\
ARR[412] <= VAL;\
ARR[413] <= VAL;\
ARR[414] <= VAL;\
ARR[415] <= VAL;\
ARR[416] <= VAL;\
ARR[417] <= VAL;\
ARR[418] <= VAL;\
ARR[419] <= VAL;\
ARR[420] <= VAL;\
ARR[421] <= VAL;\
ARR[422] <= VAL;\
ARR[423] <= VAL;\
ARR[424] <= VAL;\
ARR[425] <= VAL;\
ARR[426] <= VAL;\
ARR[427] <= VAL;\
ARR[428] <= VAL;\
ARR[429] <= VAL;\
ARR[430] <= VAL;\
ARR[431] <= VAL;\
ARR[432] <= VAL;\
ARR[433] <= VAL;\
ARR[434] <= VAL;\
ARR[435] <= VAL;\
ARR[436] <= VAL;\
ARR[437] <= VAL;\
ARR[438] <= VAL;\
ARR[439] <= VAL;\
ARR[440] <= VAL;\
ARR[441] <= VAL;\
ARR[442] <= VAL;\
ARR[443] <= VAL;\
ARR[444] <= VAL;\
ARR[445] <= VAL;\
ARR[446] <= VAL;\
ARR[447] <= VAL;\
ARR[448] <= VAL;\
ARR[449] <= VAL;\
ARR[450] <= VAL;\
ARR[451] <= VAL;\
ARR[452] <= VAL;\
ARR[453] <= VAL;\
ARR[454] <= VAL;\
ARR[455] <= VAL;\
ARR[456] <= VAL;\
ARR[457] <= VAL;\
ARR[458] <= VAL;\
ARR[459] <= VAL;\
ARR[460] <= VAL;\
ARR[461] <= VAL;\
ARR[462] <= VAL;\
ARR[463] <= VAL;\
ARR[464] <= VAL;\
ARR[465] <= VAL;\
ARR[466] <= VAL;\
ARR[467] <= VAL;\
ARR[468] <= VAL;\
ARR[469] <= VAL;\
ARR[470] <= VAL;\
ARR[471] <= VAL;\
ARR[472] <= VAL;\
ARR[473] <= VAL;\
ARR[474] <= VAL;\
ARR[475] <= VAL;\
ARR[476] <= VAL;\
ARR[477] <= VAL;\
ARR[478] <= VAL;\
ARR[479] <= VAL;\
ARR[480] <= VAL;\
ARR[481] <= VAL;\
ARR[482] <= VAL;\
ARR[483] <= VAL;\
ARR[484] <= VAL;\
ARR[485] <= VAL;\
ARR[486] <= VAL;\
ARR[487] <= VAL;\
ARR[488] <= VAL;\
ARR[489] <= VAL;\
ARR[490] <= VAL;\
ARR[491] <= VAL;\
ARR[492] <= VAL;\
ARR[493] <= VAL;\
ARR[494] <= VAL;\
ARR[495] <= VAL;\
ARR[496] <= VAL;\
ARR[497] <= VAL;\
ARR[498] <= VAL;\
ARR[499] <= VAL;\
ARR[500] <= VAL;\
ARR[501] <= VAL;\
ARR[502] <= VAL;\
ARR[503] <= VAL;\
ARR[504] <= VAL;\
ARR[505] <= VAL;\
ARR[506] <= VAL;\
ARR[507] <= VAL;\
ARR[508] <= VAL;\
ARR[509] <= VAL;\
ARR[510] <= VAL;\
ARR[511] <= VAL;\
ARR[512] <= VAL;\
ARR[513] <= VAL;\
ARR[514] <= VAL;\
ARR[515] <= VAL;\
ARR[516] <= VAL;\
ARR[517] <= VAL;\
ARR[518] <= VAL;\
ARR[519] <= VAL;\
ARR[520] <= VAL;\
ARR[521] <= VAL;\
ARR[522] <= VAL;\
ARR[523] <= VAL;\
ARR[524] <= VAL;\
ARR[525] <= VAL;\
ARR[526] <= VAL;\
ARR[527] <= VAL;\
ARR[528] <= VAL;\
ARR[529] <= VAL;\
ARR[530] <= VAL;\
ARR[531] <= VAL;\
ARR[532] <= VAL;\
ARR[533] <= VAL;\
ARR[534] <= VAL;\
ARR[535] <= VAL;\
ARR[536] <= VAL;\
ARR[537] <= VAL;\
ARR[538] <= VAL;\
ARR[539] <= VAL;\
ARR[540] <= VAL;\
ARR[541] <= VAL;\
ARR[542] <= VAL;\
ARR[543] <= VAL;\
ARR[544] <= VAL;\
ARR[545] <= VAL;\
ARR[546] <= VAL;\
ARR[547] <= VAL;\
ARR[548] <= VAL;\
ARR[549] <= VAL;\
ARR[550] <= VAL;\
ARR[551] <= VAL;\
ARR[552] <= VAL;\
ARR[553] <= VAL;\
ARR[554] <= VAL;\
ARR[555] <= VAL;\
ARR[556] <= VAL;\
ARR[557] <= VAL;\
ARR[558] <= VAL;\
ARR[559] <= VAL;\
ARR[560] <= VAL;\
ARR[561] <= VAL;\
ARR[562] <= VAL;\
ARR[563] <= VAL;\
ARR[564] <= VAL;\
ARR[565] <= VAL;\
ARR[566] <= VAL;\
ARR[567] <= VAL;\
ARR[568] <= VAL;\
ARR[569] <= VAL;\
ARR[570] <= VAL;\
ARR[571] <= VAL;\
ARR[572] <= VAL;\
ARR[573] <= VAL;\
ARR[574] <= VAL;\
ARR[575] <= VAL;\
ARR[576] <= VAL;\
ARR[577] <= VAL;\
ARR[578] <= VAL;\
ARR[579] <= VAL;\
ARR[580] <= VAL;\
ARR[581] <= VAL;\
ARR[582] <= VAL;\
ARR[583] <= VAL;\
ARR[584] <= VAL;\
ARR[585] <= VAL;\
ARR[586] <= VAL;\
ARR[587] <= VAL;\
ARR[588] <= VAL;\
ARR[589] <= VAL;\
ARR[590] <= VAL;\
ARR[591] <= VAL;\
ARR[592] <= VAL;\
ARR[593] <= VAL;\
ARR[594] <= VAL;\
ARR[595] <= VAL;\
ARR[596] <= VAL;\
ARR[597] <= VAL;\
ARR[598] <= VAL;\
ARR[599] <= VAL;\
ARR[600] <= VAL;\
ARR[601] <= VAL;\
ARR[602] <= VAL;\
ARR[603] <= VAL;\
ARR[604] <= VAL;\
ARR[605] <= VAL;\
ARR[606] <= VAL;\
ARR[607] <= VAL;\
ARR[608] <= VAL;\
ARR[609] <= VAL;\
ARR[610] <= VAL;\
ARR[611] <= VAL;\
ARR[612] <= VAL;\
ARR[613] <= VAL;\
ARR[614] <= VAL;\
ARR[615] <= VAL;\
ARR[616] <= VAL;\
ARR[617] <= VAL;\
ARR[618] <= VAL;\
ARR[619] <= VAL;\
ARR[620] <= VAL;\
ARR[621] <= VAL;\
ARR[622] <= VAL;\
ARR[623] <= VAL;\
ARR[624] <= VAL;\
ARR[625] <= VAL;\
ARR[626] <= VAL;\
ARR[627] <= VAL;\
ARR[628] <= VAL;\
ARR[629] <= VAL;\
ARR[630] <= VAL;\
ARR[631] <= VAL;\
ARR[632] <= VAL;\
ARR[633] <= VAL;\
ARR[634] <= VAL;\
ARR[635] <= VAL;\
ARR[636] <= VAL;\
ARR[637] <= VAL;\
ARR[638] <= VAL;\
ARR[639] <= VAL;\
ARR[640] <= VAL;\
ARR[641] <= VAL;\
ARR[642] <= VAL;\
ARR[643] <= VAL;\
ARR[644] <= VAL;\
ARR[645] <= VAL;\
ARR[646] <= VAL;\
ARR[647] <= VAL;\
ARR[648] <= VAL;\
ARR[649] <= VAL;\
ARR[650] <= VAL;\
ARR[651] <= VAL;\
ARR[652] <= VAL;\
ARR[653] <= VAL;\
ARR[654] <= VAL;\
ARR[655] <= VAL;\
ARR[656] <= VAL;\
ARR[657] <= VAL;\
ARR[658] <= VAL;\
ARR[659] <= VAL;\
ARR[660] <= VAL;\
ARR[661] <= VAL;\
ARR[662] <= VAL;\
ARR[663] <= VAL;\
ARR[664] <= VAL;\
ARR[665] <= VAL;\
ARR[666] <= VAL;\
ARR[667] <= VAL;\
ARR[668] <= VAL;\
ARR[669] <= VAL;\
ARR[670] <= VAL;\
ARR[671] <= VAL;\
ARR[672] <= VAL;\
ARR[673] <= VAL;\
ARR[674] <= VAL;\
ARR[675] <= VAL;\
ARR[676] <= VAL;\
ARR[677] <= VAL;\
ARR[678] <= VAL;\
ARR[679] <= VAL;\
ARR[680] <= VAL;\
ARR[681] <= VAL;\
ARR[682] <= VAL;\
ARR[683] <= VAL;\
ARR[684] <= VAL;\
ARR[685] <= VAL;\
ARR[686] <= VAL;\
ARR[687] <= VAL;\
ARR[688] <= VAL;\
ARR[689] <= VAL;\
ARR[690] <= VAL;\
ARR[691] <= VAL;\
ARR[692] <= VAL;\
ARR[693] <= VAL;\
ARR[694] <= VAL;\
ARR[695] <= VAL;\
ARR[696] <= VAL;\
ARR[697] <= VAL;\
ARR[698] <= VAL;\
ARR[699] <= VAL;\
ARR[700] <= VAL;\
ARR[701] <= VAL;\
ARR[702] <= VAL;\
ARR[703] <= VAL;\
ARR[704] <= VAL;\
ARR[705] <= VAL;\
ARR[706] <= VAL;\
ARR[707] <= VAL;\
ARR[708] <= VAL;\
ARR[709] <= VAL;\
ARR[710] <= VAL;\
ARR[711] <= VAL;\
ARR[712] <= VAL;\
ARR[713] <= VAL;\
ARR[714] <= VAL;\
ARR[715] <= VAL;\
ARR[716] <= VAL;\
ARR[717] <= VAL;\
ARR[718] <= VAL;\
ARR[719] <= VAL;\
ARR[720] <= VAL;\
ARR[721] <= VAL;\
ARR[722] <= VAL;\
ARR[723] <= VAL;\
ARR[724] <= VAL;\
ARR[725] <= VAL;\
ARR[726] <= VAL;\
ARR[727] <= VAL;\
ARR[728] <= VAL;\
ARR[729] <= VAL;\
ARR[730] <= VAL;\
ARR[731] <= VAL;\
ARR[732] <= VAL;\
ARR[733] <= VAL;\
ARR[734] <= VAL;\
ARR[735] <= VAL;\
ARR[736] <= VAL;\
ARR[737] <= VAL;\
ARR[738] <= VAL;\
ARR[739] <= VAL;\
ARR[740] <= VAL;\
ARR[741] <= VAL;\
ARR[742] <= VAL;\
ARR[743] <= VAL;\
ARR[744] <= VAL;\
ARR[745] <= VAL;\
ARR[746] <= VAL;\
ARR[747] <= VAL;\
ARR[748] <= VAL;\
ARR[749] <= VAL;\
ARR[750] <= VAL;\
ARR[751] <= VAL;\
ARR[752] <= VAL;\
ARR[753] <= VAL;\
ARR[754] <= VAL;\
ARR[755] <= VAL;\
ARR[756] <= VAL;\
ARR[757] <= VAL;\
ARR[758] <= VAL;\
ARR[759] <= VAL;\
ARR[760] <= VAL;\
ARR[761] <= VAL;\
ARR[762] <= VAL;\
ARR[763] <= VAL;\
ARR[764] <= VAL;\
ARR[765] <= VAL;\
ARR[766] <= VAL;\
ARR[767] <= VAL;\
ARR[768] <= VAL;\
ARR[769] <= VAL;\
ARR[770] <= VAL;\
ARR[771] <= VAL;\
ARR[772] <= VAL;\
ARR[773] <= VAL;\
ARR[774] <= VAL;\
ARR[775] <= VAL;\
ARR[776] <= VAL;\
ARR[777] <= VAL;\
ARR[778] <= VAL;\
ARR[779] <= VAL;\
ARR[780] <= VAL;\
ARR[781] <= VAL;\
ARR[782] <= VAL;\
ARR[783] <= VAL;\
ARR[784] <= VAL;\
ARR[785] <= VAL;\
ARR[786] <= VAL;\
ARR[787] <= VAL;\
ARR[788] <= VAL;\
ARR[789] <= VAL;\
ARR[790] <= VAL;\
ARR[791] <= VAL;\
ARR[792] <= VAL;\
ARR[793] <= VAL;\
ARR[794] <= VAL;\
ARR[795] <= VAL;\
ARR[796] <= VAL;\
ARR[797] <= VAL;\
ARR[798] <= VAL;\
ARR[799] <= VAL;\
ARR[800] <= VAL;\
ARR[801] <= VAL;\
ARR[802] <= VAL;\
ARR[803] <= VAL;\
ARR[804] <= VAL;\
ARR[805] <= VAL;\
ARR[806] <= VAL;\
ARR[807] <= VAL;\
ARR[808] <= VAL;\
ARR[809] <= VAL;\
ARR[810] <= VAL;\
ARR[811] <= VAL;\
ARR[812] <= VAL;\
ARR[813] <= VAL;\
ARR[814] <= VAL;\
ARR[815] <= VAL;\
ARR[816] <= VAL;\
ARR[817] <= VAL;\
ARR[818] <= VAL;\
ARR[819] <= VAL;\
ARR[820] <= VAL;\
ARR[821] <= VAL;\
ARR[822] <= VAL;\
ARR[823] <= VAL;\
ARR[824] <= VAL;\
ARR[825] <= VAL;\
ARR[826] <= VAL;\
ARR[827] <= VAL;\
ARR[828] <= VAL;\
ARR[829] <= VAL;\
ARR[830] <= VAL;\
ARR[831] <= VAL;\
ARR[832] <= VAL;\
ARR[833] <= VAL;\
ARR[834] <= VAL;\
ARR[835] <= VAL;\
ARR[836] <= VAL;\
ARR[837] <= VAL;\
ARR[838] <= VAL;\
ARR[839] <= VAL;\
ARR[840] <= VAL;\
ARR[841] <= VAL;\
ARR[842] <= VAL;\
ARR[843] <= VAL;\
ARR[844] <= VAL;\
ARR[845] <= VAL;\
ARR[846] <= VAL;\
ARR[847] <= VAL;\
ARR[848] <= VAL;\
ARR[849] <= VAL;\
ARR[850] <= VAL;\
ARR[851] <= VAL;\
ARR[852] <= VAL;\
ARR[853] <= VAL;\
ARR[854] <= VAL;\
ARR[855] <= VAL;\
ARR[856] <= VAL;\
ARR[857] <= VAL;\
ARR[858] <= VAL;\
ARR[859] <= VAL;\
ARR[860] <= VAL;\
ARR[861] <= VAL;\
ARR[862] <= VAL;\
ARR[863] <= VAL;\
ARR[864] <= VAL;\
ARR[865] <= VAL;\
ARR[866] <= VAL;\
ARR[867] <= VAL;\
ARR[868] <= VAL;\
ARR[869] <= VAL;\
ARR[870] <= VAL;\
ARR[871] <= VAL;\
ARR[872] <= VAL;\
ARR[873] <= VAL;\
ARR[874] <= VAL;\
ARR[875] <= VAL;\
ARR[876] <= VAL;\
ARR[877] <= VAL;\
ARR[878] <= VAL;\
ARR[879] <= VAL;\
ARR[880] <= VAL;\
ARR[881] <= VAL;\
ARR[882] <= VAL;\
ARR[883] <= VAL;\
ARR[884] <= VAL;\
ARR[885] <= VAL;\
ARR[886] <= VAL;\
ARR[887] <= VAL;\
ARR[888] <= VAL;\
ARR[889] <= VAL;\
ARR[890] <= VAL;\
ARR[891] <= VAL;\
ARR[892] <= VAL;\
ARR[893] <= VAL;\
ARR[894] <= VAL;\
ARR[895] <= VAL;\
ARR[896] <= VAL;\
ARR[897] <= VAL;\
ARR[898] <= VAL;\
ARR[899] <= VAL;\
ARR[900] <= VAL;\
ARR[901] <= VAL;\
ARR[902] <= VAL;\
ARR[903] <= VAL;\
ARR[904] <= VAL;\
ARR[905] <= VAL;\
ARR[906] <= VAL;\
ARR[907] <= VAL;\
ARR[908] <= VAL;\
ARR[909] <= VAL;\
ARR[910] <= VAL;\
ARR[911] <= VAL;\
ARR[912] <= VAL;\
ARR[913] <= VAL;\
ARR[914] <= VAL;\
ARR[915] <= VAL;\
ARR[916] <= VAL;\
ARR[917] <= VAL;\
ARR[918] <= VAL;\
ARR[919] <= VAL;\
ARR[920] <= VAL;\
ARR[921] <= VAL;\
ARR[922] <= VAL;\
ARR[923] <= VAL;\
ARR[924] <= VAL;\
ARR[925] <= VAL;\
ARR[926] <= VAL;\
ARR[927] <= VAL;\
ARR[928] <= VAL;\
ARR[929] <= VAL;\
ARR[930] <= VAL;\
ARR[931] <= VAL;\
ARR[932] <= VAL;\
ARR[933] <= VAL;\
ARR[934] <= VAL;\
ARR[935] <= VAL;\
ARR[936] <= VAL;\
ARR[937] <= VAL;\
ARR[938] <= VAL;\
ARR[939] <= VAL;\
ARR[940] <= VAL;\
ARR[941] <= VAL;\
ARR[942] <= VAL;\
ARR[943] <= VAL;\
ARR[944] <= VAL;\
ARR[945] <= VAL;\
ARR[946] <= VAL;\
ARR[947] <= VAL;\
ARR[948] <= VAL;\
ARR[949] <= VAL;\
ARR[950] <= VAL;\
ARR[951] <= VAL;\
ARR[952] <= VAL;\
ARR[953] <= VAL;\
ARR[954] <= VAL;\
ARR[955] <= VAL;\
ARR[956] <= VAL;\
ARR[957] <= VAL;\
ARR[958] <= VAL;\
ARR[959] <= VAL;\
ARR[960] <= VAL;\
ARR[961] <= VAL;\
ARR[962] <= VAL;\
ARR[963] <= VAL;\
ARR[964] <= VAL;\
ARR[965] <= VAL;\
ARR[966] <= VAL;\
ARR[967] <= VAL;\
ARR[968] <= VAL;\
ARR[969] <= VAL;\
ARR[970] <= VAL;\
ARR[971] <= VAL;\
ARR[972] <= VAL;\
ARR[973] <= VAL;\
ARR[974] <= VAL;\
ARR[975] <= VAL;\
ARR[976] <= VAL;\
ARR[977] <= VAL;\
ARR[978] <= VAL;\
ARR[979] <= VAL;\
ARR[980] <= VAL;\
ARR[981] <= VAL;\
ARR[982] <= VAL;\
ARR[983] <= VAL;\
ARR[984] <= VAL;\
ARR[985] <= VAL;\
ARR[986] <= VAL;\
ARR[987] <= VAL;\
ARR[988] <= VAL;\
ARR[989] <= VAL;\
ARR[990] <= VAL;\
ARR[991] <= VAL;\
ARR[992] <= VAL;\
ARR[993] <= VAL;\
ARR[994] <= VAL;\
ARR[995] <= VAL;\
ARR[996] <= VAL;\
ARR[997] <= VAL;\
ARR[998] <= VAL;\
ARR[999] <= VAL;\
ARR[1000] <= VAL;\
ARR[1001] <= VAL;\
ARR[1002] <= VAL;\
ARR[1003] <= VAL;\
ARR[1004] <= VAL;\
ARR[1005] <= VAL;\
ARR[1006] <= VAL;\
ARR[1007] <= VAL;\
ARR[1008] <= VAL;\
ARR[1009] <= VAL;\
ARR[1010] <= VAL;\
ARR[1011] <= VAL;\
ARR[1012] <= VAL;\
ARR[1013] <= VAL;\
ARR[1014] <= VAL;\
ARR[1015] <= VAL;\
ARR[1016] <= VAL;\
ARR[1017] <= VAL;\
ARR[1018] <= VAL;\
ARR[1019] <= VAL;\
ARR[1020] <= VAL;\
ARR[1021] <= VAL;\
ARR[1022] <= VAL;\
ARR[1023] <= VAL


`define RESET_3_BY_9(GRID) \
GRID[0][0] <= 0;\
GRID[1][0] <= 0;\
GRID[2][0] <= 0;\
GRID[3][0] <= 0;\
GRID[4][0] <= 0;\
GRID[5][0] <= 0;\
GRID[6][0] <= 0;\
GRID[7][0] <= 0;\
GRID[8][0] <= 0;\
GRID[0][1] <= 0;\
GRID[1][1] <= 0;\
GRID[2][1] <= 0;\
GRID[3][1] <= 0;\
GRID[4][1] <= 0;\
GRID[5][1] <= 0;\
GRID[6][1] <= 0;\
GRID[7][1] <= 0;\
GRID[8][1] <= 0;\
GRID[0][2] <= 0;\
GRID[1][2] <= 0;\
GRID[2][2] <= 0;\
GRID[3][2] <= 0;\
GRID[4][2] <= 0;\
GRID[5][2] <= 0;\
GRID[6][2] <= 0;\
GRID[7][2] <= 0;\
GRID[8][2] <= 0

`define SUM_L9_MASK(M) \
M[0] + M[1] + M[2] + M[3] + M[4] + M[5] + M[6] + M[7] + M[8]

`define HIDDEN_GROUP_MASK(MARR) \
{(|MARR[8]), (|MARR[7]), (|MARR[6]), (|MARR[5]), (|MARR[4]), (|MARR[3]), (|MARR[2]), (|MARR[1]), (|MARR[0])}

`define NAKED_GROUP_MASK(MARR, N)   \
{(((MARR[8]) == N) ? 1'b1 : 1'b0), (((MARR[7]) == N) ? 1'b1 : 1'b0), (((MARR[6]) == N) ? 1'b1 : 1'b0),  \
 (((MARR[5]) == N) ? 1'b1 : 1'b0), (((MARR[4]) == N) ? 1'b1 : 1'b0), (((MARR[3]) == N) ? 1'b1 : 1'b0),  \
 (((MARR[2]) == N) ? 1'b1 : 1'b0), (((MARR[1]) == N) ? 1'b1 : 1'b0), (((MARR[0]) == N) ? 1'b1 : 1'b0)}

`define SET_ARR_TO_SUM(MARR, SARR) \
assign MARR[8] = `SUM_L9_MASK(SARR[8]);\
assign MARR[7] = `SUM_L9_MASK(SARR[7]);\
assign MARR[6] = `SUM_L9_MASK(SARR[6]);\
assign MARR[5] = `SUM_L9_MASK(SARR[5]);\
assign MARR[4] = `SUM_L9_MASK(SARR[4]);\
assign MARR[3] = `SUM_L9_MASK(SARR[3]);\
assign MARR[2] = `SUM_L9_MASK(SARR[2]);\
assign MARR[1] = `SUM_L9_MASK(SARR[1]);\
assign MARR[0] = `SUM_L9_MASK(SARR[0])

`define SET_ARR_TO_SUM_2D(MARR, SARR, IND) \
assign MARR[8] = `SUM_L9_MASK(SARR[8][IND]);\
assign MARR[7] = `SUM_L9_MASK(SARR[7][IND]);\
assign MARR[6] = `SUM_L9_MASK(SARR[6][IND]);\
assign MARR[5] = `SUM_L9_MASK(SARR[5][IND]);\
assign MARR[4] = `SUM_L9_MASK(SARR[4][IND]);\
assign MARR[3] = `SUM_L9_MASK(SARR[3][IND]);\
assign MARR[2] = `SUM_L9_MASK(SARR[2][IND]);\
assign MARR[1] = `SUM_L9_MASK(SARR[1][IND]);\
assign MARR[0] = `SUM_L9_MASK(SARR[0][IND])

`define ASSIGN_ARR_9(ARR1, ARR2, MASK) \
if (MASK[0]) ARR1[0] <= ARR2[0];\
if (MASK[1]) ARR1[1] <= ARR2[1];\
if (MASK[2]) ARR1[2] <= ARR2[2];\
if (MASK[3]) ARR1[3] <= ARR2[3];\
if (MASK[4]) ARR1[4] <= ARR2[4];\
if (MASK[5]) ARR1[5] <= ARR2[5];\
if (MASK[6]) ARR1[6] <= ARR2[6];\
if (MASK[7]) ARR1[7] <= ARR2[7];\
if (MASK[8]) ARR1[8] <= ARR2[8]

`define ASSIGN_ARR_TO_DIM_2_9(ARR1, ARR2, IND_D1, MASK) \
if (MASK[0]) ARR1[0][IND_D1] <= ARR2[0];\
if (MASK[1]) ARR1[1][IND_D1] <= ARR2[1];\
if (MASK[2]) ARR1[2][IND_D1] <= ARR2[2];\
if (MASK[3]) ARR1[3][IND_D1] <= ARR2[3];\
if (MASK[4]) ARR1[4][IND_D1] <= ARR2[4];\
if (MASK[5]) ARR1[5][IND_D1] <= ARR2[5];\
if (MASK[6]) ARR1[6][IND_D1] <= ARR2[6];\
if (MASK[7]) ARR1[7][IND_D1] <= ARR2[7];\
if (MASK[8]) ARR1[8][IND_D1] <= ARR2[8]

`define ASSIGN_ARR_9_CONST(ARR1, CONST, MASK) \
if (MASK[0]) ARR1[0] <= CONST;\
if (MASK[1]) ARR1[1] <= CONST;\
if (MASK[2]) ARR1[2] <= CONST;\
if (MASK[3]) ARR1[3] <= CONST;\
if (MASK[4]) ARR1[4] <= CONST;\
if (MASK[5]) ARR1[5] <= CONST;\
if (MASK[6]) ARR1[6] <= CONST;\
if (MASK[7]) ARR1[7] <= CONST;\
if (MASK[8]) ARR1[8] <= CONST

`define ASSIGN_ARR_TO_DIM_2_9_CONST(ARR1, CONST, IND_D1, MASK) \
if (MASK[0]) ARR1[0][IND_D1] <= CONST;\
if (MASK[1]) ARR1[1][IND_D1] <= CONST;\
if (MASK[2]) ARR1[2][IND_D1] <= CONST;\
if (MASK[3]) ARR1[3][IND_D1] <= CONST;\
if (MASK[4]) ARR1[4][IND_D1] <= CONST;\
if (MASK[5]) ARR1[5][IND_D1] <= CONST;\
if (MASK[6]) ARR1[6][IND_D1] <= CONST;\
if (MASK[7]) ARR1[7][IND_D1] <= CONST;\
if (MASK[8]) ARR1[8][IND_D1] <= CONST

//
// FUNCTIONS
//
function automatic [8:0] one_hot;
input [3:0] raw_in;
begin
	case(raw_in)
		4'd1	: one_hot = 9'b0_0000_0001;
		4'd2	: one_hot = 9'b0_0000_0010;
		4'd3	: one_hot = 9'b0_0000_0100;
		4'd4	: one_hot = 9'b0_0000_1000;
		4'd5	: one_hot = 9'b0_0001_0000;
		4'd6	: one_hot = 9'b0_0010_0000;
		4'd7	: one_hot = 9'b0_0100_0000;
		4'd8	: one_hot = 9'b0_1000_0000;
		4'd9	: one_hot = 9'b1_0000_0000;
		default	: one_hot = 9'b0_0000_0000;
	endcase
end
endfunction

function automatic [3:0] bcd;
input [8:0] one_hot_in;
begin
	case(one_hot_in)
		9'b0_0000_0001	: bcd = 4'd1;
		9'b0_0000_0010	: bcd = 4'd2;
		9'b0_0000_0100	: bcd = 4'd3;
		9'b0_0000_1000	: bcd = 4'd4;
		9'b0_0001_0000	: bcd = 4'd5;
		9'b0_0010_0000	: bcd = 4'd6;
		9'b0_0100_0000	: bcd = 4'd7;
		9'b0_1000_0000	: bcd = 4'd8;
		9'b1_0000_0000	: bcd = 4'd9;
		default			: bcd = 4'd0;
	endcase
end
endfunction

function automatic valid_one_hot;
input [8:0] one_hot_in;
begin
	case(one_hot_in)
		9'b0_0000_0001	: valid_one_hot = 1'b1;
		9'b0_0000_0010	: valid_one_hot = 1'b1;
		9'b0_0000_0100	: valid_one_hot = 1'b1;
		9'b0_0000_1000	: valid_one_hot = 1'b1;
		9'b0_0001_0000	: valid_one_hot = 1'b1;
		9'b0_0010_0000	: valid_one_hot = 1'b1;
		9'b0_0100_0000	: valid_one_hot = 1'b1;
		9'b0_1000_0000	: valid_one_hot = 1'b1;
		9'b1_0000_0000	: valid_one_hot = 1'b1;
		default			: valid_one_hot = 1'b0;
	endcase
end
endfunction

function automatic [8:0] get_exclusive_line_possibilities;
input [8:0] p1, p2, p3;
begin
	get_exclusive_line_possibilities = p1 & (~p2) & (~p3);
end
endfunction

function automatic [3:0] get_square;
input [3:0] r_count, c_count;
begin
	if (r_count >= 6)
	begin
		if (c_count >= 6)
		begin
			get_square = 8;
		end
		else if (c_count >= 3)
		begin
			get_square = 7;
		end
		else
		begin
			get_square = 6;
		end
	end
	else if (r_count >= 3)
	begin
		if (c_count >= 6)
		begin
			get_square = 5;
		end
		else if (c_count >= 3)
		begin
			get_square = 4;
		end
		else
		begin
			get_square = 3;
		end
	end
	else
	begin
		if (c_count >= 6)
		begin
			get_square = 2;
		end
		else if (c_count >= 3)
		begin
			get_square = 1;
		end
		else
		begin
			get_square = 0;
		end
	end
end
endfunction

function automatic [8:0] mux9mask;
input [3:0] sel;
input [8:0] i0, i1, i2, i3, i4, i5, i6, i7, i8;
begin
	case(sel)
		0: mux9mask = i0;
		1: mux9mask = i1;
		2: mux9mask = i2;
		3: mux9mask = i3;
		4: mux9mask = i4;
		5: mux9mask = i5;
		6: mux9mask = i6;
		7: mux9mask = i7;
		8: mux9mask = i8;
		default: ;
	endcase
end
endfunction