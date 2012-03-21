From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 15:49:25 +0100
Message-ID: <4F69EA75.1070202@hartkopp.net>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:16293 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030197Ab2CUOt3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 10:49:29 -0400
In-Reply-To: <20120321135339.GB6428@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org

On 21.03.2012 14:53, Kurt Van Dijck wrote:

> On Wed, Mar 21, 2012 at 02:21:22PM +0100, Oliver Hartkopp wrote:

>> 2. Is a CAN FD frame with DLC=8 different to a CAN2.0 frame with DLC=8 ?
>>    (as we know CAN ID 0x123 (EFF) and CAN ID 0x123 (SFF) are different)
> a CANFD frame with DLC=8 is different to a CAN2.0 frame with DLC=8 on the wire,
> but they are logically equal. Since we're into software, IMO we must treat them
> equal.


Yes - that would fit the idea to have internally only canfd_frames ...

> I think of some differences:
> * no RTR allowed.

Yes, that's important when sending CAN FD frames to be checked.

> * ESI bit.


Is something that IMO needs to go into the error message when set active.

>>
>> What i got from the iCC was that when you have a partly migrated network and
>> you want to run e.g. a fast firmware upload between two CAN FD capable nodes,
>> the other (standard CAN 2.0b) nodes have to be in listen only mode to not jam
>> the bus with error frames.
>>
>> After the firmware upload all the CAN nodes switch back to CAN2.0b mode (which
>> has to be done by root netlink access).
> Since CANFD is not bus compatible, the chip must go down & up.


Really? We don't know so far.

> It really depends
> on the chips & drivers to combine CAN2.0 & CANFD.
> As Marc already suggested, CANFD could be a ctrlmode.


At least this capability has to be very fast to be checked, as we would need
to check it every time when we pass a CAN frame to the CAN netdevice - to give
a proper feedback in can_send() when the given frame does not fit into the
destination device ...

>>
>> IMO we need to introduce a new struct canfd_frame
> IMO we need not to introduce a new struct since they are logically equivalent.
> 
> I created an old can20b_frame just to compute the sizeof.
> I'd go for a combined can_frame that could hold both.


No. You only think of CAN_RAW. There might be a way to do it with CAN_RAW but
changing an exported visible userspace structure breaks the ABI.

Expect that we can never change struct can_frame as this is written into stone.

How do you want to adapt the struct can_frames in the ABI for CAN_BCM and the
netlink API for CAN_GW?

If we want to support CAN FD the only way is to introduce a struct canfd_frame
or whatever we would like to call it ...

>>
>> It should be no problem to move to canfd_frame inside the kernel but if we
>> come to the point that we get to the userspace ABI there should be no tricky
>> way to check lengths or flags or return values are are not needed to be
>> checked with the current ABI now.
>>
>> When there's a defined socket API that makes use of struct can_frame (like
>> can_raw, can_bcm, can_gw - but not isotp! \o/ ) we need to
>>
>> - duplicate the socket API - like CAN_RAWFD (ugly)
>> - switch the frame size (e.g. via sockopt)
>> - a third unknown idea ...
> When you look at my patch, you can see that only a recompile of candump with
> the bigger can_frame is all what is between me and a virtual CANFD bus.
> Candump does not really need to care about the CANFD mode.


Yes - if you recompile it. But assume some binaries being out there where you
don't know how they are implemented ... all our apps are just *examples* how
you can use the socket API. I've seen really bad SocketCAN application code i
was asked why it doesn't work as expected the last years, believe me %-)

> I think it can do both types of busses as in
> 
> $ candump any


Yes, when candump expects canfd_frames, everything can be put into that structure.


>>
>> E.g. when having a CAN FD aware candump/cansend application, it can try to
>> switch the socket to CAN FD. 
> Since CANFD is a different bus, selecting a bus (like 'can0') implicetely selects
> the CANFD mode.


Which probably could be changed at runtime with a netlink command. So far
there's no reason why the switch of CAN <-> CAN FD should not be possible at
runtime, when the interface is up and both bitrates (slow & high) have been
configured before.

> IMHO, from that point on, there's no difference for candump with
> a legacy CAN2.0 bus. So why make things complicated.


When the API is all CAN FD capable and using always canfd_frames, nothing is
complicated indeed. But this is a different ABI then the current one, where
everyone relies on a struct can_frame being 16 bytes long.

> 
>> on an older kernel that does not support CAN FD ...
>>
>> I think it's much more tricky to find a proper solution here.
> As I mentioned before, I just use CAN_RAW with this. Actually, I just
> ran a real CAN program that I wrote years ago. It still operates!


Yes - CAN_RAW is an example where your approach works. But unfortunately it
does not cover the entire problem ...

Regards,
Oliver
