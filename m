From: kernel@martin.sperl.org
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree bindings
Date: Thu, 30 Nov 2017 08:24:45 +0100
Message-ID: <612BB6CD-5330-40B8-A854-FD065E0A3331@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <20171124183509.12810-2-kernel@martin.sperl.org> <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop> <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org> <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:42140
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdK3HYs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Nov 2017 02:24:48 -0500
In-Reply-To: <0a7e4416-332a-5c23-bda3-8c7561410314@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hi Patrick!

> On 29.11.2017, at 21:35, Patrick Menschel <menschel.p@posteo.de> wrote:
> 
> Hello Martin,
> 
> 
> I didn't catch the whole discussion but you may want to check
> 
> include/dt-bindings/gpio/gpio.h
> 
>> #define GPIO_OPEN_DRAIN (GPIO_SINGLE_ENDED | GPIO_ACTIVE_LOW)
> 
> This corresponds to
> 
> Documentation/devicetree/bindings/gpio/gpio.txt

I understand, but the question still is: how to
present the information in a valid way.

To use gpio propperly it would require that the driver
implements a “sub-driver” pinctrl with all the extra
(boilerplate) code overhead.

Also this would mean mixing different types of
logical drivers into a single source - I doubt that
would be easy to get accepted...

Here again a summary of all the GPIOs that the mcp2517fd has:
* TXCAN: dedicated GPIO with single function, 
         individually conigurable as push/pull or open drain
* INT: main interrupt line - configurable as push/pull or 
         individually conigurable as push/pull or open drain
* GPIO0: general GPIO with in/out option, but 2 special “cases”:
         tx-irq and TX-disable
         group configurable as push/pull or open drain
* GPIO1: general GPIO with in/out potion, but 1 special “cases”:
         rx-irq
         group configurable as push/pull or open drain
* CLKO/SOF: clock output at (1/10th, 1/5th, 1/2, 1 of the 
            core frequency) or start of frame output
            possibly group configurable as push/pull or open drain
	    (not explicitly specified in datasheet)

How would you try to present that HW-configuration in the 
device tree instead?
How would it impact the driver design?

Thanks,
	Martin

