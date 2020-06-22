From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/6] Add Microchip MCP25XXFD CAN driver
Date: Mon, 22 Jun 2020 15:41:03 +0200
Message-ID: <0f087f65-7dc4-6d83-705a-be8c3302ce40@pengutronix.de>
References: <fbbca009-3c53-6aa9-94ed-7e9e337c31a4@pengutronix.de>
 <20200617165902.GB14228@x1.vandijck-laurijssen.be>
 <2e80e2ed-d63d-5cc6-e1c6-e0c9e75c218e@pengutronix.de>
 <20200618123055.GA17496@x1.vandijck-laurijssen.be>
 <c8267280-e7a9-8171-d714-fa392ccb5537@pengutronix.de>
 <20200622102559.GA3077@x1.vandijck-laurijssen.be>
 <c5fc46c1-abaf-cf67-abb6-0077bafdff3a@pengutronix.de>
 <20200622123031.GB3077@x1.vandijck-laurijssen.be>
 <20200622124347.GC3077@x1.vandijck-laurijssen.be>
 <0ae54858-0eb5-b3b8-c793-00a8b99c8aa5@pengutronix.de>
 <20200622132608.GD3077@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgFVNlI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 09:41:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D5C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 06:41:07 -0700 (PDT)
In-Reply-To: <20200622132608.GD3077@x1.vandijck-laurijssen.be>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, wg@grandegger.com, kernel@martin.sperl.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/22/20 3:26 PM, Kurt Van Dijck wrote:
> On ma, 22 jun 2020 14:54:15 +0200, Marc Kleine-Budde wrote:
>> On 6/22/20 2:43 PM, Kurt Van Dijck wrote:
>>> I get RX-0: FIFO overflows in listen-only mode (back-to-back burst of
>>> the single other node).
>>
>> Single other node? Who's ACKing the CAN frames?
> 
> hence the back-to-back burst.

Just wanted to be sure if I understood correctly. Nice testcase btw!

>>> The SPI peripheral does not use DMA :-(.
>>
>> The SPI messages are quite small, so DMA wont help either. Getting rid of the
>> IRQ and polling for completion is the way to go.
>>
>>> Do you have, by accident, some freescale SPI fixes lying around?
>>
>> nope
>>
>>> It's not the biggest problem on my side, but is proves the system not
>>> being guarded against load.
>>
>> Do you have freq scaling activated?
> 
> Not yet.
> 
> The device tree needs upgrading ... grrr

Without freq scaling the imx core is supposed to run at full speed, which is
better for bursty SPI traffic than starting clocked down into a burst....

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
