#define QPATH_TEXTURE QPATHTOF(data\texture.paa)
#define QPATH_MODEL_CIGPACK QPATHTOF(data\cigpack.p3d)

#define QPATH_BASE_RVMAT QPATHTOEF(base,data\texture.rvmat)
#define QPATH_BASE_RVMAT_LIT QPATHTOEF(base,data\texture_lit.rvmat)

#define QPATH_BASE_MODEL_CIG0 QPATHTOEF(base,data\cig0.p3d)
#define QPATH_BASE_MODEL_CIG1 QPATHTOEF(base,data\cig1.p3d)
#define QPATH_BASE_MODEL_CIG2 QPATHTOEF(base,data\cig2.p3d)
#define QPATH_BASE_MODEL_CIG3 QPATHTOEF(base,data\cig3.p3d)
#define QPATH_BASE_MODEL_CIG4 QPATHTOEF(base,data\cig4.p3d)

// Filterless cigarettes: the same texture layout, paper only, 56 mm down to 20 mm
#define QPATH_BASE_MODEL_NOFILTER_CIG0 QPATHTOEF(base,data\cig_nofilter0.p3d)
#define QPATH_BASE_MODEL_NOFILTER_CIG1 QPATHTOEF(base,data\cig_nofilter1.p3d)
#define QPATH_BASE_MODEL_NOFILTER_CIG2 QPATHTOEF(base,data\cig_nofilter2.p3d)
#define QPATH_BASE_MODEL_NOFILTER_CIG3 QPATHTOEF(base,data\cig_nofilter3.p3d)
#define QPATH_BASE_MODEL_NOFILTER_CIG4 QPATHTOEF(base,data\cig_nofilter4.p3d)

// Cigars: shared models and materials, each brand brings data\cigars\cigar_co.paa
#define QPATH_TEXTURE_CIGAR QPATHTOF(data\cigars\cigar_co.paa)
#define QPATH_BASE_RVMAT_CIGAR QPATHTOEF(base,data\cigar.rvmat)
#define QPATH_BASE_RVMAT_CIGAR_LIT QPATHTOEF(base,data\cigar_lit.rvmat)
#define QPATH_BASE_MODEL_CIGAR0 QPATHTOEF(base,data\cigar0.p3d)
#define QPATH_BASE_MODEL_CIGAR1 QPATHTOEF(base,data\cigar1.p3d)
#define QPATH_BASE_MODEL_CIGAR2 QPATHTOEF(base,data\cigar2.p3d)
#define QPATH_BASE_MODEL_CIGAR3 QPATHTOEF(base,data\cigar3.p3d)
#define QPATH_BASE_MODEL_CIGAR4 QPATHTOEF(base,data\cigar4.p3d)

#define MODLSTRING(key) [LSTRING(DOUBLES(module,key)),LSTRING(TRIPLES(module,key,desc))]
