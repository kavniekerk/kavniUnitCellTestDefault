//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 
// mmGasUnitCellTestCurvedWireTestCaseTripleLayer.geo
//
// Description:
// Geometry file for a MM cell
// This cell can be repeated any number of times within Garfield 
// to construct an arbitrarily large MM
//
//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// HEADER FILES
//

Include "mmGasComponentLabel.pro";
// Include "mmGasMeshingOptions.pro";

// Include "mmGasUnitCellTestShellStructureSingleLayer.geo";
Include "mmGasUnitCellTestShellStructureTripleLayer.geo";

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// MMGASSTRWIRE GEOMETRY MODULE
//

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// GENERAL INFORMATION
//
// mmGasUnitCellTestCurvedWireTestCaseTripleLayer.geo
//
// Description
//
// References
//
// See also
//

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// CONSTANTS


//----------------------------------------------------------
// mesh window and wire parameters

mwf = 1;                                                   // meshWindow_factor
mm = 1;                                                    // geometrical scaling

rW = 0.0085 * mm;                                          // R of Wiremesh, in microns
hp0 = 0.025;                                               // half pitch of the window, in mm
hp = 0.025 * mm - 0*rW/mwf * mm;                           // half pitch of the window, in microns

p = hp0;                                                   // half pitch of the window, in mm

R = (p * p + rW * rW)/( (2 * rW) );                        // R
alpha = Asin( (p/R) );                                     // angle in radians

spFac1 = p*0.00;
spFac2 = p*0.00;

x1SPWindFac2 = p*0.00;
x2SPWindFac2 = p*0.00;
y1SPWindFac2 = p*0.00;
y2SPWindFac2 = p*0.00;

Rtp = R + R*0.0;
Rtn = R - R*0.0;


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// GEOMETRY PARAMETERS

//----------------------------------------------------------
// Extrusion Precision

// Geometry.ExtrudeSplinePoints = 3;
// Geometry.Points = 0;
// Geometry.Tolerance = 1e-03;
// Coherent Mesh;
// Coherence;
// Geometry.AutoCoherence = 1;


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// MESHING PARAMETERS

//----------------------------------------------------------
// Characteristic lengths - characterization of mesh

// current best dimensions for mesh characteristic lengths

  lcDielectricPillar = 0.0025;                                                                                              // characterization of dielectric 
  lcEtchingPillar = 0.0025;                                                                                                 // characterization of dielectric etching
  lcCopperPlateBdry = 0.0025;                                                                                               // characterization of metal surfaces / anode
  lcExtElectrodeBdry = 0.0050;                                                                                              // characterization of external electrode / cathode
  lcWireMesh = 0.001;                                                                                                       // characterization of wire electrode


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/////// Face 1a - half wire (y - z) extrude in x direction - Corner 3 to Corner 4
//
// Wire 1a1


p1a1_0 = newp; Point(p1a1_0) = {p+p+spFac1,p+p+spFac1,rW+meshLevel*mm, lcWireMesh * mm};                                    // centre circle
p1a1_1 = newp; Point(p1a1_1) = {p+p+spFac1,p+p+spFac1,0+meshLevel*mm, lcWireMesh * mm};                                     // bottom circle
// p1a1_2 = newp; Point(p1a1_2) = {p+p+spFac1,p+p+spFac1+rW,rW+meshLevel*mm, lcWireMesh * mm};                              // right circle
p1a1_3 = newp; Point(p1a1_3) = {p+p+spFac1,p+p+spFac1,2*rW+meshLevel*mm, lcWireMesh * mm};                                  // top circle
p1a1_4 = newp; Point(p1a1_4) = {p+p+spFac1,p+p+spFac1-rW,rW+meshLevel*mm, lcWireMesh * mm};                                 // left circle

l1a1s_1 = newl; Line(l1a1s_1) = {p1a1_1, p1a1_3};
l1a1_2 = newc; Circle(l1a1_2) = {p1a1_3, p1a1_0, p1a1_4};
l1a1_3 = newc; Circle(l1a1_3) = {p1a1_4, p1a1_0, p1a1_1};

ll1a1_1 = newll; Line Loop(ll1a1_1) = {l1a1_2, l1a1_3, l1a1s_1};

s1a1_1 = news; Plane Surface(s1a1_1) = {ll1a1_1};

tmpaa_1_1[] = {s1a1_1};

saaf_1_1_1[] = {};
saaf_1_1_1[] = tmpaa_1_1[0];


// ptsab_1_1 = newp; Point(ptsab_1_1) = { p+p +1.00*spFac1, p+p +1.00*spFac1, -Rtn+rW +meshLevel*mm };

tmpab_1_1[] = Extrude {{x1SPWindFac2,0,0}, {0,-1,0}, { p+p +1.00*spFac1, p+p +1.00*spFac1, -Rtn+rW +meshLevel*mm }, 1.00*alpha } {
  Surface{tmpaa_1_1[0]};
};

sab_1_1[] = {};
sab_1_1[] += tmpab_1_1[{2:4}];


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Wire 1a2


// ptsab_1_2 = newp; Point(ptsab_1_2) = { -p+p +1.00*spFac1, p+p +1.00*spFac1, Rtp-rW +meshLevel*mm };

tmpab_1_2[] = Extrude {{x1SPWindFac2,0,0}, {0,1,0}, { -p+p +1.00*spFac1, p+p +1.00*spFac1, Rtp-rW +meshLevel*mm }, 1.00*alpha} {
  Surface{tmpab_1_1[0]};
};

sab_1_2[] = {};
sab_1_2[] += tmpab_1_2[{2:4}];


sabf_2_1_2[] = {};
sabf_2_1_2[] = {tmpab_1_2[0]};

// sl_wire_exterior_surface_1a[] = newreg; Surface Loop(sl_wire_exterior_surface_1a) = { saaf_1_1_1[0], sab_1_1[], sab_1_2[], sabf_2_1_2[0] };
// vol_1a_wire = newv; Compound Volume(vol_1a_wire) = { tmpab_1_1[1], tmpab_1_2[1] };
// vol_1a_wire = newreg; Volume(vol_1a_wire) = sl_wire_exterior_surface_1a[];

// Physical Volume(physvol_1a_wire) = vol_1a_wire;
// Physical Surface(physsurf_1a_wire) = { saaf_1_1_1[0], sab_1_1[], sab_1_2[], sabf_2_1_2[0] };


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/////// Face 1b - half wire (y - z) extrude in x direction - Corner 1 to Corner 2
//
// Wire 1b1


p1b1_0 = newp; Point(p1b1_0) = {-p+p+spFac1,-p+p+spFac1,rW+meshLevel*mm, lcWireMesh * mm};                                  // centre circle
p1b1_1 = newp; Point(p1b1_1) = {-p+p+spFac1,-p+p+spFac1,0+meshLevel*mm, lcWireMesh * mm};                                   // bottom circle
p1b1_2 = newp; Point(p1b1_2) = {-p+p+spFac1,-p+p+spFac1+rW,rW+meshLevel*mm, lcWireMesh * mm};                               // right circle
p1b1_3 = newp; Point(p1b1_3) = {-p+p+spFac1,-p+p+spFac1,2*rW+meshLevel*mm, lcWireMesh * mm};                                // top circle
// p1b1_4 = newp; Point(p1b1_4) = {-p+p+spFac1,-p+p+spFac1-rW,rW+meshLevel*mm, lcWireMesh * mm};                            // left circle

