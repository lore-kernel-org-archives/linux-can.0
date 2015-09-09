From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: socket can receive order
Date: Tue, 8 Sep 2015 19:30:59 -0700
Message-ID: <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de>
 <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de>
 <55EEC3C0.1010002@engineeredarts.co.uk> <55EF133E.8070105@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36147 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbbIICbU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 22:31:20 -0400
Received: by qgx61 with SMTP id 61so99705352qgx.3
        for <linux-can@vger.kernel.org>; Tue, 08 Sep 2015 19:31:19 -0700 (PDT)
In-Reply-To: <55EF133E.8070105@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Daniel Squires <dan@engineeredarts.co.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tue, Sep 8, 2015 at 9:56 AM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi all,
>
> On 08.09.2015 13:17, Daniel Squires wrote:
> > On 08/09/15 12:13, Marc Kleine-Budde wrote:
>
> >>> I can see the packets coming in the correct order in wireshark and it is
> >>> not immediately obvious to me how the kernel module could mix up the
> >>> order, so it seems that it must be something that happens at the socket
> >>> level?
> >> The kernel module "produces" the CAN frames, so if you see them in the
> >> correct order in wireshark, they have left the module in the right order.
>
> Yes. This is trivial.
>
> But Daniel is right to ask about the frame reordering on socket level - better
> say - reordering outside the driver level.
>
> >
> > Sorry , I should have been clearer here, in wireshark was looking at the USB
> > frames not the CAN frames. however I think what you say still stands due to
> > the time stamps being in the correct order.
> >>
> >>> candump can3 -tz
> >>> <snip>
> >>>    (003.088648)  can3  043   [8]  F7 2D 00 00 00 00 00 00
> >>>    (003.089149)  can3  045   [8]  F9 2D 00 00 00 00 00 00
> >>>    (003.088897)  can3  044   [8]  F8 2D 00 00 00 00 00 00
> >> The timestamps are in the correct order. Maybe Oliver can help here,
> >> he's an expert when it comes to strange reordering :)
>
> Will try - see below.
>
> >>
> >>> On the top level I am using CANFestival for CANOpen implementation, so
> >>> it has occurred to me I could implement a CANFestival "driver" using
> >>> libusb and completely bypass the kernel module and socket can layers,
> >>> but I hope not to have to do this.
> >> Na, you don't want to do this.
>
> The point this that it would not help either - even if you are using the
> PF_PACKET socket (which wireshark does) - bypassing the CAN network layer
> modules (can, can_raw) doesn't fix the problem.
>
> I discussed the problem on netdev ML as I discovered a out-of-order issue when
> fixing the CAN_RAW join feature.
>
> When you have a multicore SMP processor the interrupt can be processed by
> different CPUs, which can lead to packet reordering when using netif_ix() on
> driver level.
>
> The discussion ended with the networking guys pointing me to use NAPI which
> does not really help, e.g. there's only one USB network adapter in
> linux/drivers/net which is a complete mess.
>
> My suggestion was to set a hash value into the socket buffer (skb) at driver
> level, which is used for generating a 'flow' for IP traffic too. You can
> generate flows by hashes to put all traffic from a specific IP into the same
> per-cpu input queue to help TCP assembling the packets in the softirq for this
> IP address in correct order (aha!).
>
> See http://marc.info/?l=linux-netdev&m=143689694125450&w=2
>
> I assume the networking guys interpreted my suggestion as hack as they are not
> aware how 'addressing' is done in CAN. They only know about IP ...
>
> NAPI is not really a valid solution for CAN USB adapters and I think I'll have
> to restart the discussion as out-of-order frames are a no-go for CAN as it
> kills ISO15765-2 and (obviously) CANopen segmentation.
>
> I assume Daniel uses a multicore system, right?
>
> If so, please try the 'hack' I suggested on the netdev ML if it fixes your
> problem. It might help for the discussion too.
>
> Regards,
> Oliver

On our boxes, I've been setting the affinity for both the IRQ thread
(we are running a RT kernel), and the interrupt to the same single
core.  Would that help here?

We've seen CAN packets get significantly delayed causing overruns due
to Ethernet load and both CAN and ethernet sharing the same softirq.
Our solution has been to set the affinity for each of those to
different cores to keep them isolated.

Austin
