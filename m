From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: iMX28 and CAN Error frames
Date: Sun, 17 Mar 2013 20:00:42 +0100
Message-ID: <514612DA.6060106@grandegger.com>
References: <1EF5AE0C0C5487498E14A50D915B97933B0A4DB586@GBLONZ-PMSGEM05.emrsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:41810 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553Ab3CQTAp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 17 Mar 2013 15:00:45 -0400
In-Reply-To: <1EF5AE0C0C5487498E14A50D915B97933B0A4DB586@GBLONZ-PMSGEM05.emrsn.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tobias.Grueninger@Emerson.com
Cc: linux-can@vger.kernel.org

Hi Tobias,

On 03/15/2013 05:16 PM, Tobias.Grueninger@Emerson.com wrote:
> Hi,
> 
> I have trouble in receiving error frames on my freescale iMX28 board.
> Linux mx28 2.6.35.3-g880e772 #35 Mon Jul 30 15:04:31 CEST 2012 armv5tejl GNU/Linux

The Flexcan driver hit mainline in 2.6.36. Therefore the first question
is where the driver comes from. Is this a kernel from Freescale? Any
chance to switch to a recent mainline kernel version?

> In normal operation, many telegrams are received and some are sent from the iMX28.
> 
> Now I want to implement the error handling. After many trials, I am now out of my wisdom..

Error handling should work properly in recent version of the Flexcan
driver (from the mainline kernel).

> 
> The situation is that when I craft manually an error frame and send this on my console to can0
>       cansend can0 20000040#
> 
> then my application does nicely receive this: (/* are my comments)
> ************
>       virtual void OCanModelPrivate::run(): current telegram: 0X14042240 /* Normal telegram, frame.can_id & CAN_EFF_MASK
>       >>>send error frame from other console
>       virtual void OCanModelPrivate::run(): current telegram:     0X40 /* the error frame
>       CAN_ERR_FLAG raised: CAN_ERR_BUSOFF /*debug output
>       run: 20000040 0 - 00 00 00 00 - 00 00 00 00 /*debug output
> *************
> 
> But, if I e.g. short circuit the CAN Bus to provoke a real Bus Off problem:
> ***********
> 	virtual void OCanModelPrivate::run(): current telegram: 0X140222C0
> 	virtual void OCanModelPrivate::run(): current telegram: 0X80422C0
> 	>>>CAN short circuit
> 	/* nothing happens..
> 
> 	virtual void OCanModelPrivate::run(): no data in the last 5s /* comes from select() timeout
> 	OCanModelPrivate::run():FD_ISSET == 0 , no data read possible from CAN0: /* comes from "if (FD_ISSET(s, &rdfs)) {..} else{.."
> 	virtual void OCanModelPrivate::run(): no data in the last 5s
> 	OCanModelPrivate::run():FD_ISSET == 0 , no data read possible from CAN0: 
> 	OCanModelPrivate::sendMessage:write: No buffer space available  /* comes from "if ((nbytes = write(s, &frame, sizeof(frame))) != sizeof(frame))"
> 	OCanModelPrivate::sendMessage:write: No buffer space available
> 	virtual void OCanModelPrivate::run(): no data in the last 5s
> 	OCanModelPrivate::run():FD_ISSET == 0 , no data read possible from CAN0: Success
> 	OCanModelPrivate::sendMessage:write: No buffer space available
>       OCanModelPrivate::sendMessage:write: No buffer space available
> **************
> 
> The Error mask is this:
> 	can_err_mask_t err_mask = CAN_ERR_MASK;
> 	if ( setsockopt(d->s, SOL_CAN_RAW, CAN_RAW_ERR_FILTER, &err_mask, sizeof(err_mask)) ) {.}
> 
> Where can be searched, or what did I not understood?

See above. Have a look to

http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c

Wolfgang.

