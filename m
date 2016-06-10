From: Andy Haydon <ahaydon@moog.com>
Subject: Re: =?utf-8?b?Y19jYW4=?= driver sometimes sends first two bytes filled with zeros
Date: Fri, 10 Jun 2016 13:12:44 +0000 (UTC)
Message-ID: <loom.20160610T145714-753@post.gmane.org>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local> <574349BB.3010703@grandegger.com> <0120733A154AE74CA608A286CE7FFD2621DD3945@rg-contact.RG.local> <574EDEA3.5090204@grandegger.com> <loom.20160610T122431-248@post.gmane.org> <575AB8A7.6090102@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44958 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbcFJNM4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 10 Jun 2016 09:12:56 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bBMF2-0002Zn-CJ
	for linux-can@vger.kernel.org; Fri, 10 Jun 2016 15:12:52 +0200
Received: from mail2.uk.moog.com ([195.33.118.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2016 15:12:52 +0200
Received: from ahaydon by mail2.uk.moog.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 10 Jun 2016 15:12:52 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Wolfgang,

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> Hello Andy,
> 
> Am 10.06.2016 um 12:49 schrieb Andy Haydon:
> > Hi Wolfgang,
> >
> > Wolfgang Grandegger <wg <at> grandegger.com> writes:
> >
> >>
> >> Making "priv->write_regs() atomic is something I would try as well. My
> >> suspicion is that something goes wrong writing(/reading) the controller
> >> registers.
> >
> > We have also been looking at a similar issue over the last few days. In 
our
> > case, bytes 0 and 1 and bytes 4 and 5 of an 8 byte message can be 
corrupted
> > randomly - not necessarily zeroed. Bytes 2 and 3 and bytes 6 and 7 are 
never
> > corrupted. The Tx task is running as a high priority real time thread in
> > PREEMPT_RT.
> >
> > I've found that so far the only thing that fixes this issue is to 
perform
> > the writes to the data registers as 32 bit operations something like 
this
> > (for 3.18.20):
> >
> > --- a/drivers/net/can/c_can/c_can.c	2015-08-07 20:08:04.000000000 +0100
> > +++ b/drivers/net/can/c_can/c_can.c	2016-06-09 14:46:51.497895357 +0100
> >  <at>  <at>  -331,9 +332,19  <at>  <at> 
> >
> >   	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
> >
> > -	for (i = 0; i < frame->can_dlc; i += 2) {
> > -		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
> > -				frame->data[i] | (frame->data[i + 1] << 8));
> > +// this doesn't work for Cyclone V
> > +//	for (i = 0; i < frame->can_dlc; i += 2) {
> > +//		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
> > +//				frame->data[i] | (frame->data[i + 1] << 8));
> > +
> > +// replaced with this as a workaround
> > +	u32 data = 0;
> > +	for (i = 0; i < frame->can_dlc; i += 4) {
> > +		data = (u32)frame->data[i];
> > +		data |= (u32)frame->data[i + 1] << 8;
> > +		data |= (u32)frame->data[i + 2] << 16;
> > +		data |= (u32)frame->data[i + 3] << 24;
> > +		priv->write_reg32(priv, C_CAN_IFACE(DATA1_REG, iface) + i /
> > 2, data);
> >   	}
> >   }
> 
> Interesting observation! Richard (on CC now), does the patch also fix 
> your similar issues?
> 
> > At the moment I can't explain this behaviour, or if this is really the 
only
> > way to fix the issue for the Cyclone V.
> 
> Maybe the hardware does not like the 16-bit accesses. BTW: How is the 
> device configured? C_CAN with 32-bit accesses or D_CAN? Anyway, real 
> 32-bit accesses would be faster anyway.

The peripheral is D_CAN with 32-bit registers. 
There are many other 16-bit accesses in the driver, but it is only the data 
registers that seem not to like them. And the read from the data registers 
works fine as 16-bit accesses.
I agree that 32-bit accesses would be faster in this case. If we were to 
make a kernel patch, would the correct way to do it be to add a 32-bit 
access property to the d_can device tree binding?

> 
> > The tests that I've done so far seem to indicate that the data is 
correct
> > in the driver right up to the point at which it is actually written to 
the
> > CAN peripheral registers, so I think that your suspicion is correct.
> 
> Maybe some hardware guys from Altera could help.

I've created a service request with Altera. Hopefully I can eventually get 
this investigated by their hardware guys.

Regards,
Andy




