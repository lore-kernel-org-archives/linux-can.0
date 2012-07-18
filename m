From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Wed, 18 Jul 2012 18:03:07 +0800
Message-ID: <500689DB.1020505@gmail.com>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de> <500686DE.1050908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:65118 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2GRKDg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 06:03:36 -0400
In-Reply-To: <500686DE.1050908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Hui Wang <jason77.wang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, richard.zhao@freescale.com

Add Richard.Zhao in, maybe he can give a help.

Regards,
Hui.

Marc Kleine-Budde wrote:
> Hello,
>
> On 07/01/2012 10:21 PM, Marc Kleine-Budde wrote:
>   
>> From: Hui Wang <jason77.wang@gmail.com>
>>
>> At least in the i.MX series, the flexcan contrller divides into ver_3
>> and ver_10, current driver is for ver_3 controller.
>>     
>
> Has someone access to the freescale hardware people and can figure out
> the controller versions used on:
>
> imx28
> imx25
> imx35
> imx53
>
> Because I noticed that the FLEXCAN_CTRL_CLK_SRC bit (bit 13 of the
> FLEXCAN control register) is marked as reserved in the mx53 datasheet
> (although its meaning is documented) as well as in the imx6q. Is there a
> Changelog of this core available?
>
>   
>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>> Its reset value is 0xffffffff, this means ID Filter Table must be
>> checked when receive a packet, but the driver is designed to accept
>> everything during the chip start, we need to clear this register to
>> follow this design.
>>
>> Use the data entry of the struct of_device_id to point chip specific
>> info, we can set hardware version for each platform.
>>     
>
> cheers, Marc
>
>   

