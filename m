From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 May 2016 10:17:13 +0200
Message-ID: <5732EA89.5060303@hartkopp.net>
References: <1378920814-sup-4559@pruts.nl> <1462908218-sup-6526@pruts.nl>
 <5732E1F9.1060908@hartkopp.net> <1462952665-sup-1016@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:20899 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbcEKIRT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 04:17:19 -0400
In-Reply-To: <1462952665-sup-1016@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <ico@pruts.nl>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Ico,

On 05/11/2016 09:48 AM, Ico Doornekamp wrote:
> * On 2016-05-11 09:40:41 +0200, Oliver Hartkopp wrote:
>
>> usually the CAN subsystem has no problems with host/network byte order:
>> The struct can_frame contains the CAN ID which is set into the CAN
>> controller registers inside the CAN driver.
>>
>> As wireshark uses the PF_PACKET socket to read the CAN frames it might
>> make assumptions about the byte order of read elements.
>>
>> Can you check the output from tst-packet on vcan0 / slcan0:
>>
>>      ./tst-packet -i vcan0
>
> Yes, this gives the expected result for both vcan and slcan:
>
>    $ sudo ./tst-packet
>    123  [4] 00 00 00 00
>    123  [4] 00 00 00 00
>
> Still it makes no sense to me that wireshark does seem to make a
> difference when sniffing on vcan and slcan:

That's strange indeed.

Both interfaces do not support IFF_ECHO (echo of sent CAN frames on 
driver level) so both should trigger this shortcut in af_can.c:

http://lxr.free-electrons.com/source/net/can/af_can.c#L284

Can you send the output of

ip -details link show vcan0
ip -details link show slcan0

??

>
>   1 0.000000 -> CAN 12 STD: 0x00000123 00 00 00 00
>   1 0.000000 -> CAN 16 ERR: 0x03010000 00 00 00 00

At least the CAN ID is 'AND'ed with CAN_ERR_MASK 0x1FFFFFFF :-)
That's the reason for the missing '2' due to  CAN_ERR_FLAG.

>
> I'll try to find the time to dig in the kernel and wireshark code to
> find out what causes the difference.

Btw, can you check if this patch fixes the issue:

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 9a3f15c..58ba098 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -202,16 +202,19 @@ static void slc_bump(struct slcan *sl)
  		}
  	}

-	skb = dev_alloc_skb(sizeof(struct can_frame) +
-			    sizeof(struct can_skb_priv));
-	if (!skb)
+	skb = netdev_alloc_skb(sl->dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct can_frame));
+	if (unlikely(!skb))
  		return;

-	skb->dev = sl->dev;
  	skb->protocol = htons(ETH_P_CAN);
  	skb->pkt_type = PACKET_BROADCAST;
  	skb->ip_summed = CHECKSUM_UNNECESSARY;

+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
  	can_skb_reserve(skb);
  	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
  	can_skb_prv(skb)->skbcnt = 0;


I posted this patch in February 2015

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=969439016d2cf61fef53a973d7e6d2061c3793b1

and obviously forgot slcan.c ...

Thanks,
Oliver

