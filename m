From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Adding new CAN driver
Date: Thu, 10 Nov 2016 10:18:30 +0100
Message-ID: <20161110091830.GB22657@airbook.vandijck-laurijssen.be>
References: <3113364.8FuUfmAlHQ@ws-stein>
 <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
 <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net>
 <SG2PR06MB1038E2022EEA5837EB6BD25BC3A60@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:57145 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbcKJJTB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 10 Nov 2016 04:19:01 -0500
Content-Disposition: inline
In-Reply-To: <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, =?utf-8?B?S2/FgsWCxIV0YWos?= Remigiusz <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> On 11/08/2016 10:36 AM, Ramesh Shanmugasundaram wrote:
> >>>>for now, IFLA_CAN_TERMINATION may be a boolean (or enumeration).
> >>>
> >>>ACK. We could start simple with a bool.
> >>
> >>I would suggest to support a variable resistor (varistor) ranging from 1
> >>to 65534 Ohms and a list of discrete termination values as suggested.
> >
> >If there are use cases for such variable resistor configs, it is OK.
> >
> 
> I double checked the varistors currently used in CAN context.
> They are used to provide ESD (electrostatic discharge) protection %-)
> 
> So having a discrete list of discrete termination resistors would obviously
> be sufficient for our use-case.

Up to now, I only saw systems that allow to enable 120Ohm, and no
other values are coming AFAIK.
This can be addressed as a 'list of discrete values' indeed.

[...]

> >
> >I think it can be something like this
> >
> >Board DTS file
> >&can0 {
> >	...
> >	can-termination = <120>;	/* default value */
> >	
> >	/* GPIO managed */
> >	can-term-gpio = <&gpio0 10 GPIO_ACTIVE_HIGH>;
> >	...
> >
> >	/* Regulator managed */
> >	can-term-supply = <&phandle to regulator node>
> >};

This GPIO you're using to activate the termination resistor is/should be
controlled independantly of the rest of your CAN driver.
Take this scenario: you activate the bus termination from the CAN
driver. Up to that point, the bus is not properly terminated, and other
nodes on the bus do not communicate (properly).
If you really depended on that termination, and it took that long in
order to enable, you would place the termination elsewhere.

It seems we're adding quite a lot just to make the system activate a GPIO that
does not want any interaction to the CAN subsystem (at least, I have not
seen any use case up to now justifying this).
Or am I missing something here?

Note that this applies to the CAN bus termination.
The transceiver settings on the other hand do interact with the CAN
driver (like limiting the max baudrate as an example, or activating the
TRX via a GPIO).

Kind regards,
Kurt