l1b1_1 = newc; Circle(l1b1_1) = {p1b1_1, p1b1_0, p1b1_2};
l1b1_2 = newc; Circle(l1b1_2) = {p1b1_2, p1b1_0, p1b1_3};
l1b1s_3 = newl; Line(l1b1s_3) = {p1b1_1, p1b1_3};

ll1b1_1 = newll; Line Loop(ll1b1_1) = {l1b1_1, l1b1_2, -l1b1s_3};

s1b1_1 = news; Plane Surface(s1b1_1) = {ll1b1_1};

tmpba_1_1[] = {s1b1_1};

sbaf_1_1_1[] = {};
sbaf_1_1_1[] = tmpba_1_1[0];


// ptsbb_1_1 = newp; Point(ptsbb_1_1) = { -p+p +1.00*spFac1, -p+p +1.00*spFac1, -Rtn+rW +meshLevel*mm };

tmpbb_1_1[] = Extrude {{x2SPWindFac2,0,0}, {0,1,0}, { -p+p +1.00*spFac1, -p+p +1.00*spFac1, -Rtn+rW +meshLevel*mm }, 1.00*alpha } {
  Surface{tmpba_1_1[0]};
};

sbb_1_1[] = {};
sbb_1_1[] += tmpbb_1_1[{2:4}];


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Wire 1b2


// ptsbb_1_2 = newp; Point(ptsbb_1_2) = { p+p +1.00*spFac1, -p+p +1.00*spFac1, Rtp-rW +meshLevel*mm };

tmpbb_1_2[] = Extrude {{x2SPWindFac2,0,0}, {0,-1,0}, { p+p +1.00*spFac1, -p+p +1.00*spFac1, Rtp-rW +meshLevel*mm }, 1.00*alpha} {
  Surface{tmpbb_1_1[0]};
}; 

sbb_1_2[] = {};
sbb_1_2[] += tmpbb_1_2[{2:4}];

sbbf_2_1_2[] = {};
sbbf_2_1_2[] = {tmpbb_1_2[0]};

// sl_wire_exterior_surface_1b[] = newreg; Surface Loop(sl_wire_exterior_surface_1b) = { sbaf_1_1_1[0], sbb_1_1[], sbb_1_2[], sbbf_2_1_2[0] };
// vol_1b_wire = newreg; Compound Volume(vol_1b_wire) = { tmpbb_1_1[1], tmpbb_1_2[1] };
// vol_1b_wire = newreg; Volume(vol_1b_wire) = sl_wire_exterior_surface_1b[];

// Physical Volume(physvol_1b_wire) = vol_1b_wire;
// Physical Surface(physsurf_1b_wire) = { sbaf_1_1_1[0], sbb_1_1[], sbb_1_2[], sbbf_2_1_2[0] };


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/////// Face 2a - half wire (x - z) extrude in y direction - Corner 3 to Corner 2
//
// Wire 2a1


