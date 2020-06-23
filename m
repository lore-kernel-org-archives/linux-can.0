From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Date: Tue, 23 Jun 2020 09:27:05 +0200
Message-ID: <0b59a55c-8e67-75f2-45c9-cb3c699470e3@pengutronix.de>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
 <20200623032635.GG11093@Mani-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFWH1O (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 03:27:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE06C061573
        for <linux-can@vger.kernel.org>; Tue, 23 Jun 2020 00:27:14 -0700 (PDT)
In-Reply-To: <20200623032635.GG11093@Mani-XPS-13-9360>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, Oleksij Rempel <o.rempel@pengutronix.de>

On 6/23/20 5:26 AM, Manivannan Sadhasivam wrote:
>>>> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
>>>> +
>>>
>>> MCP251{7/8}FD?
>>
>> Which expansion rules should be use for the title? In sh-like shells it would be
>> MCP251{7,8}FD.
>>
> 
> Either one. I was just concerned about the original one which might create
> ambiguity.

I've changed this to:

> Microchip MCP2517FD and MCP2518FD stand-alone CAN controller device tree
> bindings

[...]

>>>> +  rx-int-gpios:
> 
> This doesn't look like a standard property. So I think you need to add
> 'microchip' prefix to make it as vendor specific.

makes sense.

>>>> +    description:
>>>> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
>>>> +      signals a pending RX interrupt.
>>>> +    maxItems: 1
>>>> +
>>>> +  spi-max-frequency:
>>>> +    description:
>>>> +      Must be half or less of "clocks" frequency.
>>>> +    maximum: 20000000
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts-extended
>>>> +  - clocks
>>>> +
>>>
>>> The controller is capable of generating clocks and also able to control few
>>> GPIOs. So eventually you need to document those properties in bindings even
>>> your driver is not supporting all of them atm.
>>
>> I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
>> bindings will go along with that. So far I have no customer that needs support
>> for that, do you?>
> DT binding should describe what the controller is capable of and not the
> capability of the driver. You can always add functionality to driver but binding
> should stay as it is (although there are exceptions...).
As Oleksij pointed out, this make driver development very complicated. I'm not
even sure how to properly abstract the GPIO support. For open drain pinctrl
would be best, haveing one microchip,open-drain property in the DT would effect
all GPIOs.

Further this means I have to look into the driver if a documented property is
implemented and does what it is advertised to do? That sounds very counter
intuitive for me.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
