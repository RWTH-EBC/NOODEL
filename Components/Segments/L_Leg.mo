within NOODEL.Components.Segments;
model L_Leg
  extends BodyPart(
  core(
    TSET=36.58,
    Ccore=(2.06568 * 1000),
    QB=0.357,
    weight=1.503,
      Q(start=0.357)),
  skin(
    QB=0.023,
    TSET=34.13,
    TSETpsy=32.99,
    weight=1.837,
    S=0.112,
    Cskin=(0.6084 * 1000)),
  CoreConv(                     BFB=0.164/3600, BF(start=0.06/3600)),
  SkinConv(                     BFB=0.651/3600, BF(start=0.05/3600)),
  alpha=0.444,
  CD=3.326,
  SKINR = 0.0251,
  SKINS = 0.036,
  SKINV = 0.023,
  SKINC = 0.0213,
  CHILF = 0.0018,
  METF = 0.099,
  RESC=0,
  B=13.2,
  n=0.58,
  Bs=12.85,
  ns=0.505,
  CR=1,
  CRS=0.8,
  TClcoeff={-0.398,0.0806,0.5936},
  CoeffTSl={0.22,0.1,0.48,0.1,206,212,0});

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Bitmap(extent={{-28,-28},{24,34}},
          imageSource="iVBORw0KGgoAAAANSUhEUgAAAHcAAADwCAYAAAA6jPvqAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAC0FJREFUeNrsnd9uG8cVxjdErAKRBFISIsWwazGpDV+l4nV6Yb5BlZsod/EjuE9QPYL6BJXvrDvlDSigDoymduhGSazakUhHBmsVMilYChDpwt0xhgln9sz+4+zszPD7AELWUI6c/fE7c86cmd131j77rBMEwXIAjaNu+Oqk/Nk797a22ib+Ue+Gr/Xw9XfwGUvLGQxSD19G4FbCT9Em/+RBZtQw9Ysq/Osmrrkx3Tb1i9558+ZN8PnaWo3PGdXhGzMzM8Enf/oEKFKo3+8HFxcX9Huv+kG3GwmMn4YRc9vEnBuEv2gQAt4I//jX4Runp6dvvy6+vwh6CYq7Rgx6r9cLzs/PhaQqfBUOtzLy50ho3nuyB3Jj6tKlS8H169fl4VuhmZrG4IbuZWH5rpDfh+Hk7OwMhMbUzZs3S5l7K9L36/IP7O7ugs6Ymp6eDm7cuCEPfxG6t24MLnfvl7J7ocLcu27SuUwbo9+wRODwxSHojKlarRZcvnxZHl7llYoZuKF7W/KixsH+Aeho0Md//FgeqvLM2ZhzAzlNZ6FZVcdB2Uomtn4g6U5R7lXBjZRFCM16tNJYMeZeEi7vWgih+fAnwNWhD+sfGnNvJea9TYRmt92bGi7T/sE+yDjkXiVcXvM+FuD+CLguubeS8L7g3uPjYyxHOuTeJLjbyJrddW8sXB6adxCajbp31ZRzEZrNu3dFV0MhDdxIaD77GXB16eqVq9TwqhG4bJcGEBQn1sxfWFiQh5umnMt0MvoN2zME6dNHf/hIHvqzjqw5LVxhny1WqvRqaXGJGm6aggsVKNbrLSJrTgu3I4TlVwjLukU08pulwJW2aUIadOXqFXloOZx3GybgQg6WRLmcyzZZQ/q1vLxcPlyoIPf+PuLelXFKotxhGeWQfimOpTSLhhs5T9ofIGPWLbZ5nSiJioWLJUg3S6LcYRmdoYJC89Kitnk3C9wu4Lo172aBK+TpbMkMsnveTQWXOks6V5sDCcvn3bTObVCfMMjueTct3HrCJwuycN7N5dy5OYRkF+bdtHBvCb98BiG5hHl3VTtcaicenFvKvLucdVdkGuc2Us4JkEYpWoDNQuEScwFUgHTsiswMl/iFUEFaWloaa95NA1f4tMzNY741Fpqj/d1qlq03lYRkin1SqqNjWHZ0p95Ncq4QBqamplQTPVSQxtl6kwku8Ysg8yXRrbHh8tguhGRi+yVUdFJFnEbg0+VYzr2NkFy+xjmNUEFItl/Xrl3TB5eH5GWEZGvn3Wqa0FxJU9u+rbkQksurd8Nrz6bFrCWRCq5QKKN/62ZJlAouukDlK89BMRVc4S4cWHK0IzQnVTSJcLEZzp/QXEkKycNaC7LAvdFGQmwDPxEukinrQ3MzN1wkU/ZI0cDP5FwkUxZrfn4+n3Op1Bqbz+0SsfM0tXMjmRM2w9mlxcXorsi0cAXnEkteUNnOfS8aSVXPBYx1LjbDWQiXniYbaeAKnwBsY7VTRHlaz+xcHBuxU0R5msq5QhmElSlnMuZ4uNQyFhIqZ5xbpfhV4uI2yiBL4dKNnEYcXJRBjogtQ6Y5v1tBGeRNxhwLF2WQQ0pz34xKhowMsgluinNEyjmXxXXI4nIoxX0zRuFWE9JtyLF5F3dK92zejcDV9XgxqPx5d7RDNHRuPeWEDVk278adREBY9njeHcJFh8BREXvc6jJcbGd1dd6N2XaDsOyhhitVCMuuh+WYDhEZlrGA4Y4UK4k1ZVie+h3afS6J6OA1MOd6IlXvHXA9kKqBQMI9O8VjZVySqj07hNsaHTw9PcUVczupwpzrTTlE7IYchSs8q+/4+BhXzKWE6lI0oWInNodwhads4rHlbklxeKCGsOyxyLD8dmCAp6p6Affe1lbk4cfnFwjNvjgX8hyu8Hzco6MjXB2HRKxSNUbhdnCJ3NXs7Gz6bBlLkH6F5dboG1iCREIFOQJXmHN7vR6ujq9wIc/D8tkZkipXRHSGmr/Cvbe11YrA/RlwXRG17w0JlSc6/+U8ES5WqRxVv9+Xh1oyXCRVE5NQYZXKGb1+/ToRbgu1rpsiVhQjYbkt/4WLiwtcOU/CcqRp3x/0cZUsl2o9QoAb1rodZMwOwiXWI9i6BZVQCe59+d+XuHoeZcsCXOxhdjIsn6jgChkz28N89D+EZsfgtkm4fI35ZHTs239/iyvoSVhm2pDrXbjXXvVfRSqaQRJcuNcREcd/2kq4YWgewL1Ow40Ny3CvQyIqmnYsXLjXDSmWhwdJziXd+/BfD3FFbUqm6OXhdiJcyr0sBBx0DnBVLRbnlmqbTcS9j9uPcQUtEbH2302TUCndy1qBcK+16qSGq3Lv1//8Gr1eC0Q0drLB5e5dl2urvf/s4ep64FwGeCOQer3ff/c93FuyiK1Q2eFyRdz76NEjXGHXncvduym79+nTp0iuysqU6QWl3M5lui0P3P/Hfdz9xp4aNz9c3u/9mzzearUw/1pU4+Z1LgN8J/yyI9e+Dx48wBW3ZL7NDZdrVa59u91usPvdLi6xBTXuWHB57bsqj7e/aWP+NSSij6vNucP59y/y+MOH6ByZkKqPqwUuB7whz7+ssMbqVbFSnDIYaIU7Uh5FOkfInguES9/1oK0dLq+tNuT5ANlzcSIOW//ax9XtXPYfXmeGlbNnbMspRkRU3JEHdN8T44488NX9r0DCTBk0KBQutXqFxr4xtYt2LtO6nFzt/7iPS69Zca2+wuBiS2wp860ZuFwb8gA2tGvMlGO2sxYOl7v3LtxrbgFDLoOKdO5w7hW09wSrVgXB3aF+rjC4fGHjrlz34mahGsKy4simSeeS7t3dRUtwXKmObBqFy927I7sXa87Fl0EmnBtxL/Y7mymDjMDlq1bC3p5nT5+BUsFlkCnnRtyLJcniyyBjcKn9zjgpWGwZZNK5TJtwrwa4GW6TbBIuzvlqEHXr3dLh4pyvHhGb4gY2OBfuNbiAYRyuyr1oKKRT0sGvsp1LuhftwNyuFQ5+lQ6Xu3d7dIwtp6GhkCziJMdjW7Jl5aIGExoKucqggXVweSj5cnSMHeJGQyFzGdS20blBQGzFQUMhXsSzgwZWwuUNBWHpDDdQ0beAUbZzmTblbBDuVcy3ORLOUuFSDQW4VwFX8XgZm50byZyZew9fHIKmBpUOF+3AdCJO9Z1YD5dyLxoKURFTVdsJuNy9wifxyQ9PQNT1sKyqe1lrCzdO+U1Jd65xCi7T/j5OB8bIHbi8oSAsST57hl2So1WEy2GZaRNlES1iB0bLKbihe7flxOpgH1mzDwkV6V4cP0l3zykn4TJNemhWLD22nYPL/9HCEtXhT5h3fQnLCM2SiKXHrstwtxGafxPxwe44C5dvw0Fo9jQsIzSP1vu/nHsHF6FZPee2nIaL0Ox3WI64FwsaHsNlenn0cuIgEevKHefh8gUNoaZ7cfhi8hKqhAdVuOpcMjRDfoTlCFz2KZ6kI5/j5BjWw+V7c08mNWvOcmsiF50bce/z588nOtyqbk3kBVzizAzkMNyJ3QZJNOpPfIMbAG62+RZwEZbtDMu4h4YncKn9Qopn2XmnPCcNEJbdFeBCgAu4EOBCgAsBLgS4EOACLgS4EOBCgAsBLgS4EOACLmSn6oDriZY+WAJcCHCd0/T0tDx0C3D9hQvn+qzP19bqgOuBFt9fzJ0xAy4SKqhMzczMyENNwPVEs7OzcK6vmpqawpzrq+bm5+ShBuD6W+uueA03z9M6nHVubY6qdRs+wRWetTtJD5Sq1WrUcMNb506aFhYWMidV77r6Pzs8lMzmo3HWXx3OmJvewu31em9fEyyEZY9VTWogAK7bqvsSltsx4ak6oXDZvNtSvfl/AQYAc86aPaBgh28AAAAASUVORK5CYII=",
          fileName="modelica://ComfortModel33NCM/Pictures/Unterschenkel rechts.png")}));

end L_Leg;
