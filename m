From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Wed, 04 Jul 2012 18:23:46 +0200
Message-ID: <4FF46E12.8060102@hartkopp.net>
References: <20120703232328.GD6616@ovro.caltech.edu> <4FF40A6E.1040709@grandegger.com> <20120704120736.GB417@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:51062 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab2GDQXp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 12:23:45 -0400
In-Reply-To: <20120704120736.GB417@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>, Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On 04.07.2012 14:07, Kurt Van Dijck wrote:

> On Wed, Jul 04, 2012 at 11:18:38AM +0200, Wolfgang Grandegger wrote:
>> Hi Ira,
>>
>> On 07/04/2012 01:23 AM, Ira W. Snyder wrote:
>>> Hello everyone,
>>>
>>> I'm finally implementing SocketCAN support in our internal codebase, and
>>> have run across some issues. We previously used a character driver provided
>>> by the vendor.
>>>
>>> I myself implemented the driver for the Janz ICAN3 card. It has been in
>>> mainline Linux since 2.6.35.
>>>
>>> The hardware is an SJA1000 chip plus a microcontroller and some RAM. All
>>> messages go through the microcontroller firmware.
>>>
>>> This firmware has the following features:
>>> - it does have hardware-supported local loopback
>>> - it does NOT have any sort of "tx-complete" notification or interrupt
>>> - it does NOT have any indication that a frame went through the
>>>   hardware-supported local loopback
>>>
>>> To work around the lack of "tx-complete" interrupts, I used the hardware
>>> local loopback feature. Every frame has hardware loopback set, which causes
>>> the ican3_napi() routine to be called for each frame sent. This works fine,
>>> except that sockets created with the default options (loopback on,
>>> can_raw_recv_own_msgs off) do receive their own messages. This seems wrong.
>>>
>>> QUESTION 1:
>>> The functions can_(get|put)_echo_skb() are not used at all. Is this wrong?
>>
>> Not necessarily. IIRC, the early versions of the Flexcan driver used the
>> hardware loopback as well but switched to classical echo-skb handling
>> because of the problem with recv-own-msgs.
>>
>>> QUESTION 2:
>>> The socketcan test tst-rcv-own-msgs says:
>>> Starting PF_CAN frame flow test.
>>> checking socket default settings ... failure!
>>>
>>> If I understand the code correctly, this means that the sending socket
>>> received an echo frame when it should not have received one.
>>>
>>> This matches what I expect the code to do.
>>>
>>> How can I fix this?
>>>
>>> OBSERVATION 1:
>>> The following patch drops the relevant calls to netif_stop_queue() and
>>> netif_wake_queue(), as well as the hardware-supported local loopback.
>>>
>>> The tst-rcv-own-msgs test passes.
>>>
>>> Is dropping these API calls a reasonable thing to do?
> 
> I'm not sure.
>>
>> Well, that controller will not allow to support all features and options
>> and we need to make a choice:
>>
>>  recv-own-msgs support versus proper tx-done handling (correct timing)
>>
>> As the recv-own-msgs is not used frequently, it would not be really
>> dramatic if the feature is not available.
> 
> My opinion:
> 
> 1) is the correct timing of tx-done more used than recv-own-msgs?
>    I think such choices are really hard to make.
>    Avoid choosing if possible.
> 
> 2) To avoid choosing, you could:
>    a. use can_put_echo_skb()
>    b. when an rx interrupt && the frame matches the next echo_skb,
>       drop the rx frame and deliver echo_skb.
>    I realise that b. needs some code in generic can_dev (something like
>    can_peek_echo_skb()), and costs you some performance.
> 


Hello all,

i also thought about your case 'b' and it could be a good choice indeed.

First it is generally an unusual case that you receive a CAN-ID from the
'outside' that is sent from the local host. But of course we can not assume
this 'good CAN network design rule' is to be implemented always ...

Anyway we currently have the flexcan and the ican3 hardware that generally
supports a loopback on hardware level but looses the reference to the tx-skb
and therefore to the sk pointer which is used to identify the originating
socket for recv-own-msgs support.

If we receive a new CAN frame and there are any CAN frames stored in the
echo_skb cache, we can compare the received frame with the cached frames.

If we find an identical CAN frame, we get the echo_skb and push it into the
receive path. For that reason the flexcan and ican3 driver should only
allocate a new rx skb when there's no matching echo_skb available.

What could happen, if we (unlikely) *really* receive an identical CAN frame
content from the 'outside' we already have in the echo_skb cache?

Well the only thing that comes in mind is that we would mix these two
*identical* frames in their order and therefore in their timestamp. Additional
it can be assumed that the second 'identical' frame is following instantaneous.

To me this looks like a acceptable risk - especially as it is opposed to the
'good CAN network design rule' to have identical CAN-IDs.

@Ira: Do you want to propose a patch which adds the echo_skb cache check for
received CAN frames for the ican3 driver?

Regards,
Oliver
