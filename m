From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 message length
Date: Mon, 19 Jan 2015 10:13:09 +0100
Message-ID: <20150119091309.GB18293@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org>
 <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <loom.20150116T143025-691@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:52418 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbASJNb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Jan 2015 04:13:31 -0500
Content-Disposition: inline
In-Reply-To: <loom.20150116T143025-691@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Laurent Vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org

Hey Laurent,

> Hi Kurt,
> > 
> > Hey,
> > 
> > On Mon, Dec 15, 2014 at 08:58:14AM +0000, pfifre.ext <at> orange.com 
> wrote:
> > > Hi Kurt,
> > > 
> > > I resolved the issue. The problem appears with long message because, 
> according to the j1939
> > specifications, the end of message has to be fulfilled with 0xFF if the 
> message is not modulo 8.
> > > Apparently, the j1939  drivers don't make the padding with 0xFF.
> > 
> > You're not the first to find an actual ECU complaining on this.
> > I assembled a patch earlier this year, see http://lists.kde.org/?l=linux-
> can&m=139825572207448&w=2
> > 
> > > Then I do that in my software and it works fine know.
> > 
> > I advise to apply that patch, and avoid to calculate packet sizes in 
> userspace.
> 
> I've seen this message concerning a bug in the DLC can frame when a more 
> than 8 bytes J1939 frame is sent.
> 
> Looking at the patch, it seems that every j1939 frame will be padded with 
> 0xFF, even single frame (less than 8 bytes).
> I think this is an error as standard SAEJ1939-21 specifies that for example 
> PGN request (0xEA00) is 3 byes length, and so can frame dlc must be 3 set 
> to 3.

You're right,
0xea00 indeed is defined as 3 bytes.

If I recall correctly, J1939 defines _all_ but 0xea00 to be 8 bytes long,
and use padding when not all bytes are used.
Your example happens to be the one and only exception.

> 
> May be the patch should be move on the transport module who manage Data 
> transfer protocol?

After thinking again, I realize that moving the fix to the transport protocol
would solve the problem without introducing any unwanted side effects.
Ensuring that single frames are padded to 8 bytes may be considered
a freedom/responsability of the userspace program.

> Is there something i missed?

Apparently not :-)

Kind regards,
Kurt
