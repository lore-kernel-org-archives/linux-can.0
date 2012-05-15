From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 15:01:28 +0200
Message-ID: <4FB253A8.3090500@hartkopp.net>
References: <4FAD5A04.2030108@hartkopp.net> <20120514093630.GA600@vandijck-laurijssen.be> <4FB16213.2000007@hartkopp.net> <20120515083454.GA504@vandijck-laurijssen.be> <4FB21FA5.8080807@hartkopp.net> <20120515100318.GG504@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:60619 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932154Ab2EONB1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 09:01:27 -0400
In-Reply-To: <20120515100318.GG504@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.05.2012 12:03, Kurt Van Dijck wrote:

> On Tue, May 15, 2012 at 11:19:33AM +0200, Oliver Hartkopp wrote:

>>>> 2. in any case legacy applications must not get CAN frames with a DLC > 8
>>> Or cut the DLC to 8, and drop the remainder of the message? This changes
>>> the actual can(fd)_frame. That is acceptable since you're running legacy apps
>>> on CANFD bus.
>>>
>>> An alternative could be to drop CANFD frames in can_recv() itself.
>>> This may sound inefficient, but remind you're running legacy apps on CANFD busses
>>> _WITH_ CANFD frames on it.
>>
>>
>> I have a patch for that later in this mail.
> waaw. You're running _with_ HDR bit on :-) ?


The effect is when you use legacy can_frames the canfd_frame.flags is not set
explicitly. Therefore you need a (per device?) setting how to deal with the
short CAN_MTU frames. Assuming HDR bit settings in CAN_MTU sized frames is wrong.

(..)

>> Yes. Especially we need to specify how the CAN controller should send
>> can_frames passed to its CAN driver. Should it been send with or without
>> EDL bit, and should it been send with high data rate or not.
>>
>> This is what i wanted to suggest with the global CANFD driver settings.
> 
> netlink-wise, I would have considered this a device setting.
> 


Yep! It's a job for drivers/net/can/dev.c :-)


>> Here's my patch:
> 
>>
>> Changes to the previous version:
>>
>> CANFD aware apps set CAN_RAW_FD_FRAMES to enable longer MTUs (not new).
>>
>> 1. CANFD aware apps may get CAN_MTU and CANFD_MTU frames on rx
>> 2. CANFD aware apps may send CAN_MTU and CANFD_MTU frames on tx
>> 3. legacy apps can receive CAN_MTU and CANFD_MTU frames if the DLC <= 8
>>    (the possible CANFD_MTU is cut down to CAN_MTU to preserve the ABI)
>>
>> Effects to the CAN netdev driver:
>>
>> Legacy operation (CAN_MTU)
>> - send and receive struct can_frames
>>
>> CANFD operation (CANFD_MTU and CAN_MTU)
>> - you can send CANFD_MTU and CAN_MTU frames
>>   (a default setting (EDL, HDR) for CAN_MTU frames needs to be specified)
>> - the driver generates always canfd_frames on reception
> Interesting.
> How does a driver makes the difference between received
> CAN2.0B frames & CANFD frames?


As you always generate canfd_frames in this operating mode you can express
this information within canfd_frame.flags.

> I think it makes sense, equally to the send() path, to allow the driver
> to generate can_frame _or_ canfd_frame on reception, depending on the
> bitstream (if possible).


As written above this can be done with a singe canfd_frame.

A legacy app would get the can_frame as-is when DLC <= 8
A CANFD frame can evaluate the bits if they are at least interesting for the
app. For a detailed 'candump' output this could be interesting ;-)

> 
> A CANFD application will then be able to distinguish between them based
> on the return value of recv_msg (CAN_MTU or CANFD_MTU, even with payload <= 8).


There's no reason to provide a CAN_MTU frame to a CANFD application once the
driver is switched to CANFD-mode.

The CANFD app only gets the old-style CAN_MTU frames when the CAN interface is
not in CANFD mode.

> 
> Did I mention I very much like this additional patch?
> Well done.


Thanks to you! I was not really happy with the hard exclusive-or switch and
your remarks made me thinking about the simultaneous access with new and
legacy apps again. I think cutting the canfd_frames down to can_frames when
the content is generally usable for the legacy app makes the migration pretty
handy :-)

Will send a v4 patch for the ongoing discussion.

Regards,
Oliver
