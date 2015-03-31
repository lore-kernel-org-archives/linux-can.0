From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC v2 2/2] can: introduce new raw socket option to join
 the given CAN filters
Date: Tue, 31 Mar 2015 22:30:09 +0200
Message-ID: <551B03D1.2020801@hartkopp.net>
References: <1427652564-32181-1-git-send-email-socketcan@hartkopp.net> <1427652564-32181-3-git-send-email-socketcan@hartkopp.net> <551A94D0.1010608@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:42780 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbbCaUaM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Mar 2015 16:30:12 -0400
In-Reply-To: <551A94D0.1010608@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org

On 31.03.2015 14:36, Marc Kleine-Budde wrote:
> On 03/29/2015 08:09 PM, Oliver Hartkopp wrote:


>> @@ -128,10 +130,20 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>>   	/* eliminate multiple filter matches for the same skb */
>>   	if (*this_cpu_ptr(ro->uniq_skb) == oskb &&
>>   	    ktime_equal(*this_cpu_ptr(ro->uniq_tstamp), oskb->tstamp)) {
>> +		if (ro->join_filters) {
>> +			this_cpu_inc(*ro->join_rx_count);
>> +			/* drop frame until all enabled filters matched */
>> +			if (*this_cpu_ptr(ro->join_rx_count) < ro->count)
>
> Can we be sure, that all skbs are processed on the same CPU? So that
> it's sufficient to just compare the "ro->join_rx_count" of this CPU with
> "ro->count" (or do we have to use join_rx_count of all CPUs?)
>

No, that's exactly the point that the single CAN frame skb is processed inside 
the softirq by one CPU. And we count only for this specific skb here.

The next frame which is processed in raw_rcv() might use another CPU while 
executing the NET_RX softirq.

>> +				return;
>> +		} else
>>   			return;
>
> nitpick: please use { } on both sides of the else.
>

fixed in v3

Regards,
Oliver