p2a1_0 = newp; Point(p2a1_0) = {p+p+spFac2,p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                                   // centre circle
p2a1_1 = newp; Point(p2a1_1) = {p+p+spFac2,p+p+spFac2,-2*rW+meshLevel*mm, lcWireMesh * mm};                                 // bottom circle
// p2a1_2 = newp; Point(p2a1_2) = {p+p+spFac2+rW,p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                             // right circle
p2a1_3 = newp; Point(p2a1_3) = {p+p+spFac2,p+p+spFac2,0+meshLevel*mm, lcWireMesh * mm};                                     // top circle
p2a1_4 = newp; Point(p2a1_4) = {p+p+spFac2-rW,p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                                // left circle

l2a1s_1 = newl; Line(l2a1s_1) = {p2a1_1, p2a1_3};
l2a1_2 = newc; Circle(l2a1_2) = {p2a1_3, p2a1_0, p2a1_4};
l2a1_3 = newc; Circle(l2a1_3) = {p2a1_4, p2a1_0, p2a1_1};

ll2a1_1 = newll; Line Loop(ll2a1_1) = {l2a1_2, l2a1_3, l2a1s_1};

s2a1_1 = news; Plane Surface(s2a1_1) = {ll2a1_1};

tmpaa_2_1[] = {s2a1_1};

saaf_2_2_1[] = {};
saaf_2_2_1[] = tmpaa_2_1[0];


// ptsab_2_1 = newp; Point(ptsab_2_1) = { p+p +1.00*spFac2, p+p +1.00*spFac2, Rtp-rW +meshLevel*mm };

tmpab_2_1[] = Extrude {{y1SPWindFac2,0,0}, {-1,0,0}, { p+p +1.00*spFac2, p+p +1.00*spFac2, Rtp-rW +meshLevel*mm }, 1.00*alpha } {
  Surface{tmpaa_2_1[0]};
};

sab_2_1[] = {};
sab_2_1[] += tmpab_2_1[{2:4}];


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Wire 2a2


// ptsab_2_2 = newp; Point(ptsab_2_2) = { p+p +1.00*spFac2, -p+p +1.00*spFac2, -Rtn+rW +meshLevel*mm };

tmpab_2_2[] = Extrude {{y1SPWindFac2,0,0}, {1,0,0}, { p+p +1.00*spFac2, -p+p +1.00*spFac2, -Rtn+rW +meshLevel*mm }, 1.00*alpha} {
  Surface{tmpab_2_1[0]};
};

sab_2_2[] = {};
sab_2_2[] += tmpab_2_2[{2:4}];


sabf_2_2_2[] = {};
sabf_2_2_2[] = {tmpab_2_2[0]};


// sl_wire_exterior_surface_2a[] = newreg; Surface Loop(sl_wire_exterior_surface_2a) = { saaf_2_2_1[0], sab_2_1[], sab_2_2[], sabf_2_2_2[0] };
// vol_2a_wire1 = newreg; Volume(vol_2a_wire1) = { tmpab_2_1[1] };
// vol_2a_wire2 = newreg; Volume(vol_2a_wire2) = { tmpab_2_2[1] };
// vol_2a_wire = newreg; Volume(vol_2a_wire) = sl_wire_exterior_surface_2a[];

// Physical Volume(physvol_2a_wire) = vol_2a_wire;
// physvol_2a_wire1 = newreg; Physical Volume(physvol_2a_wire1) = vol_2a_wire1;
// physvol_2a_wire2 = newreg; Physical Volume(physvol_2a_wire2) = vol_2a_wire2;
// Physical Surface(physsurf_2a_wire) = { saaf_2_2_1[0], sab_2_1[], sab_2_2[], sabf_2_2_2[0] };


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/////// Face 2b - half wire (x - z) extrude in y direction - Corner 1 to Corner 4
//
// Wire 2b1


p2b1_0 = newp; Point(p2b1_0) = {-p+p+spFac2,-p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                                 // centre circle
p2b1_1 = newp; Point(p2b1_1) = {-p+p+spFac2,-p+p+spFac2,-2*rW+meshLevel*mm, lcWireMesh * mm};                               // bottom circle
p2b1_2 = newp; Point(p2b1_2) = {-p+p+spFac2+rW,-p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                              // right circle
p2b1_3 = newp; Point(p2b1_3) = {-p+p+spFac2,-p+p+spFac2,0+meshLevel*mm, lcWireMesh * mm};                                   // top circle
// p2b1_4 = newp; Point(p2b1_4) = {-p+p+spFac2-rW,-p+p+spFac2,-rW+meshLevel*mm, lcWireMesh * mm};                           // left circle

l2b1_1 = newc; Circle(l2b1_1) = {p2b1_1, p2b1_0, p2b1_2};
l2b1_2 = newc; Circle(l2b1_2) = {p2b1_2, p2b1_0, p2b1_3};
l2b1s_3 = newl; Line(l2b1s_3) = {p2b1_1, p2b1_3};

ll2b1_1 = newll; Line Loop(ll2b1_1) = {l2b1_1, l2b1_2, -l2b1s_3};

s2b1_1 = news; Plane Surface(s2b1_1) = {ll2b1_1};

tmpba_2_1[] = {s2b1_1};

sbaf_2_2_1[] = {};
sbaf_2_2_1[] = tmpba_2_1[0];


// ptsab_2_1 = newp; Point(ptsab_2_1) = { -p+p +1.00*spFac2, -p+p +1.00*spFac2, Rtp-rW +meshLevel*mm };

tmpbb_2_1[] = Extrude {{y2SPWindFac2,0,0}, {1,0,0}, { -p+p +1.00*spFac2, -p+p +1.00*spFac2, Rtp-rW +meshLevel*mm }, 1.00*alpha } {
  Surface{tmpba_2_1[0]};
};

sbb_2_1[] = {};
sbb_2_1[] += tmpbb_2_1[{2:4}];


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Wire 2b2


// ptsab_2_2 = newp; Point(ptsab_2_2) = { -p+p +1.00*spFac2, p+p +1.00*spFac2, -Rtn+rW +meshLevel*mm };

tmpbb_2_2[] = Extrude {{y2SPWindFac2,0,0}, {-1,0,0}, { -p+p +1.00*spFac2, p+p +1.00*spFac2, -Rtn+rW +meshLevel*mm }, 1.00*alpha} {
  Surface{tmpbb_2_1[0]};
};

sbb_2_2[] = {};
sbb_2_2[] += tmpbb_2_2[{2:4}];


sbbf_2_2_2[] = {};
sbbf_2_2_2[] = {tmpbb_2_2[0]};


// sl_wire_exterior_surface_2b[] = newreg; Surface Loop(sl_wire_exterior_surface_2b) = { sbaf_2_2_1[0], sbb_2_1[], sbb_2_2[], sbbf_2_2_2[0] };
// vol_2b_wire1 = newreg; Volume(vol_2b_wire1) = { tmpbb_2_1[1] };
// vol_2b_wire2 = newreg; Volume(vol_2b_wire2) = { tmpbb_2_2[1] };
// vol_2b_wire = newreg; Volume(vol_2b_wire) = sl_wire_exterior_surface_2b[];

// Physical Volume(physvol_2b_wire) = vol_2b_wire;
// physvol_2b_wire1 = newreg; Physical Volume(physvol_2b_wire1) = vol_2b_wire1;
// physvol_2b_wire2 = newreg; Physical Volume(physvol_2b_wire2) = vol_2b_wire2;
// Physical Surface(physsurf_2b_wire) = { sbaf_2_2_1[0], sbb_2_1[], sbb_2_2[], sbbf_2_2_2[0] };


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// MMGASSTRWIRE LINE DEFINITION MODULE
//


For q In {1:2}
  For r In {1:2}
    For s In {1:2}

    //----------------------------------------------------------
    // Face physsurf_bdh_1_1 (Corner 1 - Corner 2)

      If(q == 1&& r == 1) 

      ll_bdhbt~{q}~{r}~{s}[] = {};
      ll_bdhbb~{q}~{r}~{s}[] = {};

      pbdhbt~{q}~{r}~{s}() = {};
      pbdhbb~{q}~{r}~{s}() = {};

      ll_bdhb~{q}~{r}~{s}[] = {};

        ll_bdhb~{q}~{r}~{s}[] += Boundary{ Surface{sbb~{r}~{s}[2]}; };

      For t In {0:3}

        If(t == 0 && s == 2)
          ll_bdhbc0~{q}~{r}~{s}[] = {};
          pbdhbc0~{q}~{r}~{s}() = {};
          ll_bdhbc~{q}~{r}~{s}[] = {};

          ll_bdhbc~{q}~{r}~{s}[] += Boundary{ Surface{tmpbb~{r}~{s}[t]}; };
          ll_bdhbc0~{q}~{r}~{s}[] = Abs(ll_bdhbc~{q}~{r}~{s}[t]);
          pbdhbc0~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhbc~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1)
          ll_bdhbb~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhbb~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf  

        If(t == 1 && s == 2)
          ll_bdhbc1~{q}~{r}~{s}[] = {};
          pbdhbc1~{q}~{r}~{s}() = {};

          ll_bdhbc1~{q}~{r}~{s}[] = Abs(ll_bdhbc~{q}~{r}~{s}[t]);
          pbdhbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhbc~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 2 && s == 2)
          ll_bdhb1~{q}~{r}~{s}[] = {};
          pbdhb1~{q}~{r}~{s}() = {};

          ll_bdhb1~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhb1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 3)  
          ll_bdhbt~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhbt~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf

      EndFor

      EndIf

    //----------------------------------------------------------
    // Face physsurf_bdh_1_2 (Corner 2 - Corner 3)

      If(q == 1&& r == 2)

      ll_bdhat~{q}~{r}~{s}[] = {};
      ll_bdhab~{q}~{r}~{s}[] = {}; 

      pbdhat~{q}~{r}~{s}() = {};
      pbdhab~{q}~{r}~{s}() = {};

      ll_bdha~{q}~{r}~{s}[] = {};

        ll_bdha~{q}~{r}~{s}[] += Boundary{ Surface{sab~{r}~{s}[2]}; };

      For t In {0:3}

        If(t == 0 && s == 2)
          ll_bdhac0~{q}~{r}~{s}[] = {};
          pbdhac0~{q}~{r}~{s}() = {};
          ll_bdhac~{q}~{r}~{s}[] = {};

          ll_bdhac~{q}~{r}~{s}[] += Boundary{ Surface{tmpab~{r}~{s}[t]}; };
          ll_bdhac0~{q}~{r}~{s}[] = Abs(ll_bdhac~{q}~{r}~{s}[t]);
          pbdhac0~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhac~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1)
          ll_bdhab~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdhab~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1 && s == 2)
          ll_bdhac1~{q}~{r}~{s}[] = {};
          pbdhac1~{q}~{r}~{s}() = {};

          ll_bdhac1~{q}~{r}~{s}[] = Abs(ll_bdhac~{q}~{r}~{s}[t]);
          pbdhac1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhac~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 2 && s == 2)
          ll_bdha1~{q}~{r}~{s}[] = {}; 
          pbdha1~{q}~{r}~{s}() = {};

          ll_bdha1~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdha1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 3)
          ll_bdhat~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdhat~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

      EndFor

      EndIf

    //----------------------------------------------------------
    // Face physsurf_bdh_2_1 (Corner 3 - Corner 4)

      If(q == 2&& r == 1)

      ll_bdhat~{q}~{r}~{s}[] = {};
      ll_bdhab~{q}~{r}~{s}[] = {}; 

      pbdhat~{q}~{r}~{s}() = {};
      pbdhab~{q}~{r}~{s}() = {};

      ll_bdha~{q}~{r}~{s}[] = {};

        ll_bdha~{q}~{r}~{s}[] += Boundary{ Surface{sab~{r}~{s}[2]}; };

      For t In {0:3}

        If(t == 0 && s == 2)
          ll_bdhac0~{q}~{r}~{s}[] = {};
          pbdhac0~{q}~{r}~{s}() = {};
          ll_bdhac~{q}~{r}~{s}[] = {};

          ll_bdhac~{q}~{r}~{s}[] += Boundary{ Surface{tmpab~{r}~{s}[t]}; };
          ll_bdhac0~{q}~{r}~{s}[] = Abs(ll_bdhac~{q}~{r}~{s}[t]);
          pbdhac0~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhac~{q}~{r}~{s}[t])}; };
        EndIf
      
        If(t == 3)
          ll_bdhab~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdhab~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 2 && s == 2)
          ll_bdha1~{q}~{r}~{s}[] = {};
          pbdha1~{q}~{r}~{s}() = {};

          ll_bdha1~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdha1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1)
          ll_bdhat~{q}~{r}~{s}[] = Abs(ll_bdha~{q}~{r}~{s}[t]);
          pbdhat~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdha~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1 && s == 2)
          ll_bdhac1~{q}~{r}~{s}[] = {};
          pbdhac1~{q}~{r}~{s}() = {};

          ll_bdhac1~{q}~{r}~{s}[] = Abs(ll_bdhac~{q}~{r}~{s}[t]);
          pbdhac1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhac~{q}~{r}~{s}[t])}; };
        EndIf

      EndFor

      EndIf

    //----------------------------------------------------------
    // Face physsurf_bdh_2_2 (Corner 4 - Corner 1)

      If(q == 2&& r == 2) 

      ll_bdhbt~{q}~{r}~{s}[] = {};
      ll_bdhbb~{q}~{r}~{s}[] = {};
      pbdhbt~{q}~{r}~{s}() = {};
      pbdhbb~{q}~{r}~{s}() = {};

      ll_bdhb~{q}~{r}~{s}[] = {};

        ll_bdhb~{q}~{r}~{s}[] += Boundary{ Surface{sbb~{r}~{s}[2]}; };

      For t In {0:3}
    
        If(t == 0 && s == 2)
          ll_bdhbc0~{q}~{r}~{s}[] = {};
          pbdhbc0~{q}~{r}~{s}() = {};
          ll_bdhbc~{q}~{r}~{s}[] = {};

          ll_bdhbc~{q}~{r}~{s}[] += Boundary{ Surface{tmpbb~{r}~{s}[t]}; };
          ll_bdhbc0~{q}~{r}~{s}[] = Abs(ll_bdhbc~{q}~{r}~{s}[t]);
          pbdhbc0~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhbc~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 3)
          ll_bdhbb~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhbb~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 2 && s == 2)
          ll_bdhb1~{q}~{r}~{s}[] = {};
          pbdhb1~{q}~{r}~{s}() = {};

          ll_bdhb1~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhb1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1)  
          ll_bdhbt~{q}~{r}~{s}[] = Abs(ll_bdhb~{q}~{r}~{s}[t]);
          pbdhbt~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhb~{q}~{r}~{s}[t])}; };
        EndIf

        If(t == 1 && s == 2)  
          ll_bdhbc1~{q}~{r}~{s}[] = {};
          pbdhbc1~{q}~{r}~{s}() = {};

          ll_bdhbc1~{q}~{r}~{s}[] = Abs(ll_bdhbc~{q}~{r}~{s}[t]);
          pbdhbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_bdhbc~{q}~{r}~{s}[t])}; };
        EndIf

      EndFor

      EndIf

    EndFor
  EndFor
