From: kernel@martin.sperl.org
Subject: Re: [PATCH 1/2] dt-binding: can: mcp2517fd: document device tree bindings
Date: Wed, 29 Nov 2017 12:55:44 +0100
Message-ID: <6EBDD798-8632-4F42-A138-369BCD36DF68@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <20171124183509.12810-2-kernel@martin.sperl.org> <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:41974
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932507AbdK2Lzr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 Nov 2017 06:55:47 -0500
In-Reply-To: <20171126222528.i6quueqdmuj6le6g@rob-hp-laptop>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hi Rob!

Thanks for all the effort - I shall incorporate those changes into V2.

> s/Microcip/Microchip/
> s/_/-/
> 
>> +					   0 = Start of Frame output
>> +					   default: 10
>> + - microchip,clock_div = <1|2>: internal clock divider - default 1
>> + - microchip,gpio_opendrain: gpio (int0,1) in open drain mode
>> +			     instead of default push/pull
>> + - microchip,int_opendrain: int pin in open drain mode
>> +			    instead of default push/pull
> 
> IIRC, we have a standard property for this.

Would you know what that could be - I did a quick search for
standard properties, but could not find a definitive list…

The only thing I found in:
  Documentation/devicetree/bindings/w1/w1-gpio.txt
is:
  linux,open-drain

But there is also:  
  nvidia,open-drain
  open_drain
  open-drain
  drive-open-drain (pinctrl)
  st,irq-open-drain

Only the last is specific to the interrupt line and none to the other
GPIOs of the chip (txcan, GPIO) - and each can get set differently.

So how shall I implement that?

Thanks,
	Martin