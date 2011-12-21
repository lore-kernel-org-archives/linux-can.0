From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: using can-j1939
Date: Wed, 21 Dec 2011 16:53:14 +0100
Message-ID: <20111221155314.GC12050@e-circ.dyndns.org>
References: <20111217192038.GA309@e-circ.dyndns.org>
 <loom.20111220T112550-205@post.gmane.org>
 <20111220110059.GA311@e-circ.dyndns.org>
 <loom.20111220T150849-247@post.gmane.org>
 <20111220150545.GC311@e-circ.dyndns.org>
 <loom.20111220T160841-487@post.gmane.org>
 <20111220163247.GE311@e-circ.dyndns.org>
 <loom.20111221T111539-419@post.gmane.org>
 <20111221134302.GA12050@e-circ.dyndns.org>
 <loom.20111221T153828-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:60332 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751715Ab1LUPxR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Dec 2011 10:53:17 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111221T153828-216@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Wed, Dec 21, 2011 at 03:11:30PM +0000, Wolfgang wrote:
> > I bet len (= sizeof(frame.data) in your example) is 8.
> > If you want to send 3 bytes, then supply 3 bytes to the kernel!
> OK, so I set the unused bytes 0 and don't care.
you should not have unused bytes, but I believe you get the picture...
> 
> 
> > > So sendto() is used to send to a specific address, at the moment I am always
> > > doing broadcast?
> > yes.
> Maybe you can give me a hint what I did wrong
> ...
> addr.can_addr.j1939.name = 0x81;
> ....
> if (sendto(s, frame.data, strlen(frame.data), 0, (void *)&addr, \
> sizeof(frame.data))<0)
sendto(s, frame.data, strlen(frame.data), 0, (void *)&addr, sizeof(addr)/*!!!*/)
you supplied the sizeof frame.data, where you should supply the size of addr.

>     {
>     	perror ("sendto failed");
>     }
> 
> 
> One general question, am I right, you have to create for every different
> struct sockaddr_can (different pgn etc.) one socket per 
> interface?
You will want to create 1 socket per interface and per used source address.

You bind with can_addr.j1939.addr = 0x80 and can_addr.j1939.pgn = J1939_NO_PGN
then you can do sendto with dest_addr.j1939.sa = DEST address &
dest_addr.j1939.pgn = YOUR_PGN.

So, the latter YOUR_PGN may vary with each call.
The option to preset a PGN during bind() allows to use write & send on the socket
but is an inferior option in this regard.

Kurt
