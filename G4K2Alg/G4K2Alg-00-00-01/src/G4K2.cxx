#include "GaudiKernel/MsgStream.h"
#include "GaudiKernel/AlgFactory.h"
#include "GaudiKernel/ISvcLocator.h"
#include "GaudiKernel/SmartDataPtr.h"
#include "GaudiKernel/IDataProviderSvc.h"
#include "GaudiKernel/PropertyMgr.h"
#include "VertexFit/IVertexDbSvc.h"
 
#include "GaudiKernel/Bootstrap.h"
#include "GaudiKernel/ISvcLocator.h"
#include "GaudiKernel/IJobOptionsSvc.h"

#include "EventModel/EventModel.h"
#include "EventModel/Event.h"
#include "EmcRawEvent/EmcDigi.h"
#include "EmcRecEventModel/RecEmcHit.h"
#include "EvTimeEvent/RecEsTime.h"

#include "Identifier/Identifier.h"
#include "McTruth/McParticle.h"
#include "McTruth/DecayMode.h"
#include "McTruth/MdcMcHit.h"
#include "McTruth/TofMcHit.h"
#include "McTruth/EmcMcHit.h"
#include "McTruth/MucMcHit.h"  
#include "McTruth/McEvent.h"

#include "EvtRecEvent/EvtRecEvent.h"
#include "EvtRecEvent/EvtRecTrack.h"
#include "DstEvent/TofHitStatus.h"
#include "EventModel/EventHeader.h"

#include "TMath.h"
#include "GaudiKernel/INTupleSvc.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/Bootstrap.h"
#include "GaudiKernel/IHistogramSvc.h"
#include "CLHEP/Vector/ThreeVector.h"
#include "CLHEP/Vector/LorentzVector.h"
#include "CLHEP/Vector/TwoVector.h"
using CLHEP::Hep3Vector;
using CLHEP::Hep2Vector;
using CLHEP::HepLorentzVector;
#include "CLHEP/Geometry/Point3D.h"
#ifndef ENABLE_BACKWARDS_COMPATIBILITY
typedef HepGeom::Point3D<double> HepPoint3D;
#endif
#include "G4K2Alg/G4K2.h"

#include "VertexFit/KinematicFit.h"
#include "VertexFit/KalmanKinematicFit.h"
#include "VertexFit/VertexFit.h"
#include "VertexFit/Helix.h"
#include "RootCnvSvc/RootInterface.h"
#include "ParticleID/ParticleID.h"
#include "EventNavigator/EventNavigator.h"
#include "MdcRecEvent/RecMdcTrack.h"
#include "MdcRecEvent/RecMdcHit.h"
#include "EmcRecEventModel/RecEmcShower.h"
#include "PartPropSvc/PartPropSvc.h"

#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include "TRandom.h"

//const double pi = 3.1415927;
const double mpi = 0.13957;
const double mpi0 = 0.1349766;
const double mk = 0.493677;
const double meta = 0.547853;
const double me = 0.000510998910;
const double mmu = 0.105658367;
const double mp = 0.93827203; 
const double xmass[5] = {0.000511, 0.105658, 0.139570,0.493677, 0.938272};
const double E2175=3.097;
//const double E2175=3.686;

const double velc = 299.792458;   // tof path unit in mm
typedef std::vector<int> Vint;
typedef std::vector<double> Vdouble;
typedef std::vector<HepLorentzVector> Vp4;

using namespace std;

int Ncut0,Ncut1,Ncut2,Ncut3,Ncut4,Ncut5;

