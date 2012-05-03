From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support
Date: Thu, 03 May 2012 14:38:20 +0200
Message-ID: <4FA27C3C.8010806@hartkopp.net>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com> <4FA26F65.5020804@hartkopp.net> <4FA275C1.4080905@grandegger.com> <20120503121833.GC416@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:12646 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2ECMil (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 08:38:41 -0400
In-Reply-To: <20120503121833.GC416@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 14:18, Kurt Van Dijck wrote:

> On Thu, May 03, 2012 at 02:10:41PM +0200, Wolfgang Grandegger wrote:
>> On 05/03/2012 01:43 PM, Oliver Hartkopp wrote:
>>> On 03.05.2012 13:34, Wolfgang Grandegger wrote:
>>>
>>>>> diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
>>>>> index ea2d942..bddbafb 100644
>>>>> --- a/drivers/net/can/vcan.c
>>>>> +++ b/drivers/net/can/vcan.c
>>>>> @@ -74,9 +74,8 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
>>>>>  	struct net_device_stats *stats = &dev->stats;
>>>>>  
>>>>>  	stats->rx_packets++;
>>>>> -	stats->rx_bytes += cf->can_dlc;
>>>>> +	stats->rx_bytes += can_dlc2len(cf->can_dlc);
>>>>
>>>> Hm, I think "cf->can_dlc" should contain the *real* length. That would
>>>> simplify things a lot. The conversion is done when the corresponding DLC
>>>> registers are read or written.
>>>
>>>
>>> I thought about this idea some time too.
>>>
>>> My problem was that 'can_dlc' says
>>>
>>> "CAN data length *code*"
>>>
>>> And the dlc for CAN is already well defined.
>>>
>>> >From a todays view cf->len would indeed be a better expression :-/
>>
>> Yes, definitely.
>>
>>>
>>> We could generally think about a union of 'can_dlc' and 'len' though, where
>>> can_dlc would not be part of struct canfd_frame but only the len value.
>>
>> Well, we do not need dlc in the struct, just len. The conversion
>> len->dlc needs just to be done once when register is read/written.
>>
>>> As you can see here, i also had the idea of providing both values:
>>>
>>> https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next/commit/dc730b789cc1a6a3c04aaacde02c6a5a81988869
>>>
>>> But is was a bad design, as you have two APIs modifying one value - you
>>> never know what to trust ... it was a sanity check hell.
>>
>> If "cf->can_dlc", or however it is named, does not contain the real
>> length, we will end up in a dlc2len conversion nightmare. Be aware the
> 
> I share this.
> I'd even prefer u16 over u8 even.
> No legacy issues exist when changing the meaning of can_dlc, since current
> CAN frames have equal values for DLC & length!
> 
>> the struct is also used by the app.


Yes - that's the main problem IMO.

What about this binary compatible introduction of cf->len ...

diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index bddbafb..366924e 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -74,7 +74,7 @@ static void vcan_rx(struct sk_buff *skb, struct net_device *dev)
 	struct net_device_stats *stats = &dev->stats;

 	stats->rx_packets++;
-	stats->rx_bytes += can_dlc2len(cf->can_dlc);
+	stats->rx_bytes += cf->len;

 	skb->pkt_type  = PACKET_BROADCAST;
 	skb->dev       = dev;
@@ -93,7 +93,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct
net_device *dev)
 		return NETDEV_TX_OK;

 	stats->tx_packets++;
-	stats->tx_bytes += can_dlc2len(cf->can_dlc);
+	stats->tx_bytes += cf->len;

 	/* set flag whether this packet has to be looped back */
 	loop = skb->pkt_type == PACKET_LOOPBACK;
@@ -107,7 +107,7 @@ static netdev_tx_t vcan_tx(struct sk_buff *skb, struct
net_device *dev)
 			 * CAN core already did the echo for us
 			 */
 			stats->rx_packets++;
-			stats->rx_bytes += can_dlc2len(cf->can_dlc);
+			stats->rx_bytes += cf->len;
 		}
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
diff --git a/include/linux/can.h b/include/linux/can.h
index 74052da..b99f9f1 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -57,7 +57,10 @@ typedef __u32 can_err_mask_t;
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* data length code: 0 .. 8 */
+	union {
+		__u8    can_dlc; /* data length code: 0 .. 8 */
+		__u8    len; /* data length: 0 .. 8 */
+	};
 	__u8    data[8] __attribute__((aligned(8)));
 };

@@ -84,7 +87,7 @@ struct can_frame {
  */
 struct canfd_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* CAN FD data length code: 0 .. 0xF */
+	__u8    len;     /* data length: 0 .. 64 */
 	__u8    flags;   /* additional flags for CAN FD */
 	__u8    __res0;  /* reserved / padding */
 	__u8    __res1;  /* reserved / padding */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1b7f1f8..9986d9c 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -875,7 +875,7 @@ static __init int can_init(void)
 {
 	/* check for correct padding that can_dlc owns always the same position */
 	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
-		     offsetof(struct canfd_frame, can_dlc));
+		     offsetof(struct canfd_frame, len));

 	printk(banner);

