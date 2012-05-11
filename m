From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v2] CAN FD support
Date: Fri, 11 May 2012 20:17:28 +0200
Message-ID: <4FAD57B8.8060408@hartkopp.net>
References: <4FAC1288.3090801@hartkopp.net> <4FAC2069.3010304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:26412 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab2EKSR3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 May 2012 14:17:29 -0400
In-Reply-To: <4FAC2069.3010304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 10.05.2012 22:09, Marc Kleine-Budde wrote:

> On 05/10/2012 09:10 PM, Oliver Hartkopp wrote:


>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index f03d7a4..a33c00f 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -33,6 +33,39 @@ MODULE_DESCRIPTION(MOD_DESC);
>>  MODULE_LICENSE("GPL v2");
>>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
>>  
>> +/* CAN DLC to real data length conversion helpers */
>> +
>> +static const u8 dlc2len[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8,
>> +			       12, 16, 20, 24, 32, 48, 64};
>                            ^^
>  nitpick: not really needed.


Changed.

> 
>> +
>> +/* get data length from can_dlc with sanitized can_dlc */
>> +u8 can_dlc2len(u8 can_dlc)
>> +{
>> +	return dlc2len[can_dlc & 0x0F];
>> +}
>> +EXPORT_SYMBOL_GPL(can_dlc2len);
>> +
> 
> dito
>                            VV
>> +static const u8 len2dlc[65] = {0, 1, 2, 3, 4, 5, 6, 7, 8,	/* 0 - 8 */


Changed.

>> +			       9, 9, 9, 9,			/* 9 - 12 */
>> +			       10, 10, 10, 10,			/* 13 - 16 */
>> +			       11, 11, 11, 11,			/* 17 - 20 */
>> +			       12, 12, 12, 12,			/* 21 - 24 */
>> +			       13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
>> +			       14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
>> +			       14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
>> +			       15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
>> +			       15, 15, 15, 15, 15, 15, 15, 15}; /* 57 - 64 */
>> +
>> +/* map the sanitized data length to an appropriate data length code */ 
>> +u8 can_len2dlc(u8 len)
>> +{
>> +	if (unlikely(len > 64))
>                          ^^^^^
> 
> ARRAY_SIZE?


Hm - no.

i could also write

if (len > 48)
    return 0xF;

and reduce the len2dlc[] table appropriately.

But i wanted to make it clear in the code what the dlc table is about.

And therefore it deals with the real length which is unlikely > 64

> 

>> +		return 0xF;
>> +
>> +	return len2dlc[len];
>> +}
>> +EXPORT_SYMBOL_GPL(can_len2dlc);



(..)

>> +static int vcan_change_mtu(struct net_device *dev, int new_mtu)
>> +{
> 
> Do we need rtnl_lock here?
> 


No. This is ensured somehow as nobody has a rtnl_lock handling in their
change_mtu functions :-)

>> +	/* Do not allow changing the MTU while running */
>> +	if (dev->flags & IFF_UP)
>> +		return -EBUSY;
>> +
>> +	if (new_mtu == CAN_MTU || new_mtu == CANFD_MTU) {
>> +		dev->mtu = new_mtu;
>> +		return 0;
>> +	}
> 
> I personally prefer when the:
> 	if (error_condition)
> 		return -EFOO;"
> 
> style.
> 


Changed. Me too.

(..)

>> +/*
>> + * defined bits for canfd_frame.flags
>> + *
>> + * As the default for CAN FD should be to support the high data rate in the
>> + * payload section of the frame (HDR) and to support up to 64 byte in the
>> + * data section (EDL) the bits are only set in the non-default case.
>> + * Btw. as long as there's no real implementation for CAN FD network driver
>> + * these bits are only preliminary.
>> + *
>> + * RX: NOHDR/NOEDL - info about received CAN FD frame
>> + *     ESI         - bit from originating CAN controller
>> + * TX: NOHDR/NOEDL - control per-frame settings if supported by CAN controller
>> + *     ESI         - bit is set by local CAN controller
>> + */
>> +#define CANFD_NOHDR 0x01 /* frame without high data rate */
>> +#define CANFD_NOEDL 0x02 /* frame without extended data length */
>> +#define CANFD_ESI   0x04 /* error state indicator */
> 
> You can make use of BIT(0), BIT(1), etc.


