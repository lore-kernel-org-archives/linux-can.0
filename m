From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Tue, 10 Jan 2017 17:54:38 +0100
Message-ID: <f4845404-5e63-40ea-3861-129f114b6508@hartkopp.net>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
 <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
 <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:25960 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754704AbdAJQyu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 11:54:50 -0500
In-Reply-To: <41946abf-548d-ba21-3da6-f3398905f932@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 01/10/2017 09:39 AM, Marc Kleine-Budde wrote:

>>> This "else" means an implicit "!priv->do_set_bittiming &&" which makes
>>> the code IMHO quite hard to understand.
>>
>> No no no.
>>
>> I just meant to throw -EOPNOTSUPP if !(priv->do_set_bittiming).
>
> No, do_set_bittiming is not mandatory.
>
> On SoC internal CAN cores it's easier to program the bittiming
> parameters into the controller during open(). As long as the driver sets
> the bittiming_const the framework will check if the bittiming parameters
> are correct.

Oh. Didn't know that use-case for SoCs.

>> As you suggested in the answer to my RFC these checks for existing
>> functions can be moved to the beginning of each code section.
>
> That's what my original patch proposes, here the resulting code of my patch:
>
>> 	if (data[IFLA_CAN_BITTIMING]) {
>> 		struct can_bittiming bt;
>>
>> 		/* Do not allow changing bittiming while running */
>> 		if (dev->flags & IFF_UP)
>> 			return -EBUSY;
>>
>> 		/* Calculate bittiming parameters based on
>> 		 * bittiming_const if set, otherwise pass bitrate
>> 		 * directly via do_set_bitrate(). Bail out if neither
>> 		 * is given.
>> 		 */
>> 		if (!priv->bittiming_const && !priv->do_set_bittiming)
>> 			return -EOPNOTSUPP;
>>
>> 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>> 		if (priv->bittiming_const) {
>> 			err = can_get_bittiming(dev, &bt,
>> 						priv->bittiming_const);
>> 			if (err)
>> 				return err;
>> 		}
>> 		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>
>> 		if (priv->do_set_bittiming) {

I was stumbling upon this additional check.

But now it seems correct to me ;-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks,
Oliver

