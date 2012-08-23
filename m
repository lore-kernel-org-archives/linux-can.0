From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: loopback  problem with BCM, RAW using,   Daniele Venzano
Date: Thu, 23 Aug 2012 20:35:45 +0200
Message-ID: <50367801.30707@hartkopp.net>
References: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com> <1899121230.725766.1345205637801.JavaMail.open-xchange@webmail.strato.de> <20120822085708.GB420@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:33420 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933998Ab2HWSfy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Aug 2012 14:35:54 -0400
In-Reply-To: <20120822085708.GB420@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org, Mahesh.Maharjan-EXT@continental-corporation.com

On 22.08.2012 10:57, Kurt Van Dijck wrote:

> Oliver,
> 
> I did not follow this thread in depth.
> 
> The patch looks minimal, but I doubt its usefullness.
> In a proper designed CAN system, each node uses distinct CAN-ids.
> Therefore, filtering out local traffic can always be accomplished
> with the current filtering (RTR frames are an exception, but are
> irrelevant here).
> 
> userspace can test flags (MSG_DONTROUTE) to decide if a received
> frame is from <localhost> or remote.
> So I don't see the problem that you're addressing with this patch.


Hello Kurt,

this was a quick shot.

After thinking a bit more on this idea, this sockopt is something like an
additional filter. But then i needs to have two bits:

- receive rx frames (from the outside)
- receive tx frames (from the local host)

Default is to receive both types of frames ...

Btw. i don't know if this additional sockopt makes it even more complicated
for users or if your suggestion to select the frames after reception in the
userspace is better.

Regards,
Oliver

ps. the CAN FD capable 'candump' now prints the RX/TX info on demand too.
