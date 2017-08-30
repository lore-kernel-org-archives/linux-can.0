From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: flexcan missing error state transitions
Date: Wed, 30 Aug 2017 08:25:37 +0200
Message-ID: <6bd916d4-3eb2-c247-2072-6b4c95dd5c69@grandegger.com>
References: <5213bc7ebd454acea568aba682d696ca@SGPMBX1017.APAC.bosch.com>
 <150333230375.13890.2773067532209799515@maxwell>
 <8e8b90f72f374fb1ab82bc29b8cfc108@SI-MBX1030.de.bosch.com>
 <150333966184.28484.15326759292718336833@maxwell>
 <e54b0db7ec524bcca65e1975aaf13b2b@SI-MBX1030.de.bosch.com>
 <71679863-5b47-faf2-ca44-27eb1abf16c6@pengutronix.de>
 <2ec91a72-49b2-ca43-9472-8f079b278c80@grandegger.com>
 <a257405ba06949a9be5d64912d72d0ba@SGPMBX1017.APAC.bosch.com>
 <23b53bdc-b7d4-f6de-b192-629ffe9795b0@grandegger.com>
 <c5b11618c98a41108dfbe6cf034398f0@SGPMBX1017.APAC.bosch.com>
 <3486f6ae-f4ef-fc94-e706-775f8af60826@grandegger.com>
 <2245ab57e90f44d88e53449156cc1e1b@SGPMBX1017.APAC.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy01.manitu.net ([217.11.48.65]:49902 "EHLO
        mailproxy01.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdH3GZk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Aug 2017 02:25:40 -0400
In-Reply-To: <2245ab57e90f44d88e53449156cc1e1b@SGPMBX1017.APAC.bosch.com>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "ZHU Yi (ST-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Andri Yngvason <andri.yngvason@marel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, "RUAN Tingquan (ST-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>, "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>



Am 30.08.2017 um 06:22 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
> Hello Wolfgang,
> 
>> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
>> Sent: Tuesday, August 29, 2017 7:17 PM
>>
>> Hello,
>>
>> now looking to your patches...
>>
>> Am 29.08.2017 um 10:49 schrieb ZHU Yi (ST-FIR/ENG1-Zhu):
>>> Hello Wolfgang, Hello Andri,
>> [...]
>>
>>> Attached please find the patch for review.
>>>
>>> Patch 1 (0001-can-flexcan-mitigate-incomplete-state-interrupt.patch)
>>> Fixes the state transition issue, but interrupt flooding may happen.
>>
>>>  From 3025a3f6f27f6df99d1db60d3ef820efe629fd20 Mon Sep 17 00:00:00 2001
>>> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>>> Date: Mon, 28 Aug 2017 17:29:23 +0800
>>> Subject: [PATCH 1/2] can: flexcan: mitigate i.MX6 incomplete state irq
>>>
>>> The i.MX6 flexcan core will not generate state interrupt for some state
>>> transitions. This patch enables the bus error interrupt on i.MX6 by
>>> enabling FLEXCAN_QUIRK_BROKEN_ERR_STATE and changing the call of
>>> flexcan_irq_state() upon _any_ interrupt to mitigate this issue.
>>>
>>> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
>>> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
>>> ---
>>>   drivers/net/can/flexcan.c | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 13f0f21..75bb9f6 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -288,7 +288,7 @@ static const struct flexcan_devtype_data
>> fsl_imx28_devtype_data;
>>>
>>>   static const struct flexcan_devtype_data fsl_imx6q_devtype_data = {
>>>   	.quirks = FLEXCAN_QUIRK_DISABLE_RXFG |
>> FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>>> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP,
>>> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE,
>>>   };
>>
>> This patch should just fix the regression bug... without using
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE for the imx6q.
> OK. I'll create a separate patch to enable the quirk for imx6q.
> 
>>
>>>   static const struct flexcan_devtype_data fsl_vf610_devtype_data = {
>>> @@ -765,8 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>   		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>>>   	}
>>>
>>> -	/* state change interrupt */
>>> -	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
>>> +	/* state change interrupt or on broken error state core */
>>> +	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>> +	    (priv->devtype_data->quirks &
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE))
>>>   		flexcan_irq_state(dev, reg_esr);
>>>
>>>   	/* bus error IRQ - handle if bus error reporting is activated */
>>> --
>>> 2.7.4
>>
>> Looks good!
>>
>>> Patch 2 (0002-can-flexcan-mitigate-error-interrupt-flooding.patch)
>>
>>>  From 5ca061fcb0cc8576caafdd9a0f398adf81c18ecc Mon Sep 17 00:00:00 2001
>>> From: Zhu Yi <yi.zhu5@cn.bosch.com>
>>> Date: Tue, 29 Aug 2017 12:19:04 +0800
>>> Subject: [PATCH 2/2] can: flexcan: mitigate error interrupt flooding
>>>
>>> Error interrupt flooding may happen if berr-reporting is enabled, or
>>> the broken error state quirk fix is enabled. For example, in case
>>> there is no cable connected, error interrupt flooding is very likely
>>> because the node cannot go to bus off.
>>>
>>> This patch mitigates this issue by:
>>> 1. disable error interrupt upon error passive state transition
>>> 2. re-enable error interrupt upon error warning state transition
>>>
>>> In this way, the driver is still able to report correct state
>>> transitions without additional latency. And flooding of error interrupts
>>> is limited to the number of frames required to change the state to error
>>> passive when there are bus problems.
>>>
>>> Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
>>> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
>>> ---
>>>   drivers/net/can/flexcan.c | 45
>> ++++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 40 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 75bb9f6..9d0e97e 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -581,7 +581,7 @@ static void flexcan_irq_bus_err(struct net_device *dev,
>> u32 reg_esr)
>>>   	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
>>>   }
>>>
>>> -static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>>> +static bool flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>>>   {
>>>   	struct flexcan_priv *priv = netdev_priv(dev);
>>>   	struct sk_buff *skb;
>>> @@ -607,11 +607,11 @@ static void flexcan_irq_state(struct net_device *dev,
>> u32 reg_esr)
>>>
>>>   	/* state hasn't changed */
>>>   	if (likely(new_state == priv->can.state))
>>> -		return;
>>> +		return false;
>>>
>>>   	skb = alloc_can_err_skb(dev, &cf);
>>>   	if (unlikely(!skb))
>>> -		return;
>>> +		return false;
>>>
>>>   	can_change_state(dev, cf, tx_state, rx_state);
>>>
>>> @@ -619,6 +619,7 @@ static void flexcan_irq_state(struct net_device *dev, u32
>> reg_esr)
>>>   		can_bus_off(dev);
>>>
>>>   	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
>>> +	return true;
>>>   }
>>>
>>>   static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload
>> *offload)
>>> @@ -712,7 +713,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>   	struct flexcan_priv *priv = netdev_priv(dev);
>>>   	struct flexcan_regs __iomem *regs = priv->regs;
>>>   	irqreturn_t handled = IRQ_NONE;
>>> -	u32 reg_iflag1, reg_esr;
>>> +	u32 reg_iflag1, reg_esr, reg_ctrl;
>>> +	bool state_changed = false;
>>>
>>>   	reg_iflag1 = flexcan_read(&regs->iflag1);
>>>
>>> @@ -768,13 +770,46 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>   	/* state change interrupt or on broken error state core */
>>>   	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>>   	    (priv->devtype_data->quirks &
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE))
>>> -		flexcan_irq_state(dev, reg_esr);
>>> +		state_changed = flexcan_irq_state(dev, reg_esr);
>>>
>>>   	/* bus error IRQ - handle if bus error reporting is activated */
>>>   	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
>>>   	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
>>>   		flexcan_irq_bus_err(dev, reg_esr);
>>>
>>> +	/* disable error interrupt upon error passive state transition
>>> +	 * to suspend bus error reporting (to avoid flooding).
>>> +	 *
>>> +	 * re-enable error interrupt upon error warning state transition
>>> +	 * to resume bus error reporting and allow broken error state core
>>> +	 * to report state correctly (again).
>>> +	 *
>>> +	 * availability of error interrupt among state transitions:
>>> +	 *  +--------------------------------------------------------------+
>>> +	 *  | +----------------------------------------------+ [stopped /  |
>>> +	 *  | |                                              |  sleeping] -+
>>> +	 *  +-+-> active <-> warning <-> passive -> bus off -+
>>> +	 *        ^^^^^^^^^^^^^^^^^^^^^^^_______________________________
>>> +	 *                enabled                      disabled
>>> +	 */
>>> +	if (state_changed &&
>>> +	    (priv->devtype_data->quirks &
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE ||
>>> +	     priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
>>> +		if ((priv->can.state == CAN_STATE_ERROR_PASSIVE) ||
>>> +		    (priv->can.state == CAN_STATE_BUS_OFF)) {
>>> +			reg_ctrl = flexcan_read(&regs->ctrl);
>>> +			reg_ctrl &= ~FLEXCAN_CTRL_ERR_MSK;
>>> +			flexcan_write(reg_ctrl, &regs->ctrl);
>>> +		}
>>
>> We do not want to disable bus error interrupts for bus error reporting!
> I see! If user enabled bus error reporting, that means he want all bus errors,
> include flooding. I will fix this.

Yep, serious flooding usually happens only on low end systems and at 
high bitrates.

>>
>>> +		if ((priv->can.state == CAN_STATE_ERROR_WARNING) ||
>>> +		    (priv->can.state == CAN_STATE_ERROR_ACTIVE)) {
>>> +			reg_ctrl = flexcan_read(&regs->ctrl);
>>> +			reg_ctrl |= FLEXCAN_CTRL_ERR_MSK;
>>> +			flexcan_write(reg_ctrl, &regs->ctrl);
>>> +		}
>>> +	}
>>> +
>>
>> For the legacy FLEXCAN_QUIRK_BROKEN_ERR_STATE we do not want to
>> disable
>> bus error interrupts as well. To handle that properly, I think we need
> I'm not sure why we do not want to disable error interrupt for legacy broken core,
> I think if this approach works for both (with/without warning irq) core, then disable
> the interrupts helps avoid flooding.

How does it work if no cable is connected?  On a legacy device (with 
broken [TR]WRN_INT), no interrupt will arrive other than the bus error 
interrupt. Maybe I have missed something. Unfortunately, I do not have 
any Flexcan device at hand to check myself.

>> an additional FLEXCAN_QUIRK_BROKEN_PERR_STATE and maybe rename
>> FLEXCAN_QUIRK_BROKEN_ERR_STATE to
>> FLEXCAN_QUIRK_BROKEN_WERR_STATE.
> That's a good point. With FLEXCAN_QUIRK_BROKEN_WERR_STATE and
> FLEXCAN_QUIRK_BROKEN_PERR_STATE, we can precisely tell which core
> lacks of which capability.

That's the idea.

> However, I'm wondering is there a flexcan core which lacking warning irq,

Good question? Don't know if the VF610 core does need that quirk as well.

> but having passive irq? If this is not true, then we will never specify the
> WERR_STATE quirk alone, right?

Yep!
> 
>>
>>>   	return handled;
>>>   }
>>>
>>> --
>>> 2.7.4
>>
>>
>>> Addresses the interrupt flooding issue as above mentioned, and takes care
>>> of the bus-error reporting. For the other quirks, they looks like won't
>>> influence the state transition and interrupt flooding. Please comment if
>>> something missed.
>>>
>>> One more thing regarding patch 2 is, it doesn't rely on error warning
>>> can be reported by [TR]WRN_INT, because this state can also be reported
>>> upon the _any_ interrupt. Only bus-off state needs to have dedicated
>>> interrupt line (is this true for all flexcan core?)
>>
>> I don't think so. How should it work if no cable is connected? Anyway,
>> the patch seems not to be to lenghty.
> I disabled the [TR]WRN_INT on i.MX6 by change
> (http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/flexcan.c#L88)
> to:
> #define FLEXCAN_CTRL_ERR_STATE FLEXCAN_CTRL_BOFF_MSK
> and tested with the patch, seems the state transitions still works fine.

With no cable connected?

> I think the reason is the same as how the error interrupt helps report error passive:
> At most 12 times consecutive bus error interrupts will change to error warning, and
> minimal 1 time Tx/Rx interrupt will change state from error passive to error warning.
> 
> If we change to:
> #define FLEXCAN_CTRL_ERR_STATE 0
> then we cannot enter bus off state any more as expected (other transitions still ok).
> 
> As we only have i.MX6 at hand, so we cannot verify this on other flexcan core.
> If we want to limit the patch to only take effect for i.MX6, then we should introduce
> the FLEXCAN_QUIRK_BROKEN_P(W)ERR_STATE, thus the legacy core will not be
> affected.

As you/I cannot test on legacy and other cores, I would go for a 
separate quirk for the mx6q.

> Otherwise, the legacy FLEXCAN_QUIRK_BORKEN_ERR_STATE can be extended
> to the core with broken warning and/or passive irq.
> 
> What do you think?
> 
> I'll prepare patches for review later:
> 1. fix regression bug
> 2. suppress interrupt flooding for broken core
> 3. enable quirk for i.mx6
> 
> Shall I send separate e-mail for each patch? Due to our mail client is outlook, I'm
> not sure whether the inline patch can work smoothly, if not, shall I attach the patch?

Separate patches please, especially for the first one.

Wolfgang.
