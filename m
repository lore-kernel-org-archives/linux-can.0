From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: API calls
Date: Tue, 20 Dec 2011 17:32:47 +0100
Message-ID: <20111220163247.GE311@e-circ.dyndns.org>
References: <20111216083708.GA323@e-circ.dyndns.org>
 <loom.20111216T095547-967@post.gmane.org>
 <20111216093308.GB669@e-circ.dyndns.org>
 <loom.20111216T150333-707@post.gmane.org>
 <20111217192038.GA309@e-circ.dyndns.org>
 <loom.20111220T112550-205@post.gmane.org>
 <20111220110059.GA311@e-circ.dyndns.org>
 <loom.20111220T150849-247@post.gmane.org>
 <20111220150545.GC311@e-circ.dyndns.org>
 <loom.20111220T160841-487@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:40723 "EHLO eia-vsv02.eia.lan"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751193Ab1LTQcu (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 20 Dec 2011 11:32:50 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111220T160841-487@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Tue, Dec 20, 2011 at 03:43:13PM +0000, Wolfgang wrote:
> I was a bit hasty. It is not working, but I don't get it. Eclipse is saying 
> bind failed: Invalid argument
I went into the code. I forgot to add:
     addr.can_family = AF_CAN;
I think this is what is missing.

> send failed: Destination address required
Yep, since bind failed, you will not be able to use the socket already (man socket).

I just pushed a commit into linux-can-j1939. You may decide to merge it into
your kernel. I found that the test for 'bind succeeded' is wrong in sendmsg.
Therefore, you get some error because you really did not bind yet, but
after the patch, you will get the error ENOTCONN, which is very appropriate.
> 
> How is a frame send with id and data, like when you do $cansend can0 
> -ei0x123ff80 0xFF. Because only data is sent now?

The ID is composed from the address information you supplied earlier
with bind(), connect() and/or sendto().
This is different with CAN raw, but remind that CAN raw does not imply addressing
on the bus neither. 

can-j1939 does export an address concept to userspace, and verifies that
you're not cheating on the bus. And the modules thus allow to
do transport protocol with addressing verified.

So, to summarize, you may later on start using sendto(), and supply
an address structure with destination address and/or PGN set.

Kurt

