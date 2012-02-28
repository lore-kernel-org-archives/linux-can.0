From: Wolfgang Wagner <wutz@unterderbruecke.de>
Subject: Re: Transport Protocol: example
Date: Tue, 28 Feb 2012 15:21:17 +0000 (UTC)
Message-ID: <loom.20120228T151322-857@post.gmane.org>
References: <loom.20120113T122554-557@post.gmane.org> <loom.20120116T103812-141@post.gmane.org> <20120116133140.GA26427@e-circ.dyndns.org> <loom.20120116T153805-349@post.gmane.org> <20120116153644.GA7763@e-circ.dyndns.org> <loom.20120207T160415-497@post.gmane.org> <20120208084602.GA412@e-circ.dyndns.org> <loom.20120216T104829-444@post.gmane.org> <20120216194911.GA447@e-circ.dyndns.org> <loom.20120224T154038-289@post.gmane.org> <20120228104605.GA495@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58012 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965500Ab2B1PVi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 28 Feb 2012 10:21:38 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1S2Orv-0006Y9-N4
	for linux-can@vger.kernel.org; Tue, 28 Feb 2012 16:21:35 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2012 16:21:35 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2012 16:21:35 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

thanks I lot, I think I got it.

> I now realize I was a bit fast in my previous post by saying you send
> 0xf0 bytes, since you tried to send 0xf000 bytes, which is only
> possible with the extended transport protocol as defined in
> iso11783-6 (and supported by your kernel).

Acutally I wanted to send 0x00f0 bytes, I am still confused with msb and lsb.
 
> I also used PGN 0x00ee00, which I already said was not a good idea, but
> it may not fail the demonstration ...

Ok this was an accident, acutally I should know that 00ee00 is for ac!

>So I did:
>$ jsr vcan0:80,00ee00 :00 < moose.txt (dummy text file)

Yes, this is working - when I am fast enough sending with the simulator 
software the TP.CM_CTS. Of course with can0 or can1.



> To make the story complete, I also did a broadcasted transport protocol.
> $ jsr vcan0:80,00ee00 < moose.txt

This is working as well!

> 
> I believe that these examples may answer a lot of your questions .

Definitely. 
 
> > Is it possible if everything is done right to bridge the TP.CM and TP.DT
> > directly with the previous implementation?
> > 
> >The bridge you're making will bridge the packets on j1939 level, which is
> >for transport protocol different than bridging on CAN level.
> >This means that after the entire transport protocol is received on can0,
> >transmission starts on can1.

I should be no problem!

Just whether I understood it right:

My "ECU" makes the negotiation with the sending node and write the TP.CM_RTS 
and the TP.DT in the socket and after the complete reception it makes the 
negotiation with the other node with sending the TP.CM_RTS and than sends the
TP.DT?

--Wolfgang







