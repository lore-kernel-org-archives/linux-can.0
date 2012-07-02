From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [RFC PATCH] can: dev: update rx state in the can_get_echo_skb()
Date: Mon, 2 Jul 2012 11:36:43 +0800
Message-ID: <4FF1174B.1000209@gmail.com>
References: <1340876540-27840-1-git-send-email-jason77.wang@gmail.com> <4FEC3917.5020905@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55869 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2GBDhS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 23:37:18 -0400
In-Reply-To: <4FEC3917.5020905@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Hui Wang <jason77.wang@gmail.com>, mkl@pengutronix.de, shawn.guo@linaro.org, linux-can@vger.kernel.org

Wolfgang Grandegger wrote:
> On 06/28/2012 11:42 AM, Hui Wang wrote:
>   
>> After a loopback packet is routed to rx interface, we forget to update
>> rx state both in the can_get_echo_skb() and in the controller specific
>> drivers, as a result, after we sent a loopback packet and executed
>> ifconfig, following state is outputed:
>> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:10
>>           RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)
>>
>> We add rx state update in the can_get_echo_skb() to solve this
>> problem.
>>     
>
> Well...
>
>   
>> Cc: linux-can@vger.kernel.org
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Wolfgang Grandegger <wg@grandegger.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>> ---
>> I don't know if it is designed like that on purpose, please instruct
>> me if i am wrong.
>>
>> I use following commands to let flexcan to work in the loopback mode:
>> %>ip link set can0 type can bitrate 125000
>> %>ip link set can0 type can loopback on
>> %>ip link set can0 up
>> And send a packet:
>> %>cantest can0 123#AABBCCDD
>> When i check net device state, i found tx doesn't equal rx:
>> %>ifconfig
>> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>>     
>
> This means that one message has successfully been sent to the *real* CAN
> bus.
>
>   
>>           collisions:0 txqueuelen:10
>>           RX bytes:0 (0.0 B)  TX bytes:4 (4.0 B)
>>
>> >From my understanding, i suppose it should be:
>> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-<snip>
>>           UP RUNNING NOARP  MTU:16  Metric:1
>>           RX packets:1 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:10 
>>           RX bytes:4 (4.0 B)  TX bytes:4 (4.0 B)
>>     
>
> Why, you have not received any message from the CAN bus. If you want to
> count looped back messages, it should be:
>
>   
You mean CAN bus didn't receive a packet,  the RX state of CAN0 is 0. It 
is a reasonable explanation.

Thanks,
Hui.
>           RX packets:1 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
>
> Wolfgang.
>
>   