EndFor


/*
For q In {2:2}
  For r In {1:2}
    For s In {2:2}

    // -------------------------------
    //
    // End faces - sabf_2_1_2, sabf_2_2_2, sbbf_2_1_2, sbbf_2_2_2
    //
    // -------------------------------

      If(q == 2 && s == 2) 

      ll_facesabb~{q}~{r}~{s}[] = {};

        ll_facesabb~{q}~{r}~{s}[] += Boundary{ Surface{sabf~{q}~{r}~{s}[]}; };

        ptsabfmin~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[0])}; };
        psabfminchz~{q}~{r}~{s}[] = Point{ ptsabfmin~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptsabfmin~{q}~{r}~{s}[w] };

        If( pfacesabbc1chz~{q}~{r}~{s}[2] < psabfminchz~{q}~{r}~{s}[2] )

          psabfminz[] = pfacesabbc1chz~{q}~{r}~{s}[2];
          ptsabfminz~{q}~{r}~{s}() = ptsabfmin~{q}~{r}~{s}[w];

        Else

          psabfminz[]  = psabfminchz~{q}~{r}~{s}[2];
          ptsabfminz~{q}~{r}~{s}() = ptsabfmin~{q}~{r}~{s}[0];

        EndIf

      EndFor


      For t In {1:2}

        ptfacesabbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptfacesabbc1~{q}~{r}~{s}[l] };

          If( pfacesabbc1chz~{q}~{r}~{s}[2] < psabfminchz~{q}~{r}~{s}[2] )

            psabfminz[]  = pfacesabbc1chz~{q}~{r}~{s}[2];
            ptsabfminz~{q}~{r}~{s}() = ptfacesabbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesabb~{q}~{r}~{s}[] = {};

        ll_facesabb~{q}~{r}~{s}[] += Boundary{ Surface{sabf~{q}~{r}~{s}[]}; };

        ptsabfmin~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[0])}; };
        psabfminchz~{q}~{r}~{s}[] = Point{ ptsabfmin~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptsabfmin~{q}~{r}~{s}[w] };

        If( pfacesabbc1chz~{q}~{r}~{s}[2] < psabfminchz~{q}~{r}~{s}[2] )

          psabfminz[]  = pfacesabbc1chz~{q}~{r}~{s}[2];
          ptsabfminz~{q}~{r}~{s}() = ptsabfmin~{q}~{r}~{s}[w];

        Else

          psabfminz[]  = psabfminchz~{q}~{r}~{s}[2];
          ptsabfminz~{q}~{r}~{s}() = ptsabfmin~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesabbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptfacesabbc1~{q}~{r}~{s}[l] };
    
          If( pfacesabbc1chz~{q}~{r}~{s}[2] < psabfminchz~{q}~{r}~{s}[2] )

            psabfminz[]  = pfacesabbc1chz~{q}~{r}~{s}[2];
            ptsabfminz~{q}~{r}~{s}() = ptfacesabbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesabb~{q}~{r}~{s}[] = {};

        ll_facesabb~{q}~{r}~{s}[] += Boundary{ Surface{sabf~{q}~{r}~{s}[]}; };

        ptsabfmax~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[0])}; };
        psabfmaxchz~{q}~{r}~{s}[] = Point{ ptsabfmax~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptsabfmax~{q}~{r}~{s}[w] };

        If( pfacesabbc1chz~{q}~{r}~{s}[2] > psabfmaxchz~{q}~{r}~{s}[2] )

          psabfmaxz~{q}~{r}~{s}[] = pfacesabbc1chz~{q}~{r}~{s}[2];
          ptsabfmaxz~{q}~{r}~{s}() = ptsabfmax~{q}~{r}~{s}[w];

        Else

          psabfmaxz~{q}~{r}~{s}[] = psabfmaxchz~{q}~{r}~{s}[2];
          ptsabfmaxz~{q}~{r}~{s}() = ptsabfmax~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesabbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptfacesabbc1~{q}~{r}~{s}[l] };
    
          If( pfacesabbc1chz~{q}~{r}~{s}[2] > psabfmaxchz~{q}~{r}~{s}[2] )

            psabfmaxz~{q}~{r}~{s}[] = pfacesabbc1chz~{q}~{r}~{s}[2];
            ptsabfmaxz~{q}~{r}~{s}() = ptfacesabbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesabb~{q}~{r}~{s}[] = {};

        ll_facesabb~{q}~{r}~{s}[] += Boundary{ Surface{sabf~{q}~{r}~{s}[]}; };

        ptsabfmax~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[0])}; };
        psabfmaxchz~{q}~{r}~{s}[] = Point{ ptsabfmax~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptsabfmax~{q}~{r}~{s}[w] };

        If( pfacesabbc1chz~{q}~{r}~{s}[2] > psabfmaxchz~{q}~{r}~{s}[2] )

          psabfmaxz~{q}~{r}~{s}[] = pfacesabbc1chz~{q}~{r}~{s}[2];
          ptsabfmaxz~{q}~{r}~{s}() = ptsabfmax~{q}~{r}~{s}[w];

        Else

          psabfmaxz~{q}~{r}~{s}[] = psabfmaxchz~{q}~{r}~{s}[2];
          ptsabfmaxz~{q}~{r}~{s}() = ptsabfmax~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesabbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesabb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesabbc1chz~{q}~{r}~{s}[] = Point{ ptfacesabbc1~{q}~{r}~{s}[l] };
    
          If( pfacesabbc1chz~{q}~{r}~{s}[2] > psabfmaxchz~{q}~{r}~{s}[2] )

            psabfmaxz~{q}~{r}~{s}[] = pfacesabbc1chz~{q}~{r}~{s}[2];
            ptsabfmaxz~{q}~{r}~{s}() = ptfacesabbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// CHANGE OVER - HALFWAY
//


      ll_facesbbb~{q}~{r}~{s}[] = {};

        ll_facesbbb~{q}~{r}~{s}[] += Boundary{ Surface{sbbf~{q}~{r}~{s}[]}; };

        ptsbbfmin~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[0])}; };
        psbbfminchz~{q}~{r}~{s}[] = Point{ ptsbbfmin~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptsbbfmin~{q}~{r}~{s}[w] };

        If( pfacesbbbc1chz~{q}~{r}~{s}[2] < psbbfminchz~{q}~{r}~{s}[2] )

          psbbfminz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
          ptsbbfminz~{q}~{r}~{s}() = ptsbbfmin~{q}~{r}~{s}[w];

        Else

          psbbfminz~{q}~{r}~{s}[] = psbbfminchz~{q}~{r}~{s}[2];
          ptsbbfminz~{q}~{r}~{s}() = ptsbbfmin~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesbbbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptfacesbbbc1~{q}~{r}~{s}[l] };
    
          If( pfacesbbbc1chz~{q}~{r}~{s}[2] < psbbfminchz~{q}~{r}~{s}[2] )

            psbbfminz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
            ptsbbfminz~{q}~{r}~{s}() = ptfacesbbbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesbbb~{q}~{r}~{s}[] = {};

        ll_facesbbb~{q}~{r}~{s}[] += Boundary{ Surface{sbbf~{q}~{r}~{s}[]}; };

        ptsbbfmin~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[0])}; };
        psbbfminchz~{q}~{r}~{s}[] = Point{ ptsbbfmin~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptsbbfmin~{q}~{r}~{s}[w] };

        If( pfacesbbbc1chz~{q}~{r}~{s}[2] < psbbfminchz~{q}~{r}~{s}[2] )

          psbbfminz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
          ptsbbfminz~{q}~{r}~{s}() = ptsbbfmin~{q}~{r}~{s}[w];

        Else

          psbbfminz~{q}~{r}~{s}[] = psbbfminchz~{q}~{r}~{s}[2];
          ptsbbfminz~{q}~{r}~{s}() = ptsbbfmin~{q}~{r}~{s}[0];

        EndIf

      EndFor

    
      For t In {1:2}

        ptfacesbbbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptfacesbbbc1~{q}~{r}~{s}[l] };
    
          If( pfacesbbbc1chz~{q}~{r}~{s}[2] < psbbfminchz~{q}~{r}~{s}[2] )

            psbbfminz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
            ptsbbfminz~{q}~{r}~{s}() = ptfacesbbbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesbbb~{q}~{r}~{s}[] = {};

        ll_facesbbb~{q}~{r}~{s}[] += Boundary{ Surface{sbbf~{q}~{r}~{s}[]}; };

        ptsbbfmax~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[0])}; };
        psbbfmaxchz~{q}~{r}~{s}[] = Point{ ptsbbfmax~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptsbbfmax~{q}~{r}~{s}[w] };

        If( pfacesbbbc1chz~{q}~{r}~{s}[2] > psbbfmaxchz~{q}~{r}~{s}[2] )

          psbbfmaxz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
          ptsbbfmaxz~{q}~{r}~{s}() = ptsbbfmax~{q}~{r}~{s}[w];

        Else

          psbbfmaxz~{q}~{r}~{s}[] = psbbfmaxchz~{q}~{r}~{s}[2];
          ptsbbfmaxz~{q}~{r}~{s}() = ptsbbfmax~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesbbbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptfacesbbbc1~{q}~{r}~{s}[l] };
    
          If( pfacesbbbc1chz~{q}~{r}~{s}[2] > psbbfmaxchz~{q}~{r}~{s}[2] )

            psbbfmaxz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
            ptsbbfmaxz~{q}~{r}~{s}() = ptfacesbbbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


      ll_facesbbb~{q}~{r}~{s}[] = {};

        ll_facesbbb~{q}~{r}~{s}[] += Boundary{ Surface{sbbf~{q}~{r}~{s}[]}; };

        ptsbbfmax~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[0])}; };
        psbbfmaxchz~{q}~{r}~{s}[] = Point{ ptsbbfmax~{q}~{r}~{s}[0] };

      For w In {1:1}

        pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptsbbfmax~{q}~{r}~{s}[w] };

        If( pfacesbbbc1chz~{q}~{r}~{s}[2] > psbbfmaxchz~{q}~{r}~{s}[2] )

          psbbfmaxz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
          ptsbbfmaxz~{q}~{r}~{s}() = ptsbbfmax~{q}~{r}~{s}[w];

        Else

          psbbfmaxz~{q}~{r}~{s}[] = psbbfmaxchz~{q}~{r}~{s}[2];
          ptsbbfmaxz~{q}~{r}~{s}() = ptsbbfmax~{q}~{r}~{s}[0];

        EndIf

      EndFor

      
      For t In {1:2}

        ptfacesbbbc1~{q}~{r}~{s}() = PointsOf{ Line{Abs(ll_facesbbb~{q}~{r}~{s}[t])}; };

        For l In {0:1}

          pfacesbbbc1chz~{q}~{r}~{s}[] = Point{ ptfacesbbbc1~{q}~{r}~{s}[l] };
    
          If( pfacesbbbc1chz~{q}~{r}~{s}[2] > psbbfmaxchz~{q}~{r}~{s}[2] )

            psbbfmaxz~{q}~{r}~{s}[] = pfacesbbbc1chz~{q}~{r}~{s}[2];
            ptsbbfmaxz~{q}~{r}~{s}() = ptfacesbbbc1~{q}~{r}~{s}[l];

          EndIf

        EndFor

      EndFor


    EndFor
  EndFor
EndFor
*/


