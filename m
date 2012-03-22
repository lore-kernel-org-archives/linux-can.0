From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 10:57:30 +0100
Message-ID: <20120322095730.GC426@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de>
 <20120321110502.GA3372@vandijck-laurijssen.be>
 <4F69BEE3.2040705@pengutronix.de>
 <20120321120846.GB3372@vandijck-laurijssen.be>
 <4F69CA74.3020607@pengutronix.de>
 <4F69D5D2.5080003@hartkopp.net>
 <20120321135339.GB6428@vandijck-laurijssen.be>
 <4F69EC19.7090205@grandegger.com>
 <4F69EE38.9000904@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:35080 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757303Ab2CVJ5d (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Mar 2012 05:57:33 -0400
Content-Disposition: inline
In-Reply-To: <4F69EE38.9000904@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
> 
> >>>
> >>> I think it's much more tricky to find a proper solution here.
> >> As I mentioned before, I just use CAN_RAW with this. Actually, I just
> >> ran a real CAN program that I wrote years ago. It still operates!
> > 
> > Would you program still run if the payload is bigger than 8 bytes?
> > I agree with Oliver.
> 
The other side would have noticed at design time that it cannot
send >8 bytes :-)

Did I miss something here? Is there a reason why existing programs
may or should not work on a CANFD bus? I wanted to incorporate
CANFD functionality _without_ putting an alternative API next to the
current one, so to be able to use existing binaries on a future
CANFD bus _without_ recompile (and thus not using the extras
possibilities for that program).
> 
> puh. Time for a coffee :-)
Ack
> 
regards,
Kurt
