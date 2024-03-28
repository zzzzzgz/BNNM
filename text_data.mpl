
netarr:={[3,3,1],[3,4,1],[3,5,1],[3,3,2,1],[3,4,2,1],[3,5,2,1],[3,5,3,1]};




net3_1:=[3,3,1];
net3_2:=[3,4,1];
net3_3:=[3,5,1];
net4_1:=[3,4,2,1];
net4_2:=[3,4,3,1];
net4_3:=[3,5,2,1];
net4_4:=[3,5,3,1];
net4_5:=[3,3,2,1];



lay2_1:=[(k)->cos(k),(k)->cosh(k)];
lay2_2:=[(k)->cos(k),(k)->(k)];
lay2_3:=[(k)->exp(k),(k)->exp(k)];
lay2_4:=[(k)->exp(k),(k)->(k)^2];
lay2_5:=[(k)->exp(k),(k)->cosh(k)];
lay2_6:=[(k)->exp(k),(k)->tanh(k)];
lay2_7:=[(k)->(k)^2,(k)->(k)];
lay2_8:=[(k)->(k)^2,(k)->(k)^2];
lay2_9:=[(k)->(k)^2,(k)->tanh(k)];
lay2_10:=[(k)->(k)^2,(k)->cosh(k)];
lay2_11:=[(k)->(k)^2,(k)->cos(k)];
lay2_12:=[(k)->(k)^2,(k)->sinh(k)];
lay2_13:=[(k)->sin(k),(k)->cosh(k)];
lay2_14:=[(k)->sin(k),(k)->sinh(k)];
lay2_15:=[(k)->sinh(k),(k)->cosh(k)];
lay2_16:=[(k)->sinh(k),(k)->cos(k)];


lay3_1:=[(k)->cos(k),(k)->cosh(k),(k)->cos(k)];
lay3_2:=[(k)->cos(k),(k)->cosh(k),(k)->exp(k)];
lay3_3:=[(k)->cos(k),(k)->cosh(k),(k)->sinh(k)];
lay3_4:=[(k)->cos(k),(k)->cosh(k),(k)->sin(k)];
lay3_5:=[(k)->cos(k),(k)->cosh(k),(k)->tanh(k)];
lay3_6:=[(k)->cos(k),(k)->cosh(k),(k)->tan(k)];
lay3_7:=[(k)->exp(k),(k)->exp(k),(k)->cos(k)];
lay3_8:=[(k)->exp(k),(k)->exp(k),(k)->cosh(k)];
lay3_9:=[(k)->exp(k),(k)->exp(k),(k)->(k)];
lay3_10:=[(k)->exp(k),(k)->exp(k),(k)->(k)^2];
lay3_11:=[(k)->exp(k),(k)->exp(k),(k)->exp(k)+exp(-k)];
lay3_12:=[(k)->exp(k),(k)->exp(k),(k)->sinh(k)];
lay3_13:=[(k)->(k)^2,(k)->(k)^2,(k)->(k)];
lay3_14:=[(k)->(k)^2,(k)->(k)^2,(k)->sinh(k)];
lay3_15:=[(k)->(k)^2,(k)->(k)^2,(k)->tanh(k)];
lay3_16:=[(k)->(k)^2,(k)->(k)^2,(k)->cosh(k)];
lay3_17:=[(k)->(k)^2,(k)->(k)^2,(k)->cos(k)];
lay3_18:=[(k)->(k)^2,(k)->(k)^2,(k)->exp(k)];
lay3_19:=[(k)->(k)^2,(k)->(k)^2,(k)->exp(k)+exp(-k)];
lay3_20:=[(k)->(k)^2,(k)->(k)^2,(k)->(k)^3];

lay4_1:=[(k)->cos(k),(k)->tanh(k),(k)->cosh(k),(k)->sinh(k)];
lay4_2:=[(k)->cos(k),(k)->cosh(k),(k)->tanh(k),(k)->sinh(k)];
lay4_3:=[(k)->cos(k),(k)->cosh(k),(k)->k,(k)->(k)^2];
lay4_4:=[(k)->cos(k),(k)->cosh(k),(k)->(k)^2,(k)->(k)^2];
lay4_5:=[(k)->cos(k),(k)->cosh(k),(k)->tan(k),(k)->cot(k)];
lay4_6:=[(k)->cos(k),(k)->cosh(k),(k)->exp(k)+exp(-k),(k)->exp(k)];
lay4_7:=[(k)->sinh(k),(k)->cosh(k),(k)->tan(k),(k)->cot(k)];
lay4_8:=[(k)->exp(k),(k)->exp(k),(k)->cot(k),(k)->cosh(k)];
lay4_9:=[(k)->exp(k),(k)->exp(k),(k)->(k)^2,(k)->cosh(k)];
lay4_10:=[(k)->exp(k),(k)->exp(k),(k)->(k)^2,(k)->(k)^2];
lay4_11:=[(k)->exp(k),(k)->exp(k),(k)->cos(k),(k)->sin(k)];

lay5_1:=[(k)->cos(k),(k)->cosh(k),(k)->cos(k),(k)->exp(k),(k)->tanh(k)];
lay5_2:=[(k)->cos(k),(k)->cosh(k),(k)->sin(k),(k)->sinh(k),(k)->tanh(k)];
lay5_3:=[(k)->cos(k),(k)->cosh(k),(k)->sin(k),(k)->k,(k)->(k)^2];
lay5_4:=[(k)->cos(k),(k)->cosh(k),(k)->k,(k)->(k)^2,(k)->(k)^2];
lay5_5:=[(k)->cos(k),(k)->cosh(k),(k)->tanh(k),(k)->tan(k),(k)->cot(k)];
lay5_6:=[(k)->cos(k),(k)->cosh(k),(k)->exp(k)+exp(-k),(k)->sin(k),(k)->exp(k)];
lay5_7:=[(k)->sinh(k),(k)->cosh(k),(k)->tan(k),(k)->cot(k),(k)->cos(k)];
lay5_8:=[(k)->exp(k),(k)->exp(k),(k)->k,(k)->cot(k),(k)->cosh(k)];
lay5_9:=[(k)->exp(k),(k)->exp(k),(k)->(k)^2,(k)->(k)^2,(k)->cosh(k)];
lay5_10:=[(k)->exp(k),(k)->exp(k),(k)->k,(k)->(k)^2,(k)->(k)^2];
lay5_11:=[(k)->exp(k),(k)->exp(k),(k)->k,(k)->cos(k),(k)->sin(k)];


layer2:=[
    lay2_1,lay2_2,lay2_3,lay2_4,lay2_5,lay2_6,lay2_7,lay2_8,lay2_9,lay2_10,lay2_11,lay2_12,lay2_13,lay2_13,lay2_14,lay2_15,lay2_16
];

layer3:=[
    lay3_1,lay3_2,lay3_3,lay3_4,lay3_5,lay3_6,lay3_7,lay3_18,lay3_9,lay3_10,lay3_11,lay3_12,lay3_13,lay3_14,lay3_15,lay3_16,lay3_17,lay3_18,lay3_19,lay3_20
];

layer4:=[
    lay4_1,lay4_2,lay4_3,lay4_4,lay4_5,lay4_6,lay4_7,lay4_8,lay4_9,lay4_10,lay4_11
];

layer5:=[
    lay5_1,lay5_2,lay5_3,lay5_4,lay5_5,lay5_6,lay5_7,lay5_8,lay5_9,lay5_10,lay5_11
];