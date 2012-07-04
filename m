From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Wed, 4 Jul 2012 09:34:24 -0700
Message-ID: <20120704163424.GB4422@ovro.caltech.edu>
References: <20120703232328.GD6616@ovro.caltech.edu>
 <4FF40A6E.1040709@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:42273 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2GDQe1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 12:34:27 -0400
Content-Disposition: inline
In-Reply-To: <4FF40A6E.1040709@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On Wed, Jul 04, 2012 at 11:18:38AM +0200, Wolfgang Grandegger wrote:
> Hi Ira,
> 
> On 07/04/2012 01:23 AM, Ira W. Snyder wrote:
> > Hello everyone,
> > 
> > I'm finally implementing SocketCAN support in our internal codebase, and
> > have run across some issues. We previously used a character driver provided
> > by the vendor.
> > 
> > I myself implemented the driver for the Janz ICAN3 card. It has been in
> > mainline Linux since 2.6.35.
> > 
> > The hardware is an SJA1000 chip plus a microcontroller and some RAM. All
> > messages go through the microcontroller firmware.
> > 
> > This firmware has the following features:
> > - it does have hardware-supported local loopback
> > - it does NOT have any sort of "tx-complete" notification or interrupt
> > - it does NOT have any indication that a frame went through the
> >   hardware-supported local loopback
> > 
> > To work around the lack of "tx-complete" interrupts, I used the hardware
> > local loopback feature. Every frame has hardware loopback set, which causes
> > the ican3_napi() routine to be called for each frame sent. This works fine,
> > except that sockets created with the default options (loopback on,
> > can_raw_recv_own_msgs off) do receive their own messages. This seems wrong.
> > 

This was the important sentence. As the driver is currently written,
sockets with can_raw_recv_own_msgs off DO receive their own messages.

This is not what most people expect, as you point out.

My coworker complained about this behavior, which is how I found out.
The candump program doesn't show anything abnormal, which is how I
missed the bug. The tst-rcv-own-msgs is the only test which shows the
bug.

We should really make sure that new drivers have run the test before
they are pushed upstream. I didn't know that the test existed until I
dug through mailing list archives looking for guidance on
can_raw_recv_own_msgs.

> > QUESTION 1:
> > The functions can_(get|put)_echo_skb() are not used at all. Is this wrong?
> 
> Not necessarily. IIRC, the early versions of the Flexcan driver used the
> hardware loopback as well but switched to classical echo-skb handling
> because of the problem with recv-own-msgs.
> 
> > QUESTION 2:
> > The socketcan test tst-rcv-own-msgs says:
> > Starting PF_CAN frame flow test.
> > checking socket default settings ... failure!
> > 
> > If I understand the code correctly, this means that the sending socket
> > received an echo frame when it should not have received one.
> > 
> > This matches what I expect the code to do.
> > 
> > How can I fix this?
> > 
> > OBSERVATION 1:
> > The following patch drops the relevant calls to netif_stop_queue() and
> > netif_wake_queue(), as well as the hardware-supported local loopback.
> > 
> > The tst-rcv-own-msgs test passes.
> > 
> > Is dropping these API calls a reasonable thing to do?
> 
> Well, that controller will not allow to support all features and options
> and we need to make a choice:
> 
>  recv-own-msgs support versus proper tx-done handling (correct timing)
> 
> As the recv-own-msgs is not used frequently, it would not be really
> dramatic if the feature is not available. Just my 0.02 cent.
> 
> Wolfgang.

It looks like when a driver returns NETDEV_TX_BUSY, the socket layer
just re-queues the packet and tries again. I've done some full bus load
testing with cangen/candump, and I can't notice any bad effects.

What is the problem with returning NETDEV_TX_BUSY when the hardware
sucks?

I may have thought of a workaround, though it might hurt performance
more than just returning NETDEV_TX_BUSY.

When the TX buffer is full, call netif_stop_queue(). Also start a timer
to check whether there is some free TX buffer space. If there is no free
TX buffer space, reschedule the timer. If there is some free TX buffer
space, call netif_wake_queue() and don't reschedule.

I'll code it up and try it out.

The other idea of using a can_peek_echo_skb() is an idea worth trying as
well.

Thanks for the input,
Ira
