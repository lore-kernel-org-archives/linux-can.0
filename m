From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC, PATCH] can: dev: can_changelink: allow to set bitrate on
 devices not providing {data_,}bittiming_const
Date: Mon, 9 Jan 2017 18:23:04 +0100
Message-ID: <588eacb5-c565-34bf-fed7-89bd46755819@hartkopp.net>
References: <20170106125344.15267-1-mkl@pengutronix.de>
 <4bbdf65f-fc33-23ae-1a30-b5b45595b2e2@hartkopp.net>
 <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:13977 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034362AbdAIRXH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2017 12:23:07 -0500
In-Reply-To: <8cad5778-0af9-175e-5a6b-4d6baadff021@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 01/09/2017 11:39 AM, Marc Kleine-Budde wrote:
> On 01/07/2017 02:22 PM, Oliver Hartkopp wrote:
>> Hi Marc,
>>
>> On 01/06/2017 01:53 PM, Marc Kleine-Budde wrote:
>>
>>> @@ -872,10 +868,22 @@ static int can_changelink(struct net_device *dev,
>>>  		/* Do not allow changing bittiming while running */
>>>  		if (dev->flags & IFF_UP)
>>>  			return -EBUSY;
>>> +
>>> +		/* Calculate bittiming parameters based on
>>> +		 * bittiming_const if set, otherwise pass bitrate
>>> +		 * directly via do_set_bitrate(). Bail out if neither
>>> +		 * is given.
>>> +		 */
>>> +		if (!priv->bittiming_const && !priv->do_set_bittiming)
>>> +			return -EOPNOTSUPP;
>>> +
>>
>> I would suggest to remove this check and the comment here and better add
>> an else path with
>>
>> 	return -EOPNOTSUPP;
>> at
>> 	if (priv->do_set_bittiming) { } else ...
>
> Then the code looks like this:
>
>> 	if (data[IFLA_CAN_BITTIMING]) {
>> 		struct can_bittiming bt;
>>
>> 		/* Do not allow changing bittiming while running */
>> 		if (dev->flags & IFF_UP)
>> 			return -EBUSY;
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
>> 			/* Finally, set the bit-timing registers */
>> 			err = priv->do_set_bittiming(dev);
>> 			if (err)
>> 				return err;
>> 		} else if (!priv->bittiming_const) {
>
> This "else" means an implicit "!priv->do_set_bittiming &&" which makes
> the code IMHO quite hard to understand.

No no no.

I just meant to throw -EOPNOTSUPP if !(priv->do_set_bittiming).

As you suggested in the answer to my RFC these checks for existing 
functions can be moved to the beginning of each code section.

>
>> 			/* Calculate bittiming parameters based on
>> 			 * bittiming_const if set, otherwise pass bitrate
>> 			 * directly via do_set_bitrate(). Bail out if neither
>> 			 * is given.
>> 			 */
>> 			return -EOPNOTSUPP;
>> 		}
>> 	}
>
>
>>>  		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>>> -		err = can_get_bittiming(dev, &bt, priv->bittiming_const);
>>> -		if (err)
>>> -			return err;
>>> +		if (priv->bittiming_const) {
>>> +			err = can_get_bittiming(dev, &bt,
>>> +						priv->bittiming_const);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>>  		memcpy(&priv->bittiming, &bt, sizeof(bt));
>>>
>>>  		if (priv->do_set_bittiming) {
>>> @@ -943,11 +951,23 @@ static int can_changelink(struct net_device *dev,
>>>  		/* Do not allow changing bittiming while running */
>>>  		if (dev->flags & IFF_UP)
>>>  			return -EBUSY;
>>> +
>>> +		/* Calculate bittiming parameters based on
>>> +		 * data_bittiming_const if set, otherwise pass bitrate
>>> +		 * directly via do_set_bitrate(). Bail out if neither
>>> +		 * is given.
>>> +		 */
>>> +		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
>>> +			return -EOPNOTSUPP;
>>> +
>>>  		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
>>>  		       sizeof(dbt));
>>> -		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
>>> -		if (err)
>>> -			return err;
>>> +		if (priv->data_bittiming_const) {
>>> +			err = can_get_bittiming(dev, &dbt,
>>> +						priv->data_bittiming_const);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>>  		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>>>
>>>  		if (priv->do_set_data_bittiming) {
>>>
>>
>> dito here.
>>
>> Maybe this leads to two patches then:
>>
>> 1. Introduce the -EOPNOTSUPP for missing do_set[_data]_bittiming
>
> do_set_bittiming is and was not mandatory.

This is broken - isn't it?
Does it make sense to make do_set_bittiming optional?

I would think do_set_bittiming is mandatory but bittiming_const can be 
optional to support a fixed set of bitrates e.g. for the mcba_usb driver?!?

Regards,
Oliver

> Before your patch it was
> mandatory to have one (bittiming_const or do_set_bittiming) or both.
> With your patch bittiming_const got mandatory, too. My patch
> re-introduces the "bittiming_const or do_set_bittiming" state, which is
> directly reflected by the "if (!priv->bittiming_const &&
> !priv->do_set_bittiming)" statement.
>
>> 2. Allow to set bitrates without providing bittiming_const
>
> Marc
>
