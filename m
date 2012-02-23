From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 17:48:16 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384ED2AF9EC3@EAPEX1MAIL1.st.com>
References: <4F44E640.8010708@grandegger.com> <1626144.8BPv1GvbeG@ws-stein>
 <4F46066D.60601@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:34006 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab2BWJsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Feb 2012 04:48:38 -0500
In-Reply-To: <4F46066D.60601@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>


> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
> Sent: Thursday, February 23, 2012 2:57 PM
> To: Alexander Stein
> Cc: Linux-CAN; Bhupesh SHARMA; Tomoya MORINAGA
> Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
> 
> Hi Alexander,
> 
> On 02/23/2012 09:27 AM, Alexander Stein wrote:
> > Hello Wolfgang,
> >
> > Am Mittwoch, 22. Februar 2012, 13:57:36 schrieb Wolfgang Grandegger:
> >> For maintenance reasons, this diver should replace the "pch_can"
> driver
> >> sooner than later as it uses the same CAN controller core. I named
> it
> >> "pch_pci". Maybe "pch_can" would be more appropriate (common). This
> >> patch is for 2.6.39, but likely it applies fine also to more recent
> >> versions of the Linux kernel.
> >>
> >> Alexander, Tomoya, or anybody else, it would be nice if you could
> test
> >> this patch and give some feedback. Thanks.
> >
> > What is the current state of c_can? Are there known bugs/issues?
> 
> Bhupes said that he has a series of changes for the C_CAN driver but I
> don't know if they fix serious bugs. Apart from that, there are no
> pending issues, IIRC.
> 

Guys, the present C_CAN driver should work just fine for basic tests/data tx.
Some corner cases which require specific fixes are available locally with me.

I will try to post these patches (after merging with latest net-next)
in the coming weeks..

Regards,
Bhupesh
