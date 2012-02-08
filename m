From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: sendmsg
Date: Wed, 8 Feb 2012 09:46:02 +0100
Message-ID: <20120208084602.GA412@e-circ.dyndns.org>
References: <20120110152341.GD2524@e-circ.dyndns.org>
 <loom.20120112T155904-850@post.gmane.org>
 <4F0F2195.7050109@hartkopp.net>
 <20120113111251.GD319@e-circ.dyndns.org>
 <loom.20120113T122554-557@post.gmane.org>
 <loom.20120116T103812-141@post.gmane.org>
 <20120116133140.GA26427@e-circ.dyndns.org>
 <loom.20120116T153805-349@post.gmane.org>
 <20120116153644.GA7763@e-circ.dyndns.org>
 <loom.20120207T160415-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:33712 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396Ab2BHIqG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 8 Feb 2012 03:46:06 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120207T160415-497@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Hey Wolfgang,

On Tue, Feb 07, 2012 at 03:11:13PM +0000, Wolfgang wrote:
> Hi Kurt,
> 
> I am back working a little my gw.
> 
> As the defined in the j1939-21 the maximum dlc is 1785. 

Yes.
This stack also supports the Extended Transport Protocol as defined
in iso11783-6, which extends to several MegaBytes...

> 
> static struct {
> 	int pkt_len;
> } s = {
> 	.pkt_len = 1024,
> };
> 
> buf = malloc(s.pkt_len);
> 
> recvmsg(sockfd, &msg, 0);
> 
> Did I get that right, that a dlc more than 1024 bytes is not possible with
> recvmsg or sendmsg.
That is not a limitation of recvmsg or sendmsg. 1024 in jspy.c is just
a decent default. Via options a different (bigger) packet size can be selected.
For a complete explanation, man 2 recvmsg, look for MSG_TRUNC.
That will explain what happens when I supply a buffer to recvmsg that is smaller
than the packet I'm receiving. The received packet is then truncated.

> For my application I won't need so many data
Most application don't need such packets ....
> but for understanding the code!
Very well!
> 
> Kind regards,
> Wolfgang
> 
> 
> I forget to mention, that I set s.pkt_len = 1785 and it seemed to work with
> sendmsg and recvmsg. But UIO_MAXIOV is defined as 1024, so what do I get wrong?
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
