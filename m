From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 10:03:12 +0100
Message-ID: <20120322090312.GA426@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
 <20120321110502.GA3372@vandijck-laurijssen.be>
 <4F69BEE3.2040705@pengutronix.de>
 <20120321120846.GB3372@vandijck-laurijssen.be>
 <4F69CA74.3020607@pengutronix.de>
 <4F69D5D2.5080003@hartkopp.net>
 <20120321135339.GB6428@vandijck-laurijssen.be>
 <4F69EA75.1070202@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:50494 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964786Ab2CVJDR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Mar 2012 05:03:17 -0400
Content-Disposition: inline
In-Reply-To: <4F69EA75.1070202@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 03:49:25PM +0100, Oliver Hartkopp wrote:
> On 21.03.2012 14:53, Kurt Van Dijck wrote:
> 
> > On Wed, Mar 21, 2012 at 02:21:22PM +0100, Oliver Hartkopp wrote:
> > * ESI bit.
> 
> 
> Is something that IMO needs to go into the error message when set active.
nice idea!

[...]
> 
> >>
> >> What i got from the iCC was that when you have a partly migrated network and
> >> you want to run e.g. a fast firmware upload between two CAN FD capable nodes,
> >> the other (standard CAN 2.0b) nodes have to be in listen only mode to not jam
> >> the bus with error frames.
> >>
> >> After the firmware upload all the CAN nodes switch back to CAN2.0b mode (which
> >> has to be done by root netlink access).
> > Since CANFD is not bus compatible, the chip must go down & up.
> 
> 
> Really? We don't know so far.
You're right, this theory can never be proved to be right.
At least, I'll be supprised to see some form of dynamic switch.
> 

Regards,
Kurt
