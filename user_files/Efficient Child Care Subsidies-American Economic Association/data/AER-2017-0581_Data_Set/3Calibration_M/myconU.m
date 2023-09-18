function [c ceq]=myconU(d)

global w z pz N p theta gamma zu u unem exempt m1 m2 m3 m4 m5 m6 inc1 inc2 inc3 inc4 inc5 ssrate ssbase eitceli eitcmax eitcin eitcout eitcinc dctcinc1 dctcinc2 dctcinc3 dctcinc4 dctcinc5 dctcinc6 dctcinc7 dctcinc8 dctcinc9 dctcinc10 dctcinc11 dctcinc12 dctcinc13 dctcinc14 dctcinc15 dctcrate1 dctcrate2 dctcrate3 dctcrate4 dctcrate5 dctcrate6 dctcrate7 dctcrate8 dctcrate9 dctcrate10 dctcrate11 dctcrate12 dctcrate13 dctcrate14 dctcrate15 dctcrate16 dctcmax ccdfsub ccdfinc1 ccdfinc2 ccdfinc3 ccdfrate1 ccdfrate2 ccdfrate3 cons


%% Non-negative
A=0;
% A=(1/theta)*((((d(3)/zu)+d(2))^(1+gamma))/(1+gamma))-d(1)-cons;
B=-d(2);
C=-d(3);

c=[A;B;C];

%% US Tax and Benefits System

% Defining taxable income
taxable=max(0,(d(3)-exempt));
% Computing Federal taxes
if taxable>0.001 & taxable<=inc1
    tax=m1*taxable;
elseif taxable>inc1 & taxable<=inc2
    tax=m2*taxable;
elseif taxable>inc2 & taxable<=inc3
    tax=m3*taxable;
elseif taxable>inc3 & taxable<=inc4
    tax=m4*taxable;
elseif taxable>inc4 & taxable<=inc5
    tax=m5*taxable;
elseif taxable>inc5
    tax=m6*taxable;
else
    tax=0;
end
% Computing Social Security tax
ss=min(ssrate*ssbase,ssrate*d(3));
% Computing EITC benefits - Refundable tax credit
if d(3)>0.001 & d(3)<eitceli 
   eitc=min(eitcmax,eitcin*d(3));
elseif d(3)>=eitceli & d(3)<eitcinc
   eitc=min(eitcmax,(eitcmax-eitcout*(d(3)-eitceli)));
else 
   eitc=0;
end
% Computing DCTC benefits - Non-refundable tax credit
if d(3)>0.001 & d(3)<=dctcinc1
   dctc=min(tax,min(dctcmax,dctcrate1*w*(1-d(2))));
elseif d(3)>dctcinc1 & d(3)<=dctcinc2
   dctc=min(tax,min(dctcmax,dctcrate2*w*(1-d(2))));
elseif d(3)>dctcinc2 & d(3)<=dctcinc3
   dctc=min(tax,min(dctcmax,dctcrate3*w*(1-d(2))));
elseif d(3)>dctcinc3 & d(3)<=dctcinc4
   dctc=min(tax,min(dctcmax,dctcrate4*w*(1-d(2))));
elseif d(3)>dctcinc4 & d(3)<=dctcinc5
   dctc=min(tax,min(dctcmax,dctcrate5*w*(1-d(2))));
elseif d(3)>dctcinc5 & d(3)<=dctcinc6
   dctc=min(tax,min(dctcmax,dctcrate6*w*(1-d(2))));
elseif d(3)>dctcinc6 & d(3)<=dctcinc7
   dctc=min(tax,min(dctcmax,dctcrate7*w*(1-d(2))));
elseif d(3)>dctcinc7 & d(3)<=dctcinc8
   dctc=min(tax,min(dctcmax,dctcrate8*w*(1-d(2))));
elseif d(3)>dctcinc8 & d(3)<=dctcinc9
   dctc=min(tax,min(dctcmax,dctcrate9*w*(1-d(2))));
elseif d(3)>dctcinc9 & d(3)<=dctcinc10
   dctc=min(tax,min(dctcmax,dctcrate10*w*(1-d(2))));
elseif d(3)>dctcinc10 & d(3)<=dctcinc11
   dctc=min(tax,min(dctcmax,dctcrate11*w*(1-d(2))));    
elseif d(3)>dctcinc11 & d(3)<=dctcinc12
   dctc=min(tax,min(dctcmax,dctcrate12*w*(1-d(2))));
elseif d(3)>dctcinc12 & d(3)<=dctcinc13
   dctc=min(tax,min(dctcmax,dctcrate13*w*(1-d(2))));
elseif d(3)>dctcinc13 & d(3)<=dctcinc14
   dctc=min(tax,min(dctcmax,dctcrate14*w*(1-d(2))));
elseif d(3)>dctcinc14 & d(3)<=dctcinc15
   dctc=min(tax,min(dctcmax,dctcrate15*w*(1-d(2))));
elseif d(3)>dctcinc15
   dctc=min(tax,min(dctcmax,dctcrate16*w*(1-d(2))));
else
    dctc=0;
end
% Computing CCDF benefits   
if d(3)>0.001 & d(3)<=ccdfinc1
   ccdf=ccdfrate1*ccdfsub*w*(1-d(2));
elseif d(3)>ccdfinc1 & d(3)<ccdfinc2
   ccdf=ccdfrate2*ccdfsub*w*(1-d(2));
elseif d(3)>ccdfinc2 & d(3)<ccdfinc3
   ccdf=ccdfrate3*ccdfsub*w*(1-d(2));
else
   ccdf=0;
end        
% Defining net income if agent is employed 
if d(3)>0.001
    L=(d(3)-tax-ss+eitc+dctc+ccdf);
else
    L=unem;
end

%% Budget constraint
ceq=(d(1)+w*max(0,(1-d(2)))-L);

