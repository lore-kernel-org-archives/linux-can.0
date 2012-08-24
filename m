From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: loopback  problem with BCM, RAW using,   Daniele Venzano
Date: Fri, 24 Aug 2012 06:47:37 +0200
Message-ID: <20120824044737.GA1718@vandijck-laurijssen.be>
References: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com>
 <1899121230.725766.1345205637801.JavaMail.open-xchange@webmail.strato.de>
 <20120822085708.GB420@vandijck-laurijssen.be>
 <50367801.30707@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from Mailrelay020.isp.belgacom.be ([195.238.6.95]:23454 "EHLO
	mailrelay020.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750761Ab2HXErl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 24 Aug 2012 00:47:41 -0400
Content-Disposition: inline
In-Reply-To: <50367801.30707@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Mahesh.Maharjan-EXT@continental-corporation.com

On Thu, Aug 23, 2012 at 08:35:45PM +0200, Oliver Hartkopp wrote:
> On 22.08.2012 10:57, Kurt Van Dijck wrote:
> 
> > Oliver,
> > 
> > I did not follow this thread in depth.
> > 
> > The patch looks minimal, but I doubt its usefullness.
> > In a proper designed CAN system, each node uses distinct CAN-ids.
> > Therefore, filtering out local traffic can always be accomplished
> > with the current filtering (RTR frames are an exception, but are
> > irrelevant here).
> > 
> > userspace can test flags (MSG_DONTROUTE) to decide if a received
> > frame is from <localhost> or remote.
> > So I don't see the problem that you're addressing with this patch.
> 
> 
> Hello Kurt,
> 
> this was a quick shot.
> 
> After thinking a bit more on this idea, this sockopt is something like an
> additional filter. But then i needs to have two bits:
> 
> - receive rx frames (from the outside)
> - receive tx frames (from the local host)
> 
> Default is to receive both types of frames ...
> 
> Btw. i don't know if this additional sockopt makes it even more complicated
> for users ...

IMO, things get complicated.
Example: what should I get when
CAN_RAW_RECV_OWN_MSGS is set & CAN_RAW_RECV_HOST_MSGS is cleared?

> 
> Regards,
> Oliver
> 
> ps. the CAN FD capable 'candump' now prints the RX/TX info on demand too.
really nice.

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
