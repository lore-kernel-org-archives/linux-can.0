From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v7 4/7] can: provide a separate bittiming_const parameter
 to bittiming functions
Date: Fri, 28 Feb 2014 14:07:22 +0100
Message-ID: <53108A0A.5040202@hartkopp.net>
References: <1393583188-13307-1-git-send-email-socketcan@hartkopp.net> <1393583188-13307-5-git-send-email-socketcan@hartkopp.net> <5310691B.1090507@pengutronix.de> <531081A9.5020107@hartkopp.net> <531088F0.4040708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:60765 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbaB1NH2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 08:07:28 -0500
In-Reply-To: <531088F0.4040708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 28.02.2014 14:02, Marc Kleine-Budde wrote:
> On 02/28/2014 01:31 PM, Oliver Hartkopp wrote:
>>
>>
>> On 28.02.2014 11:46, Marc Kleine-Budde wrote:
>>> On 02/28/2014 11:26 AM, Oliver Hartkopp wrote:
>>
>>
>>>>  {
>>>> -	struct can_priv *priv = netdev_priv(dev);
>>>> -	int err;
>>>> +	int err = -EINVAL;
>>>
>>> Keep err uninitialized and make an explicit else err = -EINVAL.... see
>>> below:
>>>
>>
>>
>>>> +	if (!bt->tq) {
>>>> +		/* non-expert mode: Determine bit-timing parameters */
>>>> +		if (bt->bitrate)
>>>
>>> Why not:
>>> 	if (!bt->tq && bt->bitrate) {
>>>
>>>> +			err = can_calc_bittiming(dev, bt, btc);
>>>> +	} else {
>>>
>>> 	} else if (bt->tq && !bt->bitrate) {
>>>
>>>> +		/*
>>>> +		 * expert mode: Check bit-timing parameters and
>>>> +		 * calculate proper brp and a human readable bitrate
>>>> +		 */
>>>> +		if (!bt->bitrate)
>>>> +			err = can_fixup_bittiming(dev, bt, btc);
>>>>  	}
>>> 	} else {
>>> 		err = -EINVAL;
>>> 	}
>>
>> I don't have a strong preference on my implementation.
>>
>> But IMHO your suggested changes only add additional code and additional
>> comparisons in the if statement.
>>
>> I don't see a benefit in your suggestions :-(
> 
> You have 3 seperate if()s and an implicit error value from the
> initialisation. This is IMHO more straight forward:
> 
> 	if (!bt->tq && bt->bitrate)
> 		err = can_calc_bittiming(dev, bt, btc);
> 	else if (bt->tq && !bt->bitrate)
> 		err = can_fixup_bittiming(dev, bt, btc);
> 	else
> 		err = -EINVAL;
> 

Ok - looks good too.

Will change this in the v8 patch series.

Regards,
Oliver