//------------------------------------------------------------------------------------------
/// BOUNDING SURFACE EDGES


//----------------------------------------------------------
// Bounding and intersecting surfaces


//----------------------------------------------------------
// Face physsurfBdh_1_1 (Corner 1 - Corner 2)

l1bdh_1_1_bsurft1 = newl; Line(l1bdh_1_1_bsurft1) = {pexet2, pbdhab_1_2_2[1]};                     // top line
l2bdh_1_1_bsurft1 = newl; Line(l2bdh_1_1_bsurft1) = {pexet1, p1b1_3};                              // top circle
l1bdh_1_1_bsurfb1 = newl; Line(l1bdh_1_1_bsurfb1) = {ptl4c2, pbdhbb_1_1_2[1]};                     // bottom line
l2bdh_1_1_bsurfb1 = newl; Line(l2bdh_1_1_bsurfb1) = {ptl4c1, p2b1_1};                              // bottom circle


llbdh_1_1_bsurf1t = newreg; Line Loop(llbdh_1_1_bsurf1t) = { lexet1, l1bdh_1_1_bsurft1, ll_bdhac0_1_2_2[0], ll_bdhac1_1_2_2[0], -ll_bdhbt_1_1_1[0], -ll_bdhbt_1_1_2[0], -l2bdh_1_1_bsurft1 };
llbdh_1_1_bsurf1b = newreg; Line Loop(llbdh_1_1_bsurf1b) = { lcptub1a, l1bdh_1_1_bsurfb1, -ll_bdhbb_1_1_1[0], -ll_bdhbb_1_1_2[0], -l2b1_1, -l2b1_2, -l2bdh_1_1_bsurfb1 };

