From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v4] CAN FD support
Date: Tue, 15 May 2012 17:51:20 +0200
Message-ID: <4FB27B78.4070002@hartkopp.net>
References: <4FB25A39.7090608@hartkopp.net> <20120515135429.GB1414@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:62890 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2EOPvU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 11:51:20 -0400
In-Reply-To: <20120515135429.GB1414@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.05.2012 15:54, Kurt Van Dijck wrote:

> Oliver,
> 
> A few nitpicks, and 1 change of behaviour, as announced in my last reply
> on v3.
> 

> [...]
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 151b773..98b5604 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1357,6 +1357,13 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
>>  
>>  	switch (msg) {
>>  
>> +	case NETDEV_CHANGEMTU:
>> +		/*
>> +		 * Changing the MTU breaks the frame size that was formerly
>> +		 * registered. The change can only be done when the interface
>> +		 * ist down. Btw. make sure to get no trash from the device and
> 'ist' sound german.
> You have this in several places :-)


Oh, snap! German engineering :-)

http://www.youtube.com/watch?v=0I0WfnhVs2s

Fixed the typo in my git repo.

>> +		 * drop this device from the open sockets perspective.
>> +		 */
>>  	case NETDEV_UNREGISTER:
>>  		lock_sock(sk);
>>  
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index cde1b4a..a20ee8e 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
> [...]
>> @@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>>  	if (!ro->recv_own_msgs && oskb->sk == sk)
>>  		return;
>>  
>> +	/* do not pass frames with DLC > 8 to a legacy socket */
>> +	if (!ro->fd_frames) {
>> +		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
>> +
>> +		if (unlikely(cfd->len > CAN_MAX_DLEN))
> idea:
> 			cfd->len = CAN_MAX_LEN;
> 
> but this modification must then be done _after_ the skb_clone below.


I dislike cutting payload data, because people would not be able to detect
that. It's better to provide nothing than to provide manipulated data.

It's hard for me to follow your argument that people will get confused when
they don't see a CANFD frame on a legacy RAW socket.

Up to then CANFD capable CAN tools will be surely available too.

>> +			/* return; */
>> +	}
>> +
>>  	/* clone the given skb to be able to enqueue it into the rcv queue */
>>  	skb = skb_clone(oskb, GFP_ATOMIC);
>>  	if (!skb)
>> @@ -246,6 +255,13 @@ static int raw_notifier(struct notifier_block *nb,
>>  
>>  	switch (msg) {
>>  
>> +	case NETDEV_CHANGEMTU:
>> +		/*
>> +		 * Changing the MTU breaks the frame size that was formerly
>> +		 * registered. The change can only be done when the interface
>> +		 * ist down. Btw. make sure to get no trash from the device and
>> +		 * drop this device from the open sockets perspective.
>> +		 */
> 
> why exactly?


The MTU can only be changed when the interface is down. But the registered CAN
device specific filters are not removed on interface DOWN/UP sequence.

Probably removing the registered filters is not so relevant anymore as we have
the simultaneous access for new/legacy apps now. Will think about it.

Regards,
Oliver
