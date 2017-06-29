From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: CAN-FD Transceiver Limitations
Date: Fri, 30 Jun 2017 00:36:32 +0200
Message-ID: <20170629223551.GA6568@airbook.vandijck-laurijssen.be>
References: <de1f6343-4b28-4a5f-c6df-4e54c09fcce2@ti.com>
 <20170629142142.GF9244@lunn.ch>
 <5d4f2bcf-bd0f-4fa1-5d5a-d7b4a83cbc5e@ti.com>
 <20170629154139.GC13221@lunn.ch>
 <c0d3d772-6939-d22c-b954-3ba6486a9ede@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:35866 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF2WhY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jun 2017 18:37:24 -0400
Content-Disposition: inline
In-Reply-To: <c0d3d772-6939-d22c-b954-3ba6486a9ede@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-can@vger.kernel.org, netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, devicetree@vger.kernel.org

> >>
> >> mcan@0 {
> >> 	...
> >> 	fixed-transceiver {
> >> 	      max-canfd-speed = <2000>
> >> 	};
> >> 	...
> >> };

Since when would a transceiver support different speeds for CAN & CANFD?
No transceivers were available, but they are now.
I see no datalink problem applying 2MBit for regular CAN with apropriate
physical layer, and CAN does not predefine the physical layer
(advise != define).

IMHO,
	fixed-transceiver {
		max-arbitration-speed = <2000000>
		max-data-speed = <4000000>
	};
is way better to describe the hardware.
Regular CAN chips would not consider max-data-speed...

Kind regards,
Kurt
