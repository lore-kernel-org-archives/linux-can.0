From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socket can receive order
Date: Tue, 08 Sep 2015 18:56:30 +0200
Message-ID: <55EF133E.8070105@hartkopp.net>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:44962 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905AbbIHQ4j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 12:56:39 -0400
In-Reply-To: <55EEC3C0.1010002@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Hi all,

On 08.09.2015 13:17, Daniel Squires wrote:
> On 08/09/15 12:13, Marc Kleine-Budde wrote:

>>> I can see the packets coming in the correct order in wireshark and it is
>>> not immediately obvious to me how the kernel module could mix up the
>>> order, so it seems that it must be something that happens at the socket
>>> level?
>> The kernel module "produces" the CAN frames, so if you see them in the
>> correct order in wireshark, they have left the module in the right order.

Yes. This is trivial.

But Daniel is right to ask about the frame reordering on socket level - better 
say - reordering outside the driver level.

>
> Sorry , I should have been clearer here, in wireshark was looking at the USB
> frames not the CAN frames. however I think what you say still stands due to
> the time stamps being in the correct order.
>>
>>> candump can3 -tz
>>> <snip>
>>>    (003.088648)  can3  043   [8]  F7 2D 00 00 00 00 00 00
>>>    (003.089149)  can3  045   [8]  F9 2D 00 00 00 00 00 00
>>>    (003.088897)  can3  044   [8]  F8 2D 00 00 00 00 00 00
>> The timestamps are in the correct order. Maybe Oliver can help here,
>> he's an expert when it comes to strange reordering :)

Will try - see below.

>>
>>> On the top level I am using CANFestival for CANOpen implementation, so
>>> it has occurred to me I could implement a CANFestival "driver" using
>>> libusb and completely bypass the kernel module and socket can layers,
>>> but I hope not to have to do this.
>> Na, you don't want to do this.

The point this that it would not help either - even if you are using the 
PF_PACKET socket (which wireshark does) - bypassing the CAN network layer 
modules (can, can_raw) doesn't fix the problem.

I discussed the problem on netdev ML as I discovered a out-of-order issue when 
fixing the CAN_RAW join feature.

When you have a multicore SMP processor the interrupt can be processed by 
different CPUs, which can lead to packet reordering when using netif_ix() on 
driver level.

The discussion ended with the networking guys pointing me to use NAPI which 
does not really help, e.g. there's only one USB network adapter in 
linux/drivers/net which is a complete mess.

My suggestion was to set a hash value into the socket buffer (skb) at driver 
level, which is used for generating a 'flow' for IP traffic too. You can 
generate flows by hashes to put all traffic from a specific IP into the same 
per-cpu input queue to help TCP assembling the packets in the softirq for this 
IP address in correct order (aha!).

See http://marc.info/?l=linux-netdev&m=143689694125450&w=2

I assume the networking guys interpreted my suggestion as hack as they are not 
aware how 'addressing' is done in CAN. They only know about IP ...

NAPI is not really a valid solution for CAN USB adapters and I think I'll have 
to restart the discussion as out-of-order frames are a no-go for CAN as it 
kills ISO15765-2 and (obviously) CANopen segmentation.

I assume Daniel uses a multicore system, right?

If so, please try the 'hack' I suggested on the netdev ML if it fixes your 
problem. It might help for the discussion too.

Regards,
Oliver