psbdh_1_1_bsurf1t = newreg; Plane Surface(psbdh_1_1_bsurf1t) = { llbdh_1_1_bsurf1t };
psbdh_1_1_bsurf1b = newreg; Plane Surface(psbdh_1_1_bsurf1b) = { llbdh_1_1_bsurf1b };


//----------------------------------------------------------
// Face physsurfBdh_1_2 (Corner 2 - Corner 3)

l1bdh_1_2_bsurft1 = newl; Line(l1bdh_1_2_bsurft1) = {pexet3, p1a1_3};                              // top line
l1bdh_1_2_bsurfb1 = newl; Line(l1bdh_1_2_bsurfb1) = {ptl4c3, p2a1_1};                              // bottom line
// l1bdh_1_1_bsurfb1b = newl; Line(l1bdh_1_1_bsurfb1b) = {ptl2c2, pbdhab_1_2_2[1]};                // bottom line


llbdh_1_2_bsurf3t = newreg; Line Loop(llbdh_1_2_bsurf3t) = { lexet2, l1bdh_1_2_bsurft1, l1a1_2, l1a1_3, ll_bdhab_1_2_2[0], ll_bdhab_1_2_1[0], -l1bdh_1_1_bsurft1 };
llbdh_1_2_bsurf3b = newreg; Line Loop(llbdh_1_2_bsurf3b) = { lcptub2a, l1bdh_1_2_bsurfb1, ll_bdhat_1_2_2[0], ll_bdhat_1_2_1[0], -ll_bdhbc0_1_1_2[0], -ll_bdhbc1_1_1_2[0], -l1bdh_1_1_bsurfb1 };

psbdh_1_2_bsurf3t = newreg; Plane Surface(psbdh_1_2_bsurf3t) = { llbdh_1_2_bsurf3t };
psbdh_1_2_bsurf3b = newreg; Plane Surface(psbdh_1_2_bsurf3b) = { llbdh_1_2_bsurf3b };


//----------------------------------------------------------
// Face physsurfBdh_2_1 (Corner 3 - Corner 4)

l1bdh_2_1_bsurft4 = newl; Line(l1bdh_2_1_bsurft4) = {pexet4, pbdhbb_2_2_2[1]};                     // top line, top circle
l1bdh_2_1_bsurfb4 = newl; Line(l1bdh_2_1_bsurfb4) = {ptl4c4, pbdhab_2_1_2[1]};                     // bottom line, bottom circle

llbdh_2_1_bsurf4t = newreg; Line Loop(llbdh_2_1_bsurf4t) = { lexet3, l1bdh_2_1_bsurft4, -ll_bdhbc1_2_2_2[0], -ll_bdhbc0_2_2_2[0], -ll_bdhat_2_1_1[0], -ll_bdhat_2_1_2[0], -l1bdh_1_2_bsurft1 };
llbdh_2_1_bsurf4b = newreg; Line Loop(llbdh_2_1_bsurf4b) = { lcptub3a, l1bdh_2_1_bsurfb4, -ll_bdhab_2_1_1[0], -ll_bdhab_2_1_2[0], l2a1_2, l2a1_3, -l1bdh_1_2_bsurfb1 };

