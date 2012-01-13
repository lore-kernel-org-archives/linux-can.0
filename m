From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: bridging with can-gw
Date: Fri, 13 Jan 2012 12:12:51 +0100
Message-ID: <20120113111251.GD319@e-circ.dyndns.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
 <loom.20120109T162926-984@post.gmane.org>
 <20120110085105.GB330@e-circ.dyndns.org>
 <loom.20120110T112815-928@post.gmane.org>
 <20120110152341.GD2524@e-circ.dyndns.org>
 <loom.20120112T155904-850@post.gmane.org>
 <4F0F2195.7050109@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:7006 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757880Ab2AMLMy (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 13 Jan 2012 06:12:54 -0500
Content-Disposition: inline
In-Reply-To: <4F0F2195.7050109@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang <wutz@unterderbruecke.de>, linux-can@vger.kernel.org

On Thu, Jan 12, 2012 at 07:08:21PM +0100, Oliver Hartkopp wrote:
> On 12.01.2012 16:23, Wolfgang wrote:
> 
> > is it possible when I create a promiscuous socket with 
> > ...
> > 
> > static struct {
> > 	struct sockaddr_can src;
> > 	int pkt_len;
> > } ss = {
> > 	.pkt_len = 1024,
> > 	.src.can_addr.j1939 = {
> > 		.name = J1939_NO_NAME,
> > 		.addr = J1939_NO_ADDR,
> > 		.pgn = J1939_NO_PGN,
> > 	},
> > };
> > ....
> > addr.can_ifindex = ss.src.can_ifindex;
> > ...
> > 
> > and then receive a msg with recvfrom and  send that msg with sendto to tell 
> > the promiscuous socket to ignore the send msg. That the promiscuous socket only
> > receives 'extern' messages. I am totally floored, or am I on the wrong track?
> 
> 
> Hello Wolfgang,
> 
> as you are always writing about the bridging of J1939 frames - what does this
> mean on the bus?
> 
> Do you only bridge single frames?

The idea has crossed my mind also that when only single frames are bridged,
a raw cangw may suit the need.
A cangw setup _may_ not suit when transport protocol comes in place...
> 
Kurt
