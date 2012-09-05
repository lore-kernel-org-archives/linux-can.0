From: Puneet Sharma <puneet.sharma@moschip.com>
Subject: Re: CAN device filterting
Date: Wed, 5 Sep 2012 14:58:59 +0530
Message-ID: <1346837339.2993.3.camel@punsfloyd-desktop>
References: <1346765466.5440.3.camel@punsfloyd-desktop>
	 <504604E3.1040305@hartkopp.net> <504608CB.9080709@pengutronix.de>
	 <50463205.8050705@hartkopp.net>  <504636B6.7070907@pengutronix.de>
Reply-To: puneet.sharma@moschip.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lexus.moschip.com ([115.118.5.150]:16397 "EHLO
	LEXUS.MOSCHIP.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792Ab2IEJaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Sep 2012 05:30:21 -0400
In-Reply-To: <504636B6.7070907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, 2012-09-04 at 22:43 +0530, Marc Kleine-Budde wrote:
> On 09/04/2012 06:53 PM, Oliver Hartkopp wrote:
> > On 04.09.2012 15:57, Marc Kleine-Budde wrote:
> >
> >> On 09/04/2012 03:40 PM, Oliver Hartkopp wrote:
> >>> On 04.09.2012 15:31, Puneet Sharma wrote:
> >>>
> >>>> I need some guidance on implementing the CAN filtering of identifier in
> >>>> the driver code of CAN for atmel AT91SAM9263 board. Please guide me how
> >>>> to proceed with it..
> >>>
> >>>
> >>> Hm - i wrote that some days ago:
> >>
> >> I talked to Puneet in private before, if I understand him correctly he
> >> wants to implement hardware filtering, although software filtering is
> >> available.
> >
> >
> > Ah, ok.
> >

   Hello,
        Marc is correct. I want to implement hardware filtering. Need
some guidance on this how to proceed with it ?

> >> From my point of view it should become a per device callback, which you
> >> (admin, i.e. the root user) can set when the device is down. You have to
> >> extend the CAN netlink interface [1].
> >
> >
> > Good idea.
> >
> >> Each device should identify what kind and how many hardware filters it
> >> supports:
> >> a) mask+id
> >> b) just id
> >> c) ...
> >> Analogue to ctrlmode [2][3].
> >
> >
> > Yes. Could be ambitious. E.g. a 2048 bit bitfield is an option too :-)
> >
> > The question is, if the usual mailbox configurations in CAN controller
> > IP-cores can be stripped down to 2-3 standard types of filters, so that a good
> > interface can be specified.
>
> id+mask is quite common.
>

id+mask is what will be required for the driver.
> Marc
>

--
Puneet Sharma <puneet.sharma@moschip.com>


The information contained in this email and any attachments is confidential and may be subject to copyright or other intellectual property protection. If you are not the intended recipient, you are not authorized to use or disclose this information, and we request that you notify us by reply mail or telephone and delete the original message from your mail system.
