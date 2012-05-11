From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 3/4] can: c_can: Move overlay structure to array with
 offset as index
Date: Fri, 11 May 2012 16:40:48 +0200
Message-ID: <4FAD24F0.3070600@grandegger.com>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com> <1336649657-4152-4-git-send-email-anilkumar@ti.com> <4FAC213B.8030404@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13E9BC78B@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44772 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2EKOlA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 May 2012 10:41:00 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9BC78B@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

On 05/11/2012 01:09 PM, AnilKumar, Chimata wrote:
> On Fri, May 11, 2012 at 01:42:43, Marc Kleine-Budde wrote:
>> On 05/10/2012 01:34 PM, AnilKumar Ch wrote:
>>> c_can uses overlay structure for accessing c_can module registers.
>>> With this kind of implementation it is difficult to add one more ip
>>> which is similar to c_can in functionality but different register
>>> offsets.
>>>
>>> This patch changes the overlay structure implementation to an array
>>> with register offset as index. This way we can overcome the above
>>> limitation.
>>
>> The array index implementation looks very nice.
>>
>> I suggest to use the enum instead of a plain "int reg" in the
>> c_can_read_* function arguments.
> 
> That is better compared to int reg, I will change.
> 
>>
>> General question: What happend to "iface", like in this hunk below?
> 
> In entire driver iface is used as "0" means IF register bank one. So I defined
> enum like "C_CAN_IF1_*". If IF register bank 2 is used in the driver at that
> time we can define "C_CAN_IF2_*" and used appropriately.

But switching IF1->IF2 would then be awkward. Anyway, at the moment
switching seems not required and therefore there is no need to introduce
another array but...

> 
>>
>>>  	while (count && priv->read_reg(priv,
>>> -				&priv->regs->ifregs[iface].com_req) &
>>> +				C_CAN_IF1_COMREQ_REG) &
>>>  				IF_COMR_BUSY) {

... what is then "iface" still good for? I see that the functions still
have that argument.

Apart from that the patch series look quite good now.

Wolfgang.