/////////////////////////////////////////////////////////////////////////////
G4K2::G4K2(const std::string& name, ISvcLocator* pSvcLocator) :		//do not change this function
	Algorithm(name, pSvcLocator) {

		//Declare the properties  
		declareProperty("OutputFileName",  m_OutputFileName = "out.root");
		declareProperty("PsiType",m_psiType = 1);
		declareProperty("Vr0cut", m_vr0cut=1.0);
		declareProperty("Vz0cut", m_vz0cut=10.0);
		declareProperty("Ccoscut", m_ccoscut=0.93);
		declareProperty("IsoAngleCut", m_isoAngleCut=10.0);
		declareProperty("CutFlow", m_cutFlow = 1);
		declareProperty("ReadSig", m_readSig = 1);
		declareProperty("MCTruth", m_mcTruth = 1);
                
  		declareProperty("UseVxfitCut", m_useVxfitCut = 1);
                declareProperty("UseKmfitCut", m_useKmfitCut = 1);     
       }
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
StatusCode G4K2::initialize(){
        MsgStream log(msgSvc(), name());
        log << MSG::INFO << "in initialize()" << endmsg;
	StatusCode status;

	//***********Initialize the output structure**************
	TString s_OutputFileName(m_OutputFileName);
	s_OutputFileName.ReplaceAll("[\"","");
	s_OutputFileName.ReplaceAll("\"]","");
	saveFile = new TFile(s_OutputFileName, "recreate");

	//For cut flow, DO NOT ACTIVATE it except for analysing signal MC
	if(m_cutFlow==1){
		TCutFlow = new TTree("TCutFlow", "cut flow");
		TCutFlow->Branch("cutflow", &cutflow, "cutflow/I");
	}

	//For Analysis
	if(m_readSig==1)
	{
        	TreeAna = new TTree("TreeAna", "analysis");

	        //To store mc truth.
                if(m_mcTruth==1)

                {
                p_f0_mctruth = new TLorentzVector();

                TreeAna->Branch("p_f0_mctruth",&p_f0_mctruth,32000, 0);
                TreeAna->Branch("indexmc",&indexmc,"indexmc/I");
                TreeAna->Branch("pdgid", pdgid,"pdgid[indexmc]/I");
                TreeAna->Branch("motheridx",motheridx,"motheridx[indexmc]/I");
                }
	
                //After 4c.
                pip   = new TLorentzVector();
                pim   = new TLorentzVector();
                kp   = new TLorentzVector();
                km   = new TLorentzVector();
                gamma1 = new TLorentzVector();
                gamma2 = new TLorentzVector();
                gamma3 = new TLorentzVector();
                gamma4 = new TLorentzVector();

                //Before 4c.
                pip_unfitted   = new TLorentzVector();
                pim_unfitted   = new TLorentzVector();
                kp_unfitted   = new TLorentzVector();
                km_unfitted   = new TLorentzVector();
                gamma1_unfitted = new TLorentzVector();
                gamma2_unfitted = new TLorentzVector();
                gamma3_unfitted = new TLorentzVector();
                gamma4_unfitted = new TLorentzVector();
               
    //Header
		TreeAna->Branch("runid", &runid, "runid/I");
		TreeAna->Branch("evtid", &evtid, "evtid/I");
		TreeAna->Branch("nevt", &nevt, "nevt/I");           
    		TreeAna->Branch("n_charged",&n_charged,"n_charged/I");
                TreeAna->Branch("n_gamma",&n_gamma,"n_gamma/I");
                TreeAna->Branch("n_endgamma",&n_endgamma,"n_endgamma/I");	
        	TreeAna->Branch("m_dang",m_dang,"m_dang[n_gamma]/D");
                TreeAna->Branch("m_Rxy",m_Rxy,"m_Rxy[n_charged]/D");
                TreeAna->Branch("m_tdc",m_tdc,"m_tdc[n_gamma]/D");
                TreeAna->Branch("m_z0",m_z0,"m_z0[n_charged]/D");
            
 		TreeAna->Branch("Chisq_low", &Chisq_low, "Chisq_low/D");	
		TreeAna->Branch("vxchisq", &vxchisq, "vxchisq/D");
		//Particles

                //After 4c
                TreeAna->Branch("gamma1",&gamma1,32000, 0);
                TreeAna->Branch("gamma2",&gamma2,32000, 0);	
                TreeAna->Branch("gamma3",&gamma3,32000, 0);	
                TreeAna->Branch("gamma4",&gamma4,32000, 0);	
                TreeAna->Branch("kp",&kp,32000,0);
                TreeAna->Branch("km",&km,32000,0);
                //Before 4c
                TreeAna->Branch("gamma1_unfitted",&gamma1_unfitted,32000, 0);
                TreeAna->Branch("gamma2_unfitted",&gamma2_unfitted,32000, 0);
                TreeAna->Branch("gamma3_unfitted",&gamma3_unfitted,32000, 0);
                TreeAna->Branch("gamma4_unfitted",&gamma4_unfitted,32000, 0);
                TreeAna->Branch("kp_unfitted",&kp_unfitted,32000,0);
                TreeAna->Branch("km_unfitted",&km_unfitted,32000,0);

	}

	//For MC truth. Used for topology
	if(m_mcTruth==1)
	{

	}

	//********************************************************

	Ncut0 = 0;         //Total
	Ncut1 = 0;         //Charge
	Ncut2 = 0;         //Neutral
	Ncut3 = 0;         //PID
	Ncut4 = 0;         //vertex fit
	Ncut5 = 0;         //4c
       
	static const bool CREATEIFNOTTHERE(true);
	StatusCode PartPropStatus = Gaudi::svcLocator()->service("PartPropSvc", p_PartPropSvc, CREATEIFNOTTHERE);
	if (!PartPropStatus.isSuccess() || 0 == p_PartPropSvc) {
		std::cerr << "Could not initialize Particle Properties Service" << std::endl;
		return StatusCode::FAILURE;
	}     
	m_particleTable = p_PartPropSvc->PDT();
	log << MSG::INFO << "successfully return from initialize()" <<endmsg;
	return StatusCode::SUCCESS;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
StatusCode G4K2::execute() {

	MsgStream log(msgSvc(), name());
	log << MSG::INFO << "in execute()" << endreq;

	SmartDataPtr<Event::EventHeader> eventHeader(eventSvc(),"/Event/EventHeader");  
	int runNo=eventHeader->runNumber();
	int event=eventHeader->eventNumber();
	log << MSG::DEBUG <<"run, evtnum = "
		<< runNo << " , "
		<< event <<endreq;  
	Ncut0++;            //Total Event counter
	if(m_cutFlow ==1){
		cutflow=0;
		TCutFlow->Fill();
	}

	SmartDataPtr<EvtRecEvent> evtRecEvent(eventSvc(), EventModel::EvtRec::EvtRecEvent);
	//  log << MSG::INFO << "get event tag OK" << endreq;
	log << MSG::DEBUG <<"ncharg, nneu, tottks = " 
		<< evtRecEvent->totalCharged() << " , "
		<< evtRecEvent->totalNeutral() << " , "
		<< evtRecEvent->totalTracks() <<endreq;

	if(event%1000 == 0)
	{
		cout<<"Processing "<<event<<"th event..."<<endl;
		cout<<"Event Level Cut flow: total events: "<<Ncut0<<" charged track selection: "<<Ncut1<<" | photon selection: "<<Ncut2<<"  PID: "<<Ncut3<<" | vertex fit "<<Ncut4<<" 4c fit "<<Ncut5<<endl;
	}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 


        //******************MCTruth************************
        if(m_mcTruth==1&&runNo<0)
        {
                SmartDataPtr<Event::McParticleCol> mcParticleCol(eventSvc(),"/Event/MC/McParticleCol");
                if (!mcParticleCol) {
                        log << MSG::WARNING << "Could not find McParticle" << endreq;
                        return  (StatusCode::FAILURE);
                }
                else{
                        int m_numParticle=0;
                        bool jpsiDecay = false;
                        bool m_strange = false;
                        bool m_FSR =false;
                        int  jpsiIndex = -1;
                       // cout<<"Let's start!!!"<<endl;

                        Event::McParticleCol::iterator iter_mc = mcParticleCol->begin();
                        for (; iter_mc != mcParticleCol->end(); iter_mc++) {
                        if ((*iter_mc)->primaryParticle()&&(*iter_mc)->particleProperty()==11&&((*iter_mc)->mother()).particleProperty()== 11){ m_strange=true;}

                        if ((*iter_mc)->primaryParticle()) continue;//e+e-
                        if (!(*iter_mc)->decayFromGenerator()) continue;
                  // Reytrieve partilce ID      
                        if ((*iter_mc)->particleProperty()== 443){
                                        jpsiDecay = true;
                                        jpsiIndex = (*iter_mc)->trackIndex();
                                }

                        if (!jpsiDecay) continue;

                        int m_mcidx = ((*iter_mc)->mother()).trackIndex() - jpsiIndex;
                        int m_pdgid = (*iter_mc)->particleProperty();

                        if(m_strange&&((*iter_mc)->mother()).particleProperty()!= 443 ) m_mcidx--;

                                pdgid[m_numParticle] = m_pdgid;
                                motheridx[m_numParticle] = m_mcidx;
                                m_numParticle += 1;//1+1=2,for Jpsi->phi f0(1710).

                        // Jpsi->phi f0(1710)
                        // Store P of f0(1710)
                        // Pay attention to 3 places: m_numParticle,m_pdgid,mother_pdgid.            
                        //****************************************************
                    if (m_numParticle == 2) {
                    //m_numParticle=2=1+1,from inclusive mc.
                        HepLorentzVector p = (*iter_mc)->initialFourMomentum();
                        if ( (m_pdgid == 10331)&&((*iter_mc)->mother().particleProperty()==443) ) {
                        //m_pdgid=10331:f_0(1710).
                        //mother_pdgid=443:from Jpsi.
                          p_f0_mctruth->SetPxPyPzE(p.px(), p.py(), p.pz(), p.e());
                          }
                        else {
                          p_f0_mctruth->SetPxPyPzE(0,0,0,0);
                          }
                    }
                    else {
                    //Do nothing.
                    }
                        //****************************************************

                        }//end of mcParticleCol
                        indexmc= m_numParticle;

                }
        }//end of mctruth


	//*************Global Event Parameters************
	//do not change below
	double ecms;
	int psi;
	double ESpread;

	if(m_psiType == 1){
		ecms=E2175;    
	//	psi=443;
		ESpread=0.0008;
	}


	HepLorentzVector cms(0.011*ecms, 0., 0., ecms);    //for 4C fit
        //get the track collection 
        SmartDataPtr<EvtRecTrackCol> evtRecTrkCol(eventSvc(),  EventModel::EvtRec::EvtRecTrackCol);
	//************Global Vectors**********************
	//do not change below
	Vint iGood, iGamma;
        Vint ipip,ipim,ikp,ikm;

	int nGood = 0; 
	int nCharge = 0;
	int nGamma = 0;
        int npip=0;
        int npim=0;
        int nkp=0;
        int nkm=0;

	iGood.clear();
	iGamma.clear();
        ipip.clear();
        ipim.clear();
        ikp.clear();
        ikm.clear();

	//*****************Primary Vertex*****************
	Hep3Vector xorigin(0,0,0);
        HepSymMatrix VtxErr(3,0);
	IVertexDbSvc*  vtxsvc;
	Gaudi::svcLocator()->service("VertexDbSvc", vtxsvc);
	if(vtxsvc->isVertexValid()){
		double* dbv = vtxsvc->PrimaryVertex(); 
		double*  vv = vtxsvc->SigmaPrimaryVertex();  
		xorigin.setX(dbv[0]);
		xorigin.setY(dbv[1]);
		xorigin.setZ(dbv[2]);
                
                VtxErr[0][0] = vv[0]*vv[0];
  		VtxErr[1][1] = vv[1]*vv[1];
  		VtxErr[2][2] = vv[2]*vv[2];
	}



//*****************************************************
//Good Charged Track Selection
//****************************************************
         n_charged =0;
         HepPoint3D IP(xorigin[0],xorigin[1],xorigin[2]);
         HepPoint3D OP(0,0,0);
         for(int i = 0; i < evtRecEvent->totalCharged(); i++){
		if(i >= evtRecTrkCol->size()) break;

		EvtRecTrackIterator itTrk=evtRecTrkCol->begin() + i;
		if(!(*itTrk)->isMdcTrackValid()) continue;
		if(!(*itTrk)->isMdcKalTrackValid()) continue;

		RecMdcTrack *mdcTrk = (*itTrk)->mdcTrack();
		double pch=mdcTrk->p();
		double ptch=mdcTrk->pxy();
		double x0=mdcTrk->x();
		double y0=mdcTrk->y();
		double z0=mdcTrk->z();
		double phi0=mdcTrk->helix(1);
		double xv=xorigin.x();
		double yv=xorigin.y();
		double Rxy=(x0-xv)*cos(phi0)+(y0-yv)*sin(phi0);
		//raw vertax
		HepVector a = mdcTrk->helix();
		HepSymMatrix Ea = mdcTrk->err();
		HepPoint3D point0(0.,0.,0.);   // the initial point for MDC recosntruction
	//	HepPoint3D IP(xorigin[0],xorigin[1],xorigin[2]); 
		VFHelix helixip(point0,a,Ea); 
		helixip.pivot(IP);
		HepVector vecipa = helixip.a();
		double  Rvxy0=fabs(vecipa[0]);  //the nearest distance to IP in xy plane
		double  Rvz0=vecipa[3];         //the nearest distance to IP in z direction
		double  Rvphi0=vecipa[1];
		double ccos=cos(mdcTrk->theta());
		//
		//Good Charged Track Cut is set here
		if(fabs(ccos) > m_ccoscut) continue;
		if(fabs(Rvz0) >= m_vz0cut ) continue;
		if(fabs(Rvxy0) >= m_vr0cut) continue;
	
          	RecMdcKalTrack *mdcKalTrk = (*itTrk)->mdcKalTrack();
		if(mdcKalTrk->charge() == 0) continue;
              
                m_Rxy[n_charged] = Rvxy0;
                m_z0[n_charged]  = Rvz0;
                n_charged ++;
		iGood.push_back((*itTrk)->trackId());
		nCharge += mdcKalTrk->charge();
	}

	nGood = iGood.size(); 
	log << MSG::DEBUG << "ngood, totcharge = " << nGood << " , " << nCharge << endreq;
	if((nGood != 2) || (nCharge != 0)) return StatusCode::SUCCESS;

	Ncut1++;  
	if(m_cutFlow ==1)
	{
		cutflow=1;
		TCutFlow->Fill();
	}

//**************************************
//  Good Photon selection
//*************************************
        n_gamma=0;
        n_endgamma=0;

	for(int i = evtRecEvent->totalCharged(); i< evtRecEvent->totalTracks(); i++){
		if(i >= evtRecTrkCol->size()) break;
   //Emcshower: electron and photon    information about incident angle and deposited energy
		EvtRecTrackIterator itTrk=evtRecTrkCol->begin() + i;
		if(!(*itTrk)->isEmcShowerValid()) continue;

		RecEmcShower *emcTrk = (*itTrk)->emcShower();
		Hep3Vector emcpos(emcTrk->x(), emcTrk->y(), emcTrk->z());
		// find the nearest charged track  
		double dthe = 200.;
		double dphi = 200.;
		double dang = 200.; 
		for(int j = 0; j < evtRecEvent->totalCharged(); j++){
			if(j >= evtRecTrkCol->size()) break;

			EvtRecTrackIterator jtTrk = evtRecTrkCol->begin() + j;
			if(!(*jtTrk)->isExtTrackValid()) continue;
                       // RecExtTrack Output of track extrapolation results
			RecExtTrack *extTrk = (*jtTrk)->extTrack();
			if(extTrk->emcVolumeNumber() == -1) continue;
			Hep3Vector extpos = extTrk->emcPosition() - xorigin;
			 // the angle between the adjacent charged track
			double angd = extpos.angle(emcpos);
			
			double thed = extpos.theta() - emcpos.theta();
			double phid = extpos.deltaPhi(emcpos);
			thed = fmod(thed+CLHEP::twopi+CLHEP::twopi+pi, CLHEP::twopi) - CLHEP::pi;
			phid = fmod(phid+CLHEP::twopi+CLHEP::twopi+pi, CLHEP::twopi) - CLHEP::pi;
			
			if(angd < dang){
				dang = angd;
				dthe = thed;
				dphi = phid;
			}
		}
		if(dang >= 200) continue;
        
                double eraw = emcTrk->energy();
		dthe = dthe * 180 / (CLHEP::pi);
		dphi = dphi * 180 / (CLHEP::pi);
		dang = dang * 180 / (CLHEP::pi);
		
		// good photon cut will be set here
		double the = emcpos.theta();
		double e_threshold = 10.0;
		if(fabs(cos(the)) < 0.8)   e_threshold = 0.025;
		else if((fabs(cos(the)) > 0.86) && (fabs(cos(the)) < 0.92)) e_threshold = 0.050;

		if(eraw < e_threshold) continue;
        	if(fabs(dang) < m_isoAngleCut) continue;
		if(emcTrk->time()>14  || emcTrk->time()<0) continue;

		if(e_threshold ==0.050 ) n_endgamma++;
                m_dang[n_gamma] =dang;
                m_tdc[n_gamma]= ( emcTrk->time());
                n_gamma++;
		iGamma.push_back((*itTrk)->trackId());
        
	}

	nGamma = iGamma.size();

	log << MSG::DEBUG << "num Good Photon " << nGamma  << " , " <<evtRecEvent->totalNeutral()<<endreq;
	if(nGamma < 4) return StatusCode::SUCCESS;
        if(nGamma > 6) return StatusCode::SUCCESS;

	Ncut2++; 
	if(m_cutFlow ==1)
	{
		cutflow=2;
		TCutFlow->Fill();
	} 

// Assign 4-momentum to each photon
	
        HepLorentzVector ptotal(0,0,0,0);
	Vp4 pGamma;
	pGamma.clear();

	for(int i = 0; i < nGamma; i++)
	{
		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGamma[i]; 
		RecEmcShower* emcTrk = (*itTrk)->emcShower();
		double eraw = emcTrk->energy();

		Hep3Vector emcpos(emcTrk->x(), emcTrk->y(), emcTrk->z()); 
		Hep3Vector gammaDirection = emcpos - xorigin;
		double phi = gammaDirection.phi();
		double the = gammaDirection.theta();

		HepLorentzVector ptrk;
		ptrk.setPx(eraw*sin(the)*cos(phi));
		ptrk.setPy(eraw*sin(the)*sin(phi));
		ptrk.setPz(eraw*cos(the));
		ptrk.setE(eraw);
		ptotal=ptotal+ptrk;
		pGamma.push_back(ptrk);
	}

//**********************************
// PID
//*********************************
           ParticleID *pid = ParticleID::instance();
	   for(int i = 0; i < nGood; i++)
	   {
		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGood[i];
		//if(pid) delete pid;
		pid->init();
		pid->setMethod(pid->methodProbability());
		//pid->setMethod(pid->methodLikelihood());  //for Likelihood Method  
		pid->setChiMinCut(4);
		pid->setRecTrack(*itTrk);
		pid->usePidSys(pid->useDedx() | pid->useTof1() | pid->useTof2()| pid->useTofE() ); // use PID sub-system
		pid->identify( pid->onlyPion() | pid->onlyKaon() |pid->onlyElectron() );    // seperater Pion/Kaon/electron
		pid->calculate();
                if(!(pid->IsPidInfoValid())) return StatusCode::SUCCESS;

                Double_t prob_pi  = pid->probPion();
                Double_t prob_k   = pid->probKaon();
                Double_t prob_e   = pid->probElectron();

           if( !(*itTrk)->isMdcKalTrackValid() ) return StatusCode::SUCCESS; 
           RecMdcKalTrack* mdcKalTrk = (*itTrk)->mdcKalTrack();
                
           if( (prob_k>prob_e)&&(prob_k>prob_pi) ) {

                       if(mdcKalTrk->charge() > 0){
                              ikp.push_back(iGood[i]);
                                }
                       else{  ikm.push_back(iGood[i]);
                           }

                 }
                else{
                 }
 
    //***************************************************************
        }//end of pid
        
        nkp=ikp.size();
        nkm=ikm.size();

       if(nkp!=1||nkm!=1){
        return StatusCode::SUCCESS;
        }


          
	Ncut3++;
	if(m_cutFlow ==1)
	{
		cutflow=3;
		TCutFlow->Fill();
	} 

	

//***************************************
// VertexFit 
//**************************************
         WTrackParameter wvkpTrk,wvkmTrk;
         WTrackParameter wvpimTrk,wvpipTrk;

         RecMdcKalTrack *kpTrk1 = (*(evtRecTrkCol->begin()+ikp[0]))->mdcKalTrack();
         kpTrk1->setPidType(RecMdcKalTrack::kaon);
         wvkpTrk = WTrackParameter(mk, kpTrk1->getZHelixK(), kpTrk1->getZErrorK());

         RecMdcKalTrack *kmTrk1 = (*(evtRecTrkCol->begin()+ikm[0]))->mdcKalTrack();
         kmTrk1->setPidType(RecMdcKalTrack::kaon);
         wvkmTrk = WTrackParameter(mk, kmTrk1->getZHelixK(), kmTrk1->getZErrorK());
        


        HepPoint3D vx(0., 0., 0.);
        HepSymMatrix Evx(3, 0);
        double bx = 1E+6;
        double by = 1E+6;
        double bz = 1E+6;
        Evx[0][0] = bx*bx;
        Evx[1][1] = by*by;
        Evx[2][2] = bz*bz;

        VertexParameter vxpar;
        vxpar.setVx(vx);
        vxpar.setEvx(Evx);

        VertexFit* vtxfit = VertexFit::instance();
        vtxfit->init();
        vtxfit->AddTrack(0,  wvkpTrk);
        vtxfit->AddTrack(1,  wvkmTrk);
        vtxfit->AddVertex(0, vxpar, 0, 1);

        bool okfit = vtxfit->Fit(0);
        if( (m_useVxfitCut==1)&&(!okfit) ) return StatusCode::SUCCESS;
       
        Ncut4++;
        if(m_cutFlow ==1)
        {
                cutflow=4;
                TCutFlow->Fill();
        }
        vtxfit->Swim(0);
        vxchisq = vtxfit->chisq(0);
 
        WTrackParameter wkp = vtxfit->wtrk(0);
        WTrackParameter wkm = vtxfit->wtrk(1);

        HepPoint3D vx_infit = vtxfit->vx(0);
        HepSymMatrix Evx_infit = vtxfit->Evx(0);

//**************************************
// Kinematic Fit
//**************************************
        nevt=0;
	Chisq_low=1000;

        KalmanKinematicFit *kmfit = KalmanKinematicFit::instance();
        for(int i1 = 0; i1 < nGamma-3; i1++){
               RecEmcShower* gammaTrk1 = (*(evtRecTrkCol->begin()+iGamma[i1]))->emcShower();
               for(int i2 = i1+1; i2 < nGamma-2; i2++){
               RecEmcShower* gammaTrk2 = (*(evtRecTrkCol->begin()+iGamma[i2]))->emcShower();


               for(int i3 = i2+1; i3 < nGamma-1; i3++){
               RecEmcShower* gammaTrk3 = (*(evtRecTrkCol->begin()+iGamma[i3]))->emcShower();
               
               for(int i4 = i3+1; i4 < nGamma; i4++){
               RecEmcShower* gammaTrk4 = (*(evtRecTrkCol->begin()+iGamma[i4]))->emcShower();
                  kmfit->init();
            //    kmfit->setEspread(ESpread);
                  kmfit->setBeamPosition(vx_infit);
                  kmfit->setVBeamPosition(Evx_infit);
                  kmfit->AddTrack(0, 0.0, gammaTrk1);
                  kmfit->AddTrack(1, 0.0, gammaTrk2);
                  kmfit->AddTrack(2, wkp);
                  kmfit->AddTrack(3, wkm);
                  kmfit->AddTrack(4, 0.0, gammaTrk3);
                  kmfit->AddTrack(5, 0.0, gammaTrk4);

                  kmfit->AddFourMomentum(0, cms);

                  bool okKmfit = kmfit->Fit();
                  if((m_useKmfitCut==1)&&(!okKmfit)) continue;
                  kmchisq_4c = kmfit->chisq();
    
                  if(kmchisq_4c>Chisq_low) continue;
                  Chisq_low = kmchisq_4c;

   		HepLorentzVector gamma1_ = kmfit->pfit(0);
                HepLorentzVector gamma2_ = kmfit->pfit(1);
                HepLorentzVector gamma3_ = kmfit->pfit(4);
                HepLorentzVector gamma4_ = kmfit->pfit(5);
                HepLorentzVector kp_ = kmfit->pfit(2);   
                HepLorentzVector km_ = kmfit->pfit(3);   

                //After 4c
                gamma1->SetPxPyPzE(gamma1_.px(), gamma1_.py(), gamma1_.pz(), gamma1_.e());
                gamma2->SetPxPyPzE(gamma2_.px(), gamma2_.py(), gamma2_.pz(), gamma2_.e());
                gamma3->SetPxPyPzE(gamma3_.px(), gamma3_.py(), gamma3_.pz(), gamma3_.e());
                gamma4->SetPxPyPzE(gamma4_.px(), gamma4_.py(), gamma4_.pz(), gamma4_.e());

                kp->SetPxPyPzE(kp_.px(), kp_.py(), kp_.pz(), kp_.e());
                km->SetPxPyPzE(km_.px(), km_.py(), km_.pz(), km_.e());

                //Before 4c
                //Photon:after  Assign 4-momentum to each photon.
                gamma1_unfitted->SetPxPyPzE(pGamma[i1].px(), pGamma[i1].py(), pGamma[i1].pz(), pGamma[i1].e());
                gamma2_unfitted->SetPxPyPzE(pGamma[i2].px(), pGamma[i2].py(), pGamma[i2].pz(), pGamma[i2].e());
                gamma3_unfitted->SetPxPyPzE(pGamma[i3].px(), pGamma[i3].py(), pGamma[i3].pz(), pGamma[i3].e());
                gamma4_unfitted->SetPxPyPzE(pGamma[i4].px(), pGamma[i4].py(), pGamma[i4].pz(), pGamma[i4].e());
         
                //Charged tracks: after vertex fit.
                kp_unfitted->SetPxPyPzE((wkp.p()).px(), (wkp.p()).py(), (wkp.p()).pz(), (wkp.p()).e());
                km_unfitted->SetPxPyPzE((wkm.p()).px(), (wkm.p()).py(), (wkm.p()).pz(), (wkm.p()).e());

        nevt++;

        }//fourth photon
	}//third photon	
	}//second photon
        }//first photon
	runid=runNo;
	evtid=event;

	if(nevt==0) return StatusCode::SUCCESS;
	Ncut5++;
	if(m_cutFlow ==1)
	{
		cutflow=5;
		TCutFlow->Fill();
	} 

	TreeAna->Fill();

//*************************************************************************
	return StatusCode::SUCCESS;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
StatusCode G4K2::finalize()
{
	cout << "In finalize()..." << endl;

	saveFile->cd();
	if(m_cutFlow==1) TCutFlow->Write();
	if(m_readSig==1) TreeAna->Write();
	saveFile->Close();

	cout << "Total Event Number: " << Ncut0 << endl;
	cout << "After charged track cut: " << Ncut1 << endl;
	cout << "After photon cut: " << Ncut2 << endl;
	cout << "After PID: " << Ncut3 << endl;
	cout << "After Vertex Fit:" << Ncut4 << endl;
        cout << "After Kinematic Fit:" << Ncut5 << endl;
        
	return StatusCode::SUCCESS;
}
