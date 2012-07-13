From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 3/3] can: janz-ican3: add support for one shot mode
Date: Fri, 13 Jul 2012 16:05:21 -0700
Message-ID: <20120713230521.GD4538@ovro.caltech.edu>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
 <1342109732-4995-4-git-send-email-iws@ovro.caltech.edu>
 <4FFFE366.8000707@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:51468 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167Ab2GMXFY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 19:05:24 -0400
Content-Disposition: inline
In-Reply-To: <4FFFE366.8000707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Fri, Jul 13, 2012 at 10:59:18AM +0200, Marc Kleine-Budde wrote:
> On 07/12/2012 06:15 PM, Ira W. Snyder wrote:
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > The Janz VMOD-ICAN3 hardware has support for one shot packet
> > transmission. This means that a packet will be attempted to be sent
> > once, with no automatic retries.
> > 
> > The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.
> 
> What happens to the queued to-be-echoed CAN frames if the device fails
> to send a CAN frame, due to one shot mode?
> 

I borrowed the hardware and tested this. I generated bus problems by
unplugging the cable from the card.

With "berr-reporting off" I get no indication from the firmware that
there is any problems until ERROR-WARNING (96 errors) or ERROR-PASSIVE
(128 errors) state is reached.

With "berr-reporting on", I get a bus-error message for every message I
try to send. It looks like this:

  can0  20000088  [8] 00 00 80 19 00 00 08 00   ERRORFRAME
        protocol-violation{{error-on-tx}{acknowledge-slot}}
        bus-error
        error-counter-tx-rx{{8}{0}}

The TX error count increases by 8 for each packet. My CAN book seems to
say this is the correct behavior when the bus is unconnected.

I fixed the echo skb problem (see my patch in reply to this) by always
enabling bus errors, and using those to know when packet transmission
failed. In testing, it works well. Please take that patch instead of
this one.

Thanks for the review.

Ira

> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


