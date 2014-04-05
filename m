From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Sat, 5 Apr 2014 21:48:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404052144080.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EDB36.6060404@del-llc.com> <alpine.DEB.2.02.1404051538110.14882@ionos.tec.linutronix.de> <53405BCC.7060701@grandegger.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45418 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbaDETsB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Apr 2014 15:48:01 -0400
In-Reply-To: <53405BCC.7060701@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Mark <mark5@del-llc.com>, linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>

On Sat, 5 Apr 2014, Wolfgang Grandegger wrote:
> On 04/05/2014 08:56 PM, Thomas Gleixner wrote:
> > On Fri, 4 Apr 2014, Mark wrote:
> > 
> >> Thomas:  a few comments on my experience with the CAN driver:
> >>
> >> I think I agree with your approach -- I had the same problem losing a packet
> >> when running through the clearing of the newdat flags.
> >>
> >> About a month ago, I re-wrote pch_can.c  (before I discovered this mailing
> >> list) and got it to work successfully sending / receiving CAN data at 1 MBIT
> > 
> > Wow, that's amazing.
> 
> We realized late that the pch_can manual [1] is an exact copy of the
> c_can manual just with different register names (and without mentioning
> c_can at all). Also the initial author didn't mentioning it. Maybe he
> did not even know.
> 
> > That driver is just a variant of c_can.c with quite some of the same
> > bugs and some different ones.
> 
> It's worse :(.
> 
> > We really should switch that over to c_can.c and get rid of it.
> 
> See http://news.gmane.org/gmane.linux.can. Should we remove pch_can
> immediately? Or labeling it deprecated first.

Dunno, but removing it right away seems to be the better solution to
avoid that people start fixing pch_can.c again.

One trick to keep the existing users happy, is keeping the Kconfig
switch and select the C_CAN stuff for it. Then you can gradually phase
it out.

Thanks,

	tglx


