From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 09/14] can: raw: use struct sock::sk_bound_dev_if instead
 of struct raw_sock::ifindex
Date: Sun, 27 Aug 2017 16:27:26 +0200
Message-ID: <e1f0b97a-201e-8c33-f6d4-e6b9b5e96af8@hartkopp.net>
References: <20170802174434.4689-1-mkl@pengutronix.de>
 <20170802174434.4689-10-mkl@pengutronix.de>
 <da0c99fe-16ca-6e3a-0249-663b0691c850@hartkopp.net>
 <20170824141126.GD21548@airbook.vandijck-laurijssen.be>
 <e1a150f8-7a0b-b327-86ac-e66cf3d817ef@hartkopp.net>
 <20170825093410.GC18332@airbook.vandijck-laurijssen.be>
 <f739fc65-5f17-532c-a635-0cc2fe8e2382@hartkopp.net>
 <20170825184644.GB6602@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:25826 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdH0O1e (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 27 Aug 2017 10:27:34 -0400
In-Reply-To: <20170825184644.GB6602@airbook.vandijck-laurijssen.be>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de



On 08/25/2017 08:46 PM, Kurt Van Dijck wrote:
> Hey Oliver,
> 
>> On 08/25/2017 11:34 AM, Kurt Van Dijck wrote:
>>>> On 08/24/2017 04:11 PM, Kurt Van Dijck wrote:
>>>>>>> This patch removes the struct raw_sock::ifindex from the CAN raw socket
>>>>>>> and uses the already existing sock::sk_bound_dev_if instead.
>>>>>>
>>>>>> I would like to omit this patch.
>>>>>>
>>>>>> 1. It does NOT increase the readability ;-)
>>>>>>
>>>>>> ifindex points out that we are handling an interface index.
>>>>>> sk_bound_dev_if could be anything.
>>>>>
>>>>> See http://elixir.free-electrons.com/linux/v4.12.8/source/net/core/sock.c#L617
>>>>> sk_bound_dev_if may be a difficult name, but could not be anything.
>>>>> It allow to use SO_BINDTODEVICE (man 7 socket) to work properly for can raw sockets too.
>>>>
>>>> When ro->ifindex = 0 it can still be bound in the case of CAN sockets.
>>>> There is a different semantic as ifindex = zero means 'all CAN interfaces'
>>>> and not 'no interface'.
>>>
>>> ro->ifindex = 0: accept traffic from all interfaces
>>> ro->ifindex != 0: accept traffic only from 1 iface
>>>
>>> sk_bound_dev_if = 0: accept traffic from all interfaces
>>> sk_bound_dev_if != 0: accept traffic only from 1 iface
>>>
>>> What is the semantic difference?
>>
>> man 7 socket
>>
>> SO_BINDTODEVICE
>>
>> Bind this socket to a particular device like “eth0”, as specified in the
>> passed interface name.  If the name  is  an empty  string  or the option
>> length is zero, the socket device binding is removed.  The passed option is
>> a variable-length null-terminated interface name string with the maximum
>> size of IFNAMSIZ.  If a socket is bound to  an  interface,  only  packets
>> received from that particular interface are processed by the socket. Note
>> that this works only for some socket types, particularly AF_INET sockets.
>> It is not supported for packet  sockets  (use  normal bind(2) there).
> 
> A verbatim copy of the man page isn't helping. I have read it.
> 
>>
>> Especially "If the name  is  an empty  string  or the option length is zero,
>> the socket device binding is removed." is wrong.
> 
> Do you mean the man page is wrong?
> Or do you mean that the semantic difference is wrong?

Yes. It tells us:

"If the name  is  an empty  string  or the option length is zero, the 
socket device binding is removed."

Which means the status of 'bind' is NOT decoupled from the number in 
ifindex.

A provided empty string leads to an unbound socket - and not to a socket 
bound to ifindex=0 which is intended with CAN sockets.

> Or ?
> 
>>
>> A bound CAN_RAW socket can have ifindex = 0.
> 
> I see no reason why a bound UDP socket can not have sk_bound_dev_if = 0.
> I see no reason why a bound CAN_RAW socket can not either.
> I start to think here that the word 'device binding' confuses you with
> bind(2), but I have not seen any reference that SO_BINDTODEVICE
> conflicts/interacts with bind() so far.
> 
>>
>> And "It is not supported for packet  sockets  (use  normal  bind(2) there)"
>> - the CAN_RAW socket is based on PF_PACKET sockets with the device binding
>> and addressing concept.
>>
>> The more I look into this, the more I'm sure that we should leave it as-is.
> 
>>>>>> I would like to omit this patch.
> 
> Well, I feel it may block the others, so indeed, omitting may be the
> best by lack of consensus.

Ok. We should omit this patch.

But I'm more interested in convincing you than just omitting this patch 
to not block the upstream process ;-)

Best regards,
Oliver
