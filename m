From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
Date: Sun, 8 Dec 2019 12:34:42 +0100
Message-ID: <2b997c05-fcef-e067-2771-8e07e35dfadd@hartkopp.net>
References: <20191207183418.28868-1-socketcan@hartkopp.net>
 <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, dvyukov@google.com
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com, syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, eric.dumazet@gmail.com
List-Id: linux-can.vger.kernel.org



On 08/12/2019 11.48, Marc Kleine-Budde wrote:
> On 12/7/19 7:34 PM, Oliver Hartkopp wrote:
>> KMSAN sysbot detected a read access to an untinitialized value in the headroom
>> of an outgoing CAN related sk_buff. When using CAN sockets this area is filled
>> appropriately - but when using a packet socket this initialization is missing.


>> +/* Check for outgoing skbs that have not been created by the CAN subsystem */
>> +static inline bool can_check_skb_headroom(struct net_device *dev,
>> +					  struct sk_buff *skb)
> 
> Do we want to have such a big function as a static inline?
> 

No. Usually not. can_dropped_invalid_skb() has the same problem IMO.

This additional inline function approach was the only way to ensure 
simple backwards portability for stable kernels.

I would suggest to clean this up once this patch went into mainline.

>> +{
>> +	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
>> +	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
>> +		return true;
>> +
>> +	/* af_packet does not apply CAN skb specific settings */
>> +	if (skb->ip_summed == CHECKSUM_NONE) {
> 
> Is it possible to set the ip_summed via the packet socket or is it
> always 0 (== CHECKSUM_NONE)?

af_packet only reads ip_summed in the receive path. It is not set when 
creating the outgoing skb where the struct skb is mainly zero'ed.

> 
>> +
> 
> Please remove that empty line.
> 

ok.

>> +		/* init headroom */
>> +		can_skb_prv(skb)->ifindex = dev->ifindex;
>> +		can_skb_prv(skb)->skbcnt = 0;
>> +
>> +		skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +
>> +		/* preform proper loopback on capable devices */
>> +		if (dev->flags & IFF_ECHO)
>> +			skb->pkt_type = PACKET_LOOPBACK;
>> +		else
>> +			skb->pkt_type = PACKET_HOST;
>> +
>> +		skb_reset_mac_header(skb);
>> +		skb_reset_network_header(skb);
>> +		skb_reset_transport_header(skb);
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /* Drop a given socketbuffer if it does not contain a valid CAN frame. */
>>   static inline bool can_dropped_invalid_skb(struct net_device *dev,
>>   					  struct sk_buff *skb)
>> @@ -108,6 +140,9 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
>>   	} else
>>   		goto inval_skb;
>>   
>> +	if (can_check_skb_headroom(dev, skb))
> 
> Can you rename the function, so that it's clear that returning false
> means it's an invalid skb?
> 

Returning 'false' is *good* like in can_dropped_invalid_skb(). What 
naming would you suggest?

Regards,
Oliver