Not for userspace headers.

Check your built kernel headers in linux/usr/include/linux with grep BIT\( *

(..)

>>  {
>> -	const struct can_frame *cf = (struct can_frame *)skb->data;
>> -
>> -	if (unlikely(skb->len != sizeof(*cf) || cf->can_dlc > 8)) {
>> -		kfree_skb(skb);
>> -		dev->stats.tx_dropped++;
>> -		return 1;
>> -	}
>> +	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
>> +
>> +	if (skb->protocol == htons(ETH_P_CAN)) {
>> +		if (skb->len != sizeof(struct can_frame) ||
>> +		    cfd->len > CAN_MAX_DLEN)
>> +			goto inval_skb;
>> +	} else if (skb->protocol == htons(ETH_P_CANFD)) {
>> +		if (skb->len != sizeof(struct canfd_frame) ||
>> +		    cfd->len > CANFD_MAX_DLEN)
>> +			goto inval_skb;
> 
> what about adding/keeping the unlikely to both inner ifs?


Good idea. I added some more unlikely's in other sanity checks too.
 

>> +	} else
>> +		goto inval_skb;
>>  
>>  	return 0;
>> +
>> +inval_skb:
> 
> Please add a space before the jump label. git diff will use things which
> start on the first column to give hunks more context information. See
> here for example:
> 
>>> +++ b/include/linux/can/raw.h
>>> @@ -23,7 +23,8 @@ enum {
>                      ^^^^
>>>  	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
>>>  	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>>>  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>>> -	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
>>> +	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>>> +	CAN_RAW_FD_FRAMES,	/* use struct canfd_frame (default:off) */
>>>  };
> 
> So that you see this belongs to an enum. If you add a jumplabel on the
> first column you overwrite the function name. Clever isn't it?


???

What's clever about this?

  
>> @@ -300,6 +313,10 @@ int can_send(struct sk_buff *skb, int loop)
>>  	can_stats.tx_frames_delta++;
>>  
>>  	return 0;
>> +
>> +inval_skb:
> 
> dito


E.g. this look pretty ok to me.

The patch is in can_send() at a specific line.

What would you expect?

See http://yarchive.net/comp/linux/coding_style.html and search for 'labels'

Labels are to be placed at the first column. So this looks correct.

I won't like to change this because of 'git diff' looks better. Probably git
should be changed to deal better with usual goto labels instead.

(..)

>> @@ -846,6 +902,7 @@ static __init int can_init(void)
>>  	sock_register(&can_family_ops);
>>  	register_netdevice_notifier(&can_netdev_notifier);
>>  	dev_add_pack(&can_packet);
>> +	dev_add_pack(&canfd_packet);
>>  
>>  	return 0;
>>  }
>> @@ -861,6 +918,7 @@ static __exit void can_exit(void)
>>  
>>  	/* protocol unregister */
>>  	dev_remove_pack(&can_packet);
>> +	dev_remove_pack(&canfd_packet);
> 
> nitpick: please keep it symetric, and unregister canfd first.


Changed. You are right.

> 
>>  	unregister_netdevice_notifier(&can_netdev_notifier);
>>  	sock_unregister(PF_CAN);
>>  
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index cde1b4a..dea52da 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -82,6 +82,7 @@ struct raw_sock {
>>  	struct notifier_block notifier;
>>  	int loopback;
>>  	int recv_own_msgs;
>> +	int fd_frames;
> 
> hmmm: does it make sense to replace these three bool like variables by a
> bitfiled or a generic flags varibale?


This is probably a bit late now.

If we had a bitfield from the beginning this would be easy.
But i assume if we start with a bitfield now it becomes ugly.

I also thought about fd_frames being a bitfield - but so far i did no find
any use-case for more than one state (enabled/disabled) ...

(..)

> 
> Marc
> 


Thanks for the review.

Will send a v3 to be able to discuss about the 'latest and greatest' - which
Robert likes most :-)

Regards,
Oliver

ps. changes since v2:

https://gitorious.org/linux-can/hartkopps-linux-can-next/commit/ef9c4914da29702f25f0f2342ab1f6d714aa118b/diffs/9d51e1e6e40be9a36210a9ac7a9f8d6067ba94a5
