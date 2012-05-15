From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v4] CAN FD support
Date: Tue, 15 May 2012 22:33:06 +0200
Message-ID: <4FB2BD82.2060105@hartkopp.net>
References: <4FB25A39.7090608@hartkopp.net> <20120515135429.GB1414@vandijck-laurijssen.be> <4FB27B78.4070002@hartkopp.net> <20120515184832.GA414@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:22313 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966452Ab2EOUdG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 16:33:06 -0400
In-Reply-To: <20120515184832.GA414@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.05.2012 20:48, Kurt Van Dijck wrote:

> On Tue, May 15, 2012 at 05:51:20PM +0200, Oliver Hartkopp wrote:
>> On 15.05.2012 15:54, Kurt Van Dijck wrote:
>>
>>> [...]
>>>> @@ -119,6 +120,14 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>>>>  	if (!ro->recv_own_msgs && oskb->sk == sk)
>>>>  		return;
>>>>  
>>>> +	/* do not pass frames with DLC > 8 to a legacy socket */
>>>> +	if (!ro->fd_frames) {
>>>> +		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
>>>> +
>>>> +		if (unlikely(cfd->len > CAN_MAX_DLEN))
>>> idea:
>>> 			cfd->len = CAN_MAX_LEN;
>>>
>>> but this modification must then be done _after_ the skb_clone below.
>>
>>
>> I dislike cutting payload data, because people would not be able to detect
>> that.
> Yep, that true as well.
> Better leave it the way it is now.
> 


Yep.

I pushed three commits to my can-utils git clone:

https://gitorious.org/linux-can/hartkopps-can-utils/commit/5d2964c5ffbf2a4a319893ac46f26276e4121c92/diffs/3698d3201c86d57eb6828fa3ed40db1d1d5fea51

If you look at the (not beautified) changes in cansend ... it looks like an
award-winning simple upgrade for CAN FD support, doesn't it?

:-)

So far i can send CAN FD frames after setting my device to CANFD_MTU:

# ifconfig vcan0 mtu 72
SIOCSIFMTU: Device or resource busy
# ifconfig vcan0 down
# ifconfig vcan0 mtu 72
# ifconfig vcan0 up  


# ip -statistics link show vcan0
4: vcan0: <NOARP,UP,LOWER_UP> mtu 72 qdisc noqueue state UNKNOWN mode DEFAULT 
    link/can 
    RX: bytes  packets  errors  dropped overrun mcast   
    46         8        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    46         8        0       0       0       0      
# ./cansend vcan0 123#001122334455667788
# ip -statistics link show vcan0
4: vcan0: <NOARP,UP,LOWER_UP> mtu 72 qdisc noqueue state UNKNOWN mode DEFAULT 
    link/can 
    RX: bytes  packets  errors  dropped overrun mcast   
    55         9        0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    55         9        0       0       0       0 

length = 9 !!

Let's see how easy candump can be converted ... tomorrow.

Regards,
Oliver