psbdh_2_1_bsurf4t = newreg; Plane Surface(psbdh_2_1_bsurf4t) = { llbdh_2_1_bsurf4t };
psbdh_2_1_bsurf4b = newreg; Plane Surface(psbdh_2_1_bsurf4b) = { llbdh_2_1_bsurf4b };


//----------------------------------------------------------
// Face physsurfBdh_2_2 (Corner 4 - Corner 1)

llbdh_2_2_bsurf6t = newreg; Line Loop(llbdh_2_2_bsurf6t) = { lexet4, l2bdh_1_1_bsurft1, -l1b1_2, -l1b1_1, ll_bdhbb_2_2_2[0], ll_bdhbb_2_2_1[0], -l1bdh_2_1_bsurft4 };
llbdh_2_2_bsurf6b = newreg; Line Loop(llbdh_2_2_bsurf6b) = { lcptub4a, l2bdh_1_1_bsurfb1, ll_bdhbt_2_2_1[0], ll_bdhbt_2_2_2[0], ll_bdhac0_2_1_2[0], ll_bdhac1_2_1_2[0], -l1bdh_2_1_bsurfb4 };

psbdh_2_2_bsurf6t = newreg; Plane Surface(psbdh_2_2_bsurf6t) = { llbdh_2_2_bsurf6t };
psbdh_2_2_bsurf6b = newreg; Plane Surface(psbdh_2_2_bsurf6b) = { llbdh_2_2_bsurf6b };


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//// FINAL DEFINITIONS (SURFACES / VOLUMES)


//------------------------------------------------------------------------------------------
/// SURFACE LOOPS

//----------------------------------------------------------
// Wire Gas Exterior Surface Loop - exterior wire gas surface loop

sl_wire_gas_total_surface = newreg; Surface Loop(sl_wire_gas_total_surface) = { psBsurfT, psbdh_1_1_bsurf1t, psbdh_1_1_bsurf1b, psbdh_1_2_bsurf3t, psbdh_1_2_bsurf3b, psbdh_2_1_bsurf4t, psbdh_2_1_bsurf4b, psbdh_2_2_bsurf6t, psbdh_2_2_bsurf6b, -surfTopCp2[], -sab_1_1[0], -sab_1_1[1], -sab_1_2[0], -sab_1_2[1], -sbb_1_1[0], -sbb_1_1[1], -sbb_1_2[0], -sbb_1_2[1], -sab_2_1[0], -sab_2_1[1], -sab_2_2[0], -sab_2_2[1], -sbb_2_1[0], -sbb_2_1[1], -sbb_2_2[0], -sbb_2_2[1] };
total_sl_wire_gas_total_surface[] += sl_wire_gas_total_surface;

//----------------------------------------------------------
// Gas Exterior Surface Loop - exterior gas surface loop

total_sl_gas_exterior_surface[0] = newreg; Surface Loop(total_sl_gas_exterior_surface[0]) = { surfBottomCp1[], pscpLowBorder1, pscpLowBorder2, pscpLowBorder3, pscpLowBorder4, psSideDielectric1a, psSideDielectric2a, psSideDielectric3a, psSideDielectric4a, pscpUpBorder1, pscpUpBorder2, pscpUpBorder3, pscpUpBorder4, psbdh_1_1_bsurf1t, sbaf_2_2_1[0], sbb_1_1[2], sbb_1_2[2], sabf_2_2_2[0], psbdh_1_1_bsurf1b, psbdh_1_2_bsurf3t, saaf_1_1_1[0], sab_2_1[2], sab_2_2[2], sbbf_2_1_2[0], psbdh_1_2_bsurf3b, psbdh_2_1_bsurf4t, saaf_2_2_1[0], sab_1_1[2], sab_1_2[2], sbbf_2_2_2[0], psbdh_2_1_bsurf4b, psbdh_2_2_bsurf6t, sbaf_1_1_1[0], sbb_2_1[2], sbb_2_2[2], sabf_2_1_2[0], psbdh_2_2_bsurf6b, psBsurfT };

//----------------------------------------------------------
// Dielectric Surface Loop - dielectric surface loop

sl_dielectric = newreg; Surface Loop(sl_dielectric) = { surfTopCp1[], psSideDielectric1a, psSideDielectric2a, psSideDielectric3a, psSideDielectric4a, surfBottomCp2[] };
total_sl_dielectric[] += sl_dielectric;

//----------------------------------------------------------
// Wire Volume Surface Loop - wire electrode

// sl_wire = newreg; Surface Loop(sl_wire) = { saaf_1_1_1[0], sab_1_1[], sab_1_2[], sabf_2_1_2[0], sbaf_1_1_1[0], sbb_1_1[], sbb_1_2[], sbbf_2_1_2[0], saaf_2_2_1[], sab_2_1[], sab_2_2[], sabf_2_2_2[], sbaf_2_2_1[0], sbb_2_1[], sbb_2_2[], sbbf_2_2_2[0] };
// vol_wire = newreg; Volume(vol_wire) = {sl_wire};

//----------------------------------------------------------
// Electrode Surface Loop - electrode surface loop

sl_lower_cp = newreg; Surface Loop(sl_lower_cp) = { surfBottomCp1[], pscpLowBorder1, pscpLowBorder2, pscpLowBorder3, pscpLowBorder4, surfTopCp1[] };
total_sl_lower_cp[] += sl_lower_cp;

sl_high_cp = newreg; Surface Loop(sl_high_cp) = { surfBottomCp2[], pscpUpBorder1, pscpUpBorder2, pscpUpBorder3, pscpUpBorder4, surfTopCp2[] };
total_sl_high_cp[] += sl_high_cp;


//------------------------------------------------------------------------------------------
/// CONTAINER VOLUME

vol_container = newreg; Volume(vol_container) = { total_sl_gas_exterior_surface[0] };

//------------------------------------------------------------------------------------------
/// WIRE VOLUME

// total_vol_wire = newreg; Compound Volume(total_vol_wire) = { vol_x1_wire, vol_x2_wire, vol_y1_wire, vol_y2_wire };
// total_vol_wire = newreg; Volume(total_vol_wire) = { total_sl_wire_gas_interior_surface[] };

//------------------------------------------------------------------------------------------
/// GAS VOLUME

vol_gas = newreg; Volume(vol_gas) = { total_sl_wire_gas_total_surface[] }; //  sl_wire_exterior_surface_1a[], sl_wire_exterior_surface_1b[], sl_wire_exterior_surface_2a[], sl_wire_exterior_surface_2b[]
// vol_gas = newreg; Volume(vol_gas) = { total_sl_wire_gas_total_surface[] }; // total_sl_gas_exterior_surface[0]


//------------------------------------------------------------------------------------------
/// COMPONENT VOLUMES

vol_dielectric = newreg; Volume(vol_dielectric) = total_sl_dielectric[];
vol_lower_cp = newreg; Volume(vol_lower_cp) = total_sl_lower_cp[];
vol_high_cp = newreg; Volume(vol_high_cp) = total_sl_high_cp[];


