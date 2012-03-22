From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 10:24:56 +0100
Message-ID: <20120322092456.GB426@vandijck-laurijssen.be>
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
Received: from gate.eia.be ([194.78.71.18]:32340 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756566Ab2CVJZA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 Mar 2012 05:25:00 -0400
Content-Disposition: inline
In-Reply-To: <4F69EE38.9000904@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
> 
> > Also DLC=9 means 12 bytes, DLC=10 means 16 bytes, DLC=15 means 64 bytes.
> > This may even change in the final spec.
> 
> Yep!

Although the precise coding is not final yet, I'd propose to not use that coding
in the ABI for these reasons:
* The reason of fitting a DLC in 4 bits makes sense on the wire
  but not on the ABI. We still use an u8!
* Decoding & encoding between real length & DLC IMO is best done next to the
  chips register access.

> 
> 
> > 
> >>> 3. Will these differences be visible in the CAN registers? Is this relevant?
> >> Without hardware, it's a bit early to predict. I guess it will be visible, but
> >> not relevant since that's driver stuff.
> > 
> > As CANFD controllers also supports CAN2.0 frames, they must provide the
> > the relevant information somehow, similar to EFF and SFF.
I doubt this.
EFF & SFF share the same bus. CANFD vs. CAN2.0 is not a per-frame thing. You
have configured it yourself at chip initialization time...
> > 
> >> I did not get into real drivers yet...
> >>>
> >>> What i got from the iCC was that when you have a partly migrated network and
> >>> you want to run e.g. a fast firmware upload between two CAN FD capable nodes,
> >>> the other (standard CAN 2.0b) nodes have to be in listen only mode to not jam
> >>> the bus with error frames.
> > 
> > Due to the bit-rate switching, a assume.
> 
> 
> Yes - the 'old' controllers would put error frames on the fast payload data.
> 
FYI: The bitrate switch is not the only cause.
The bitstream on the wire for 'equal' CANFD & CAN2.0 frames is different.
A regular CAN2.0 chip will signal protocol violations.
> 

Kind regards,
Kurt
