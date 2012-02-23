From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 18:00:39 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384ED2AF9ED1@EAPEX1MAIL1.st.com>
References: <4F44E640.8010708@grandegger.com>
 <4F46066D.60601@grandegger.com>
 <D5ECB3C7A6F99444980976A8C6D896384ED2AF9EC3@EAPEX1MAIL1.st.com>
 <1576024.pYtPQF4ECB@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:35147 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754782Ab2BWKA6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Feb 2012 05:00:58 -0500
In-Reply-To: <1576024.pYtPQF4ECB@ws-stein>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Linux-CAN <linux-can@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>


> -----Original Message-----
> From: Alexander Stein [mailto:alexander.stein@systec-electronic.com]
> Sent: Thursday, February 23, 2012 3:26 PM
> To: Bhupesh SHARMA
> Cc: Wolfgang Grandegger; Linux-CAN; Tomoya MORINAGA
> Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
> 
> Am Donnerstag, 23. Februar 2012, 17:48:16 schrieb Bhupesh SHARMA:
> > > > What is the current state of c_can? Are there known bugs/issues?
> > >
> > > Bhupes said that he has a series of changes for the C_CAN driver
> but I
> > > don't know if they fix serious bugs. Apart from that, there are no
> > > pending issues, IIRC.
> > >
> >
> > Guys, the present C_CAN driver should work just fine for basic
> tests/data tx.
> > Some corner cases which require specific fixes are available locally
> with me.
> 
> Could you shortly describe which corner cases these are?
> 

Depends on what platform are you using..
I think you will not be using the SPEAr SoCs from ST.
It may be that in that case the present driver can work as it is.

Give it a try and let me know if you face any issues..

Regards,
Bhupesh
