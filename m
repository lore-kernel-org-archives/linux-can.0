From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] [RFCv2] can: add CAN interface termination API
Date: Mon, 9 Jan 2017 18:13:02 +0100
Message-ID: <3f7eaf11-1c0c-c560-906a-54b4cde46874@hartkopp.net>
References: <20170108163506.30818-1-socketcan@hartkopp.net>
 <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:29940 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934191AbdAIRNf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 9 Jan 2017 12:13:35 -0500
In-Reply-To: <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hello Marc,

On 01/09/2017 10:25 AM, Marc Kleine-Budde wrote:
> On 01/08/2017 05:35 PM, Oliver Hartkopp wrote:
>> This patch adds a netlink interface to configure the CAN bus termination of
>> CAN interfaces.
>>
>> Inside the driver an array of supported termination values is defined:
>>
>> const u16 drvname_termination = { 60, 120, CAN_TERMINATION_DISABLED };
>
> drvname_termination[]
>

Ok.

>>
>> struct drvname_priv *priv;
>> priv = netdev_priv(dev);
>>
>> priv->termination_const = &drvname_termination;
>> priv->termination_const_size = sizeof(drvname_termination);
>
> ARRAY_SIZE()

When we use ARRAY_SIZE(drvname_termination) here ...

>> priv->termination = CAN_TERMINATION_DISABLED;
>>
>> And the funtion to set the value has to be defined:
>>
>> priv->do_set_termination = drvname_set_termination;
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>  drivers/net/can/dev.c            | 34 +++++++++++++++++++++++++++++++++-
>>  include/linux/can/dev.h          |  4 ++++
>>  include/uapi/linux/can/netlink.h |  5 +++++
>>  3 files changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index 8d6208c0b400..f98825f6ea2e 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -958,6 +958,27 @@ static int can_changelink(struct net_device *dev,
>>  		}
>>  	}
>>
>> +	if (data[IFLA_CAN_TERMINATION]) {
>> +		u16 t = nla_get_u16(data[IFLA_CAN_TERMINATION]);
>> +		int num_t = priv->termination_const_size / sizeof(u16);

... this needs to turn into

	int num_t = priv->termination_const_size;

but ...

>
> ARRAY_SIZE...or see below:
>
>> +		int i;
>> +
>> +		/* check whether given value is supported by the interface */
>> +		for (i = 0; i < num_t && t != priv->termination_const[i]; i++);
>
> Nitpick: unusual for() loop, better make more explicit what's going on:
>
> for (i = 0; i < ARRAY_SIZE(priv->termination_const_size), i++) {

... this does never work as it references an integer ...

> 	if (t == priv->termination_const[i])
> 		break;
> }
>
>> +		if (i >= num_t)
>> +			return -EINVAL;
>> +
>> +		if (priv->do_set_termination) {
>
> What about moving the check for priv->do_set_termination in front of the
> loop?
>
>> +			/* Finally, set the termination */
>> +			err = priv->do_set_termination(dev, t);
>> +			if (err)
>> +				return err;
>> +
>> +			priv->termination = t;
>> +		} else
>> +			return -EOPNOTSUPP;
>
> { } on both legs of the else
>
>> +	}
>> +
>>  	return 0;
>>  }
>>
>> @@ -980,6 +1001,11 @@ static size_t can_get_size(const struct net_device *dev)
>>  		size += nla_total_size(sizeof(struct can_bittiming));
>>  	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
>>  		size += nla_total_size(sizeof(struct can_bittiming_const));
>> +	if (priv->termination_const &&
>> +	    priv->termination_const_size) {			/* IFLA_CAN_TERMINATION_CONST */
>> +		size += nla_total_size(priv->termination_const_size);

... this will break ...

>> +		size += nla_total_size(sizeof(u16));		/* IFLA_CAN_TERMINATION */
>> +	}
>>
>>  	return size;
>>  }
>> @@ -1018,7 +1044,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>>  	    (priv->data_bittiming_const &&
>>  	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>>  		     sizeof(*priv->data_bittiming_const),
>> -		     priv->data_bittiming_const)))
>> +		     priv->data_bittiming_const)) ||
>> +
>> +	    (priv->termination_const && priv->termination_const_size &&
>> +	     nla_put(skb, IFLA_CAN_TERMINATION_CONST,
>> +		     priv->termination_const_size,

... and this too.

>> +		     priv->termination_const) &&
>> +	     nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
>>  		return -EMSGSIZE;
>>

I just wonder, which is the most readable representation here?

Regards,
Oliver
