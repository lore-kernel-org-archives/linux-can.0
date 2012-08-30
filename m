From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: using multiple buffer with mailbox
Date: Thu, 30 Aug 2012 18:22:54 +0200
Message-ID: <503F935E.2080000@hartkopp.net>
References: <OFB15B28F3.46CFFEF5-ONC1257A6A.004361AB-C1257A6A.0044524C@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:17548 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2H3QW5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Aug 2012 12:22:57 -0400
In-Reply-To: <OFB15B28F3.46CFFEF5-ONC1257A6A.004361AB-C1257A6A.0044524C@continental-corporation.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mahesh.Maharjan-EXT@continental-corporation.com
Cc: linux-can@vger.kernel.org

Hello Mahesh,

On 30.08.2012 14:26, Mahesh.Maharjan-EXT@continental-corporation.com wrote:

> As I working with imx,  I want to know ,  How do SocketCAN can be 
> implement with mailbox ( 64 message buffer) regarding flexcan flexibilti 
> and hardware filters.


The CAN netdev driver model is as easy and simple as ethernet devices.
To fulfill multi-user requirements the CAN driver disables any CAN controller
specific filters and mailboxes to enable all different users on the host to
filter their own requires messages, using the CAN filter infrastructure:

http://lxr.linux.no/#linux+v3.5.3/Documentation/networking/can.txt#L393

You can also check out the filter capabilities with the 'candump' tool, see
'candump -?'

> Or is there possible to implement  along message 
> buffer using priority based CAN message  using Socket CANin upperlayer , 
> with CAN_buffer register Interrupts.


Interrupts?, CAN_buffer?, upperlayer? ???

You can open a CAN_RAW socket and apply the filters if you only want specific
CAN-IDs in your receive data stream. You can also open more than one CAN_RAW
socket in your application and handle the different file descriptors with
different functions.

Another option is to use the CAN_BCM sockets, where you can filter for
specific CAN-IDs and also for

- content changes in the CAN payload (data[])
- timeouts for cyclic messages
- etc.

This is especially very elegant for (cyclic) automotive CAN messages and can
be used in cases where "CAN mailboxes in CAN controllers" are usually used
for. E.g. the cansniffer and the bcmserver tool uses the CAN_BCM.

Give it a try and keep in mind that you are able to handle more than one CAN
socket in your application too :-)

> Another question , which interest me is ,CAN_ ISO TP implementaion , which 
>  I check in linux-can, I could not find the sources & header files, but , 
> CAN-util is using  CAN_ISOTP- examples.  Do, still ISO-TP in  test mode Or 
> it is already beed implement.


The isotp implementation is fully implemented in the 'CAN modules' tree:

https://gitorious.org/linux-can/can-modules

There you can find the according includes (that are also in the can-utils tree
to build the isotp tools).

I added the missing README.isotp file a few minutes ago, see (and read!):

https://gitorious.org/linux-can/can-modules/blobs/master/README.isotp

The implementation (and especially the socket API) is pretty stable and it's
used every day for automated regression testing and prototyping. I just did
not find the time to push it to mainline - due to this issue:

https://gitorious.org/linux-can/can-modules/blobs/master/README.isotp#line212

But i'll do some time.

Regards,
Oliver