//------------------------------------------------------------------------------------------
/// PHYSICAL SURFACES

//----------------------------------------------------------
// Physical Surfaces - periodic boundary conditions

physsurf_bdh_1_1 = newreg; Physical Surface(physsurf_bdh_1_1) = { psbdh_1_1_bsurf1t, sbaf_2_2_1[0], sbb_1_1[2], sbb_1_2[2], sabf_2_2_2[0], psbdh_1_1_bsurf1b };               
physsurf_bdh_1_2 = newreg; Physical Surface(physsurf_bdh_1_2) = { psbdh_1_2_bsurf3t, saaf_1_1_1[0], sab_2_1[2], sab_2_2[2], sbbf_2_1_2[0], psbdh_1_2_bsurf3b };               
physsurf_bdh_2_1 = newreg; Physical Surface(physsurf_bdh_2_1) = { psbdh_2_1_bsurf4t, saaf_2_2_1[0], sab_1_1[2], sab_1_2[2], sbbf_2_2_2[0], psbdh_2_1_bsurf4b };               
physsurf_bdh_2_2 = newreg; Physical Surface(physsurf_bdh_2_2) = { psbdh_2_2_bsurf6t, sbaf_1_1_1[0], sbb_2_1[2], sbb_2_2[2], sabf_2_1_2[0], psbdh_2_2_bsurf6b };               

//----------------------------------------------------------
// Physical surfaces - container surface

physsurf_container = newreg; Physical Surface(physsurf_container) = { surfBottomCp1[], pscpLowBorder1, pscpLowBorder2, pscpLowBorder3, pscpLowBorder4, psSideDielectric1a, psSideDielectric2a, psSideDielectric3a, psSideDielectric4a, pscpUpBorder1, pscpUpBorder2, pscpUpBorder3, pscpUpBorder4, psbdh_1_1_bsurf1t, sbaf_2_2_1[0], sbb_1_1[2], sbb_1_2[2], sabf_2_2_2[0], psbdh_1_1_bsurf1b, psbdh_1_2_bsurf3t, saaf_1_1_1[0], sab_2_1[2], sab_2_2[2], sbbf_2_1_2[0], psbdh_1_2_bsurf3b, psbdh_2_1_bsurf4t, saaf_2_2_1[0], sab_1_1[2], sab_1_2[2], sbbf_2_2_2[0], psbdh_2_1_bsurf4b, psbdh_2_2_bsurf6t, sbaf_1_1_1[0], sbb_2_1[2], sbb_2_2[2], sabf_2_1_2[0], psbdh_2_2_bsurf6b, psBsurfT };

//----------------------------------------------------------
// Physical surfaces - wire surface

// physsurf_wire = newreg; Physical Surface(physsurf_wire) = { saaf_1_1_1[0], sab_1_1[], sab_1_2[], sabf_2_1_2[0], sbaf_1_1_1[0], sbb_1_1[], sbb_1_2[], sbbf_2_1_2[0], saaf_2_2_1[], sab_2_1[], sab_2_2[], sabf_2_2_2[], sbaf_2_2_1[0], sbb_2_1[], sbb_2_2[], sbbf_2_2_2[0] };
// physsurf_wire = newreg; Physical Surface(physsurf_wire) = { physsurf_1a_wire, physsurf_1b_wire, physsurf_2a_wire, physsurf_2b_wire };

//----------------------------------------------------------
// Physical surfaces - gas exterior / interior surface

physsurf_gas = newreg; Physical Surface(physsurf_gas) = { psBsurfT, psbdh_1_1_bsurf1t, psbdh_1_1_bsurf1b, psbdh_1_2_bsurf3t, psbdh_1_2_bsurf3b, psbdh_2_1_bsurf4t, psbdh_2_1_bsurf4b, psbdh_2_2_bsurf6t, psbdh_2_2_bsurf6b, -surfTopCp2[], -sab_1_1[0], -sab_1_1[1], -sab_1_2[0], -sab_1_2[1], -sbb_1_1[0], -sbb_1_1[1], -sbb_1_2[0], -sbb_1_2[1], -sab_2_1[0], -sab_2_1[1], -sab_2_2[0], -sab_2_2[1], -sbb_2_1[0], -sbb_2_1[1], -sbb_2_2[0], -sbb_2_2[1] };
// Physical Surface(physsurf_gas) = { physsurf_container, -physsurf_x1_wire, -physsurf_x2_wire, -physsurf_y1_wire, -physsurf_y2_wire };

//----------------------------------------------------------
// Physical surfaces - dielectric surface

// physsurf_dielectric = newreg; Physical Surface(physsurf_dielectric) = total_sl_dielectric[];
physsurf_dielectric = newreg; Physical Surface(physsurf_dielectric) = { surfTopCp1[], psSideDielectric1a, psSideDielectric2a, psSideDielectric3a, psSideDielectric4a, surfBottomCp2[] };

//----------------------------------------------------------
// Physical surfaces - lower electrode surface

physsurf_lower_cp = newreg; Physical Surface(physsurf_lower_cp) = { surfTopCp1[], pscpLowBorder1, pscpLowBorder2, pscpLowBorder3, pscpLowBorder4, surfBottomCp1[] }; 
physsurf_high_cp = newreg; Physical Surface(physsurf_high_cp) = { surfTopCp2[], pscpUpBorder1, pscpUpBorder2, pscpUpBorder3, pscpUpBorder4, surfBottomCp2[] };

//----------------------------------------------------------
// Physical surfaces - upper electrode surface

physsurf_upper_el = newreg; Physical Surface(physsurf_upper_el) = { psBsurfT };


//------------------------------------------------------------------------------------------
/// PHYSICAL VOLUMES

//----------------------------------------------------------
// Physical Volumes - Container Volume

physvol_container = newreg; Physical Volume(physvol_container) = vol_container;

//----------------------------------------------------------
// Physical Volumes - Wire Volume

// physvol_wire = newreg; Physical Volume(physvol_wire) = total_vol_wire;

//----------------------------------------------------------
// Physical Volumes - Gas Volume

physvol_gas = newreg; Physical Volume(physvol_gas) = { vol_gas };
// Physical Volume(physvol_gas) = { vol_gas };

//----------------------------------------------------------
// Physical Volumes - Component Volumes

physvol_dielectric = newreg; Physical Volume(physvol_dielectric) = { vol_dielectric };
physvol_lower_cp = newreg; Physical Volume(physvol_lower_cp) = { vol_lower_cp };
physvol_high_cp = newreg; Physical Volume(physvol_high_cp) = { vol_high_cp };


//----------------------------------------------------------
// FEATURE / ELEMENT REMOVAL

// Delete { Volume { vol_gas }; }


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/// FOOTER FILES
//

// Include "mmGasUnitCellTestWindowDefinition.geo";
// Include "mmGasUnitCellTestLineDefinition.geo";

// End


