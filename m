From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: add hardware controller version support
Date: Tue, 3 Jul 2012 11:07:30 +0800
Message-ID: <4FF261F2.5050300@gmail.com>
References: <1341174085-11781-1-git-send-email-mkl@pengutronix.de> <4FF10668.4000504@gmail.com> <4FF1973E.4070005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40327 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab2GCDHr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 23:07:47 -0400
In-Reply-To: <4FF1973E.4070005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, linux-can@vger.kernel.org, kernel@pengutronix.de, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

Marc Kleine-Budde wrote:
> On 07/02/2012 04:24 AM, Hui Wang wrote:
>   
>> Marc Kleine-Budde wrote:
>>     
>>> From: Hui Wang <jason77.wang@gmail.com>
>>>
>>> At least in the i.MX series, the flexcan contrller divides into ver_3
>>> and ver_10, current driver is for ver_3 controller.
>>>
>>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>>> Its reset value is 0xffffffff, this means ID Filter Table must be
>>> checked when receive a packet, but the driver is designed to accept
>>> everything during the chip start, we need to clear this register to
>>> follow this design.
>>>
>>> Use the data entry of the struct of_device_id to point chip specific
>>> info, we can set hardware version for each platform.
>>>
>>> Cc: linux-can@vger.kernel.org
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>> [mkl: add id_table support]
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>> Hui Wang,
>>>
>>> can you please test if this works for you on mx6.
>>>   
>>>       
>> Sorry for reply late.
>>
>> This patch works well on the mx6. But i found a minor problem, please
>> see below.
>>     
>
> I've fixed the issue in the patch series I just send (forgot to mention
> that in the patch). Can I add your Acked-by and Tested-by?
>
>   
OK, no problem. :-).

> Marc
>   

