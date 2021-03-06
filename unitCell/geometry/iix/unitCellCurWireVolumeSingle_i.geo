
mesh_level = 0.025;
// a_x1 = 0.050;

mwf = 1;
r_w = 0.1;
// p_0 = 0.1;
// p_x1 = 0.025 - ( 0 * r_w/mwf );
// R_x1 = ( p_x1 * p_x1 + r_w * r_w )/( 2 * r_w );
// alpha = Asin( (p_x1 / R_x1) );

lcWireMesh = 0.01;

p1_1a = newp; Point(p1_1a) = {0,	0,       -1*r_w+mesh_level, 	lcWireMesh};
p2_1a = newp; Point(p2_1a) = {0,	0 + r_w,  0*r_w+mesh_level, 	lcWireMesh};
p3_1a = newp; Point(p3_1a) = {0,	0, 	     +1*r_w+mesh_level,     lcWireMesh};
p4_1a = newp; Point(p4_1a) = {0,	0 - r_w,  0*r_w+mesh_level, 	lcWireMesh};

l1_1a = newl; Line(l1_1a) = {p1_1a, p2_1a};  
l2_1a = newl; Line(l2_1a) = {p2_1a, p3_1a};  
l3_1a = newl; Line(l3_1a) = {p3_1a, p4_1a};  
l4_1a = newl; Line(l4_1a) = {p4_1a, p1_1a};

ll1_1a = newll; Line Loop(ll1_1a) = {l1_1a, l2_1a, l3_1a, l4_1a};
s_1_1a = news;  Plane Surface(s_1_1a) = {ll1_1a};

p1_1b = newp; Point(p1_1b) = {1,	0,       -1*r_w+mesh_level, 	lcWireMesh};
p2_1b = newp; Point(p2_1b) = {1,	0 + r_w,  0*r_w+mesh_level, 	lcWireMesh};
p3_1b = newp; Point(p3_1b) = {1,	0, 	     +1*r_w+mesh_level,     lcWireMesh};
p4_1b = newp; Point(p4_1b) = {1,	0 - r_w,  0*r_w+mesh_level, 	lcWireMesh};

l1_1b = newl; Line(l1_1b) = {p1_1b, p2_1b};  
l2_1b = newl; Line(l2_1b) = {p2_1b, p3_1b};  
l3_1b = newl; Line(l3_1b) = {p3_1b, p4_1b};  
l4_1b = newl; Line(l4_1b) = {p4_1b, p1_1b};

ll1_1b = newll; Line Loop(ll1_1b) = {l1_1b, l2_1b, l3_1b, l4_1b};
s_1_1b = news;  Plane Surface(s_1_1b) = {ll1_1b};

l1_1ab = newl; Line(l1_1ab) = {p1_1a, p1_1b};  
l2_1ab = newl; Line(l2_1ab) = {p2_1a, p2_1b};  
l3_1ab = newl; Line(l3_1ab) = {p3_1a, p3_1b};  
l4_1ab = newl; Line(l4_1ab) = {p4_1a, p4_1b};

ll1_1ab = newll; Line Loop(ll1_1ab) = {l1_1a, l2_1ab, -l1_1b, -l1_1ab};
ll2_1ab = newll; Line Loop(ll2_1ab) = {l2_1a, l3_1ab, -l2_1b, -l2_1ab};
ll3_1ab = newll; Line Loop(ll3_1ab) = {l3_1a, l4_1ab, -l3_1b, -l3_1ab};
ll4_1ab = newll; Line Loop(ll4_1ab) = {l4_1a, l1_1ab, -l4_1b, -l4_1ab};

s_1_1ab = news;  Plane Surface(s_1_1ab) = {ll1_1ab};

//  ll1_1ab_c[] = {};
//  ll1_1ab_c[] = Boundary{ Surface{s_1_1ab[]}; };
//  p1_1b_c() = PointsOf{ Line{Abs(ll1_1ab_c[0])}; };
//  p2_1b_c() = PointsOf{ Line{Abs(ll1_1ab_c[1])}; };
//  p3_1b_c() = PointsOf{ Line{Abs(ll1_1ab_c[2])}; };
//  p4_1b_c() = PointsOf{ Line{Abs(ll1_1ab_c[3])}; };

//  l1_1a_c = newl; Line(l1_1a_c) = {p1_1b_c[0], p1_1b_c[1]};
//  l2_1ab_c = newl; Line(l2_1ab_c) = {p2_1b_c[0], p2_1b_c[1]};
//  l1_1b_c = newl; Line(l1_1b_c) = {p3_1b_c[0], p3_1b_c[1]};
//  l1_1ab_c = newl; Line(l1_1ab_c) = {p4_1b_c[0], p4_1b_c[1]};

// ll1_1ab_c = newll; Line Loop(ll1_1ab_c) = {l1_1a_c, l2_1ab_c, -l1_1b_c, -l1_1ab_c};

// s_1_1ab_c = news; Plane Surface(s_1_1ab_c) = {ll1_1ab_c};
s_2_1ab = news;  Plane Surface(s_2_1ab) = {ll2_1ab};
s_3_1ab = news;  Plane Surface(s_3_1ab) = {ll3_1ab};
s_4_1ab = news;  Plane Surface(s_4_1ab) = {ll4_1ab};

sl_wire_exterior_surface_1a = newreg; Surface Loop(sl_wire_exterior_surface_1a) = { s_1_1a, s_1_1ab, s_2_1ab, s_3_1ab, s_4_1ab, s_1_1b };
vol_1a_wire = newreg; Volume(vol_1a_wire) = sl_wire_exterior_surface_1a;
physvol_1a_wire = newreg; Physical Volume(physvol_1a_wire) = vol_1a_wire;
physsurf_1a_wire = newreg; Physical Surface(physsurf_1a_wire) = { s_1_1a, s_1_1ab, s_2_1ab, s_3_1ab, s_4_1ab, s_1_1b };

Geometry.Tolerance = 1-06;
Coherence Mesh;




