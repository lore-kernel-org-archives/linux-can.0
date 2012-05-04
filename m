From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Wireshark / libpcap - was Re: [RFC] CAN FD support part 2 -
 ideas and commented source
Date: Fri, 4 May 2012 11:29:37 +0200
Message-ID: <20120504092937.GA420@vandijck-laurijssen.be>
References: <4FA242D0.2070604@hartkopp.net>
 <4FA268B2.8030109@hartkopp.net>
 <20120503123755.GD416@vandijck-laurijssen.be>
 <4FA27F18.9080106@hartkopp.net>
 <4FA2C7FC.9070103@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:19524 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab2EDJ3m (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 4 May 2012 05:29:42 -0400
Content-Disposition: inline
In-Reply-To: <4FA2C7FC.9070103@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Felix Obenhuber <felix@obenhuber.de>, linux-can@vger.kernel.org

On Thu, May 03, 2012 at 08:01:32PM +0200, Oliver Hartkopp wrote:
> On 03.05.2012 14:50, Oliver Hartkopp wrote:
> 
> > On 03.05.2012 14:37, Kurt Van Dijck wrote:
> 
> 
> >> I don't see benefit in introducing ETH_P_CANFD.
> >> Using the skb's payload length differentiates enough between CAN_MTU & CANFD_MTU.
> >> Why not using that info. IMHO, ETH_P_CANFD duplicates the info.
> > 
> > 
> > This has a big advantage when thinking about wireshark & friends.
> > 
> > You can look into the eth protocol and know the skb data layout.
> > The length information is some kind of implicit knowledge.
> 
Oliver,

Thanks for the explanation.
It shows how ETH_P_XXX values escape from kernel space.
It thus promotes to a part of the ABI, which I did not yet realize :-).

But you did not address my other concern, why you use
different values for CAN & CANFD.

> > You can look into the eth protocol and know the skb data layout.
Again, both layouts are compatible.

> > The length information is some kind of implicit knowledge.
Again, there are so many checks to fix the length to one of 2 available
MTU's that I doubt the implicit character of the lenght information
for the CAN situation.

I appreciate your effort in digging up Felix's original posts.
His opinions on this may be very usefull.

Kurt

[...]
> 
> For that reason and because of the reference to <linux/if_ether.h> i think
> it's pretty relevant to wireshark and libpcap - that's why i added Felix in CC.
> 
> http://sourceforge.net/tracker/?func=detail&aid=2872132&group_id=53067&atid=469579
> 
> Regards,
> Oliver
> 
