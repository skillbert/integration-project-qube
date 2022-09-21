function [A,B,C,D]=findmodelcb(tua,G)

A=[
    0,1,0,0
    0,0,tua(1),0
    0,0,0,1
    0,0,tua(2),0
];

B=[
    0
    tua(3)
    0
    tua(4)
];

C=[
    1,0,0,0
    0,0,1,0
];
D=[
   0
   0
];