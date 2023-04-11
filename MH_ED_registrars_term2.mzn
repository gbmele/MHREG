int: emp_num     = 1;
int: reg_role    = 2;
int: FullPartTime =3;


%function var string: get_reg(regs:reg,int:num) =
%        REGISTRARS[reg,num];
    
array[ regs, 1..3] of var string: REGISTRARS = array2d( regs, 1..3, [
%empnum      regrole              FullPartTime        
"53620","12240-B0041-03-Reg1","FT",%,Bennetts, Rebekah [FIT-P] [53620 FT 59 HM29],
"59148","12240-B0041-03-Reg2","FT",%,Burbano Vesga, Camilo [FIT-P] [59148 FT 59 HM30],
"59575","12240-B0041-03-Reg3","FT",%,Le, Duy [FIT-P] [59575 FT 59 HM29],
"59117","12240-B0041-03-Reg4","FT",%,Lazarus, Joshua [FIT-EXPIRED] [59117 FT 59 HM26],
"63593","12240-B0041-03-Reg5","FT",%,Clifford, Isaac [FIT-P] [63593 FT 59 HM29],
"62326","12240-B0041-03-Reg6","FT",%,Hughes, Niamh [FIT-P] [IMG-AHPRA L2 Supervision] [62326 FT 59 HM25],
"62306","12240-B0041-03-Reg7","FT",%,Morrice, Cameron [FIT-P] [62306 FT 59 HM25],
"58921","12240-B0041-03-Reg8","FT",%,Padukka, Pununuwan (Mani) [FIT-P] [58921 FT 59 HM27],
"62644","12240-B0041-03-Reg9","FT",%,Gohil, Jai [FIT-EXPIRED] [62644 FT 59 HM25],
"64226","12240-B0041-03-Reg10","FT",%,Wilson, Beau [64226 FT 59 HM25],
"61711","12240-B0041-03-Reg11","34T",%,De Vass, Dilum [FIT-EXPIRED] [61711 PT 59 HM29],
"62320","12240-B0041-03-Reg12","FT",%,Flain, Luke [FIT-P] [62320 FT 09 HM13],
"62696","12240-B0041-03-Reg13","FT",%,Kelsey, Megan [FIT-P] [62696 FT 09 HM13],
"64191","12240-B0041-03-Reg14","FT",%,Tall, William [64191 FT 59 HM25],
"62318","12240-B0041-03-Reg15","FT",%,Watson, Samuel [FIT-P] [IMG-AHPRA L2 Supervision] [62318 FT 59 HM25],
"63527","12240-B0041-03-Reg16","FT",%,Heng, Sing Peng(Hannah) [FIT-P] [63527 FT 09 HM13],
"52782","12240-B0041-03-Reg17","PT",%,Paramarajah, Pushparani [FIT-EXPIRED] [52782 PT 59 HM29],
"64196","12240-B0041-03-Reg18","34T",%,Minhas, Jaisneet [64196 PT 59 HM29],
"61188","12240-B0041-03-Reg19","34T",%,Ruiz Gonzalez, Sandra [61188 PT 59 HM26],
"58094","12240-B0041-03-Reg20","PT",%,Chan, Jannet [FIT-P] [58094 PT 59 HM30],
"51525","12240-B0041-03-Reg21","PT",%,Liang, Xuebing(Alicia) [FIT-P] [51525 PT 09 HM20],
"53694","12240-B0041-03-Reg22","PT",%,Lim, James [FIT-EXPIRED] [53694 PT 59 HM30],
"45804","12240-B0041-03-Reg23","PT",%,Ata Ul Haq, Haseeb Ul Haq [FIT-N] [45804 PT 59 HM30],

]);




/*
"53620","12240-B0041-03-Reg1","FT", % rebekah bennetts US SSP,1
"58706","12240-B0041-03-Reg2","FT",% sabahat zaidi,2
"59148","12240-B0041-03-Reg3","FT",% camilo vesga,3
"58930","12240-B0041-03-Reg4","FT",% Peter Tao,4
"62330","12240-B0041-03-Reg5","FT",% luke wynne,5
"62644","12240-B0041-03-Reg6","FT",% jai gohil,6
"63593","12240-B0041-03-Reg7","FT",% isaac clifford,7
"62326","12240-B0041-03-Reg8","FT",% niamh hughe,8
"59117","12240-B0041-03-Reg9","FT",% josh lazarus,9
"62306","12240-B0041-03-Reg10","FT",% cameron morrice,10
"58921","12240-B0041-03-Reg11","FT",% mani padukka,11
"58932","12240-B0041-03-Reg12","FT",% justin shin,12
"99999","12240-B0041-03-Reg13","FT",%blank,13
"64226","12240-B0041-03-Reg14","FT",% beau wilson St Vs,14
"52782","12240-B0041-03-Reg15","PT",% pushparaani paramarajah,15
"64196","12240-B0041-03-Reg16","PT",% jaisneet minhas,16
"61188","12240-B0041-03-Reg17","PT",% sandra ruiz,17
"58094","12240-B0041-03-Reg18","PT",% jannet chan,18
"29821","12240-B0041-03-Reg19","PT",% deepak,19
"51525","12240-B0041-03-Reg20","PT",% alicia Liang CMO no teaching time,20
"53694","12240-B0041-03-Reg21","PT",% james lim,21
"58919","12240-B0041-03-Reg22","PT",% victoria Ho,22
*/