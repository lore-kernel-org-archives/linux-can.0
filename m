From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: recv list
Date: Thu, 12 Jan 2012 16:43:53 +0100
Message-ID: <20120112154353.GK380@e-circ.dyndns.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
 <loom.20120109T162926-984@post.gmane.org>
 <20120110085105.GB330@e-circ.dyndns.org>
 <loom.20120110T112815-928@post.gmane.org>
 <20120110152341.GD2524@e-circ.dyndns.org>
 <loom.20120112T155904-850@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:49753 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab2ALPsy (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Jan 2012 10:48:54 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120112T155904-850@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Jan 12, 2012 at 03:23:43PM +0000, Wolfgang wrote:
> Hi,
> 
> is it possible when I create a promiscuous socket with 
> ...
> 
> static struct {
> 	struct sockaddr_can src;
> 	int pkt_len;
> } ss = {
> 	.pkt_len = 1024,
> 	.src.can_addr.j1939 = {
> 		.name = J1939_NO_NAME,
> 		.addr = J1939_NO_ADDR,
> 		.pgn = J1939_NO_PGN,
> 	},
> };
> ....
> addr.can_ifindex = ss.src.can_ifindex;
> ...
> 
> and then receive a msg with recvfrom and  send that msg with sendto to tell 
> the promiscuous socket to ignore the send msg. That the promiscuous socket only
> receives 'extern' messages. I am totally floored, or am I on the wrong track?

I think you are looking to 'avoid receiving msgs that you just sent yourself'.
We had such issue solved in can_raw some time ago, and I put the same mechanism
in can-j1939.
I'll come back on that tomorrow ...

You may look at socket option SO_J1939_RECV_OWN, and flag MSG_DONTROUTE in recvmsg.

Kurt
