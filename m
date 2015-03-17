From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add new socket option CAN_RAW_FILTER_UNIQUE to eliminate
 duplicate matches
Date: Tue, 17 Mar 2015 16:25:51 +0100
Message-ID: <5508477F.80303@hartkopp.net>
References: <1426597107-7590-1-git-send-email-socketcan@hartkopp.net> <55082ADE.4050602@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:58830 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618AbbCQPZ4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 11:25:56 -0400
In-Reply-To: <55082ADE.4050602@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andre Naujoks <nautsch@gmail.com>

Hi Marc,

I know why I thought it will get messy ...

E.g. when you notch three CAN IDs like this:

candump can0,100~7FF,200~7FF,400~7FF

You will get *without* the unify option:

cansend can0 100#	-> two times CAN frame with 0x100
cansend can0 200#	-> two times CAN frame with 0x200
cansend can0 400#	-> two times CAN frame with 0x400
cansend can0 333#	-> three times CAN frame with 0x333

You will get *with* the unify option from the posted patch:

cansend can0 100#	-> one time CAN frame with 0x100
cansend can0 200#	-> one time CAN frame with 0x200
cansend can0 400#	-> one time CAN frame with 0x400
cansend can0 333#	-> one time CAN frame with 0x333

... the same as 'candump can0' %-(

So what you probably *want* to have is:

cansend can0 100#	-> no CAN frame
cansend can0 200#	-> no CAN frame
cansend can0 400#	-> no CAN frame
cansend can0 333#	-> one CAN frame with 0x333

Right?

An approach to solve exactly this use case could be to check whether *all* 
configured filters have passed the CAN frame.

This could be done by counting the receptions of the identical frames:

diff --git a/net/can/raw.c b/net/can/raw.c
index e593dc7..3022c25 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -78,6 +78,7 @@ MODULE_ALIAS("can-proto-1");
  struct unique_can_frame {
  	struct sk_buff *skb;
  	ktime_t tstamp;
+	int rx_count;
  };

  struct raw_sock {
@@ -130,11 +131,15 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
  	/* eliminate multiple filter matches for the same skb */
  	if (ro->filter_unique) {
  		if (ro->uniq_cf.skb == oskb &&
-		    ktime_equal(ro->uniq_cf.tstamp, oskb->tstamp))
-			return;
-
-		ro->uniq_cf.skb = oskb;
-		ro->uniq_cf.tstamp = oskb->tstamp;
+		    ktime_equal(ro->uniq_cf.tstamp, oskb->tstamp)){
+			ro->uniq_cf.rx_count++;
+			if (ro->uniq_cf.rx_count < ro->count)
+				return;
+		} else {
+			ro->uniq_cf.skb = oskb;
+			ro->uniq_cf.tstamp = oskb->tstamp;
+			ro->uniq_cf.rx_count = 1;
+		}
  	}

  	/* do not pass non-CAN2.0 frames to a legacy socket */

(based on the patch before)

But does it really make sense to put such a tricky thing into the raw socket?

It flips the OR sematic to an AND semantic over the provided filters.
And then the name of the socket option should be adapted too.
Something like "all filters must match"

Regards,
Oliver



On 17.03.2015 14:23, Oliver Hartkopp wrote:
> Hi Marc,
>
> On 17.03.2015 13:58, Oliver Hartkopp wrote:
>> The CAN_RAW socket can set multiple CAN identifier specific filters that lead
>> to multiple filters in the af_can.c filter processing. These filters are
>> indenpendent from each other which leads to logical OR'ed filters when applied.
>>
>> Especially when the filter is intended to notch single CAN IDs or CAN ID ranges
>> a problem emerges when using more than just one filter: The notched CAN IDs
>> will be delivered once while the other CAN IDs will be delivered twice.
>>
>> This patch implements a new option to make sure that every CAN frame which is
>> filtered for a specific socket is only delivered once to the user space.
>> This is independent from the number of matching CAN filters of this socket.
>
> Just to make sure, this patch really helps:
>
> With the example above all CAN frames are delivered just once. The OR'ed
> filters still match. So you won't have the solution that you can have
> different notched areas of CAN IDs ...
>
> I hope I expressed myself clearly.
>
> Regards,
> Oliver
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
