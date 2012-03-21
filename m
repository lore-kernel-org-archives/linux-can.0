From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 15:56:25 +0100
Message-ID: <4F69EC19.7090205@grandegger.com>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47903 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab2CUO4f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 10:56:35 -0400
In-Reply-To: <20120321135339.GB6428@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

Hi,

On 03/21/2012 02:53 PM, Kurt Van Dijck wrote:
> On Wed, Mar 21, 2012 at 02:21:22PM +0100, Oliver Hartkopp wrote:
>> Hi all,
>>
>> of course i also thought about some concepts to support CAN FD ;-)
> :-)
>>
>> But then it melted down to the question what a potential CAN FD controller
>> would support:
>>
>> 1. Will it support sending of CAN frames & CAN FD frames with one config?
> At least, you'd select if it operates in CAN or CANFD mode, since the bus
> cannot switch dynamically.
> 
>> 2. Is a CAN FD frame with DLC=8 different to a CAN2.0 frame with DLC=8 ?
>>    (as we know CAN ID 0x123 (EFF) and CAN ID 0x123 (SFF) are different)
> a CANFD frame with DLC=8 is different to a CAN2.0 frame with DLC=8 on the wire,
> but they are logically equal. Since we're into software, IMO we must treat them
> equal.

As I see it, the main difference to standard CAN is the bit-rate
switching for transferring just the data bytes using alternate
bit-timing parameters.

> I think of some differences:
> * no RTR allowed.
> * ESI bit.

Also DLC=9 means 12 bytes, DLC=10 means 16 bytes, DLC=15 means 64 bytes.
This may even change in the final spec.

>> 3. Will these differences be visible in the CAN registers? Is this relevant?
> Without hardware, it's a bit early to predict. I guess it will be visible, but
> not relevant since that's driver stuff.

As CANFD controllers also supports CAN2.0 frames, they must provide the
the relevant information somehow, similar to EFF and SFF.

> I did not get into real drivers yet...
>>
>> What i got from the iCC was that when you have a partly migrated network and
>> you want to run e.g. a fast firmware upload between two CAN FD capable nodes,
>> the other (standard CAN 2.0b) nodes have to be in listen only mode to not jam
>> the bus with error frames.

Due to the bit-rate switching, a assume.

>> After the firmware upload all the CAN nodes switch back to CAN2.0b mode (which
>> has to be done by root netlink access).
> Since CANFD is not bus compatible, the chip must go down & up. It really depends
> on the chips & drivers to combine CAN2.0 & CANFD.
> As Marc already suggested, CANFD could be a ctrlmode.

I also see this problem.

>> IMO we need to introduce a new struct canfd_frame
> IMO we need not to introduce a new struct since they are logically equivalent.
> 
> I created an old can20b_frame just to compute the sizeof.
> I'd go for a combined can_frame that could hold both.

Well, I see it as an extension of the standard CAN and therefore I was
also thinking about an extra "struct canfd_frame". The size is more than
3 times larger and we may only allocate the extra space if it's really
required. I'm also thinking about the impact on queues, etc.

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
> I think it can do both types of busses as in
> 
> $ candump any

Well, candump is a simple application and it does not really care about
the payload. This is different for real legacy application, I think,
which assumes a payload of 8 bytes only.

>> E.g. when having a CAN FD aware candump/cansend application, it can try to
>> switch the socket to CAN FD. 
> Since CANFD is a different bus, selecting a bus (like 'can0') implicetely selects
> the CANFD mode. IMHO, from that point on, there's no difference for candump with
> a legacy CAN2.0 bus. So why make things complicated.

See above. Also, I think CANFD has been invented to support a fast
transfer mode for special purposes which will be selected from time to
time making the bus incompatible with legacy CAN controllers.

>> on an older kernel that does not support CAN FD ...
>>
>> I think it's much more tricky to find a proper solution here.
> As I mentioned before, I just use CAN_RAW with this. Actually, I just
> ran a real CAN program that I wrote years ago. It still operates!

Would you program still run if the payload is bigger than 8 bytes?
I agree with Oliver.

Wolfgang.
