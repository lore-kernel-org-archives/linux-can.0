From: "Gerhard Bertelsmann" <info@gerhard-bertelsmann.de>
Subject: RE: [PATCH] mcp251x: mcp2515 stops receiving
Date: Thu, 22 May 2014 18:08:47 +0200 (CEST)
Message-ID: <4902.212.149.48.42.1400774927.squirrel@webmail.rdts.de>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
    <5370FE36.8020901@pengutronix.de> <20140521235346.GA15375@griso.site>
    <2E9F00CBB66AB544A1ACDC59627518BA0DC96DCF@mailserver>
Reply-To: info@gerhard-bertelsmann.de
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:50113 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477AbaEVQOv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 22 May 2014 12:14:51 -0400
Received: from webmail.rdts.de (unknown [195.243.153.19])
	by mail.rdts.de (Postfix) with ESMTP id ED8A5A071F
	for <linux-can@vger.kernel.org>; Thu, 22 May 2014 18:08:47 +0200 (CEST)
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA0DC96DCF@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

interesting conversation here regarding the mcp251x module ...

Am Do, 22.05.2014, 08:38, schrieb Rost, Martin:
>
> Hello John,
>
>> -----Original Message-----
>> From: linux-can-owner@vger.kernel.org [mailto:linux-can-
>> owner@vger.kernel.org] On Behalf Of John Whitmore
>> Sent: Thursday, May 22, 2014 1:54 AM
>> To: Marc Kleine-Budde
>> Cc: Rost, Martin; linux-can@vger.kernel.org; Alexander Shiyan
>> Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
>>
>> I'm not an expert in the Linux Driver code nor the implemented fix but I can
>> confirm that the Interrupt is generated with no flags set. I'm not sure of the
>> 10mS timing but I'd imagine that should work.
>>
>
> Thanks for confirming it.
> I fiddled a bit with the timing, and it seemed that 5ms would catch some but not all occurrences
> of this problem.
> So I went for 10 to make sure.
>
> I'm not too deep into kernel internals, so is there some best practice to this?
>
> Regards,
> Martin
>

IMHO a delay isn't a good idea. I've spent lots of hours in fron of my osci
http://www.raspberrypi.org/forums/viewtopic.php?f=44&t=7027&start=103
to get the MCP2515 working with RPi. After fiddling the GPIOs for the MCP2515
interrupt I got a working setup with the RPI and 3.1.x+ kernel. The setup was
stable even after upgrading to 3.2.x+ kernel. There were packet losts if the
CAN frame rate was high but the interface was "stable" - no hangup.

Things got worse after upgrading to 3.6.x+ kernel. The driver wasn't stable
anymore - the interface hang due to missed interrupts. From my point of view
this has to do with the IRQF_ONESHOT. The drivers have to set this flag in newer
kernels if you don't have a primary IRQ handler - the MCP2515 doesn't use it,
because the interrupt will be cleared if you read the buffer for example. This
is a feature of the CAN-Controller and the kernel module use it to reduce
SPI requests.

AFAIK the IRQF_ONESHOT feature was added to avoid endless interrupt retriggering.
But a retrigger is needed by the mc251x module: If you read the first buffer,
there must be a second interrupt if the second buffer is also full.

If you are curious you could do the following test: Write some (useless) code into the
primary IRQ routine:

static irqreturn_t mcp251x_can_hardirq(int irq, void *dev_id)
{
        ....
        return IRQ_WAKE_THREAD;
}
...
static int mcp251x_open(struct net_device *net)
{
...
        ret = request_threaded_irq(spi->irq, mcp251x_can_hardirq, mcp251x_can_ist,
                  pdata->irq_flags ? pdata->irq_flags : IRQF_TRIGGER_FALLING,
                  DEVICE_NAME, priv);


to avoid the IRQF_ONESHOT flag to be set. There is no guarantee that this will work,
of course. But give it a try ;-)

Regards

Gerd


