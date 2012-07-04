From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Wed, 04 Jul 2012 11:18:38 +0200
Message-ID: <4FF40A6E.1040709@grandegger.com>
References: <20120703232328.GD6616@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35265 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756377Ab2GDJSo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 05:18:44 -0400
In-Reply-To: <20120703232328.GD6616@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: linux-can@vger.kernel.org

Hi Ira,

On 07/04/2012 01:23 AM, Ira W. Snyder wrote:
> Hello everyone,
> 
> I'm finally implementing SocketCAN support in our internal codebase, and
> have run across some issues. We previously used a character driver provided
> by the vendor.
> 
> I myself implemented the driver for the Janz ICAN3 card. It has been in
> mainline Linux since 2.6.35.
> 
> The hardware is an SJA1000 chip plus a microcontroller and some RAM. All
> messages go through the microcontroller firmware.
> 
> This firmware has the following features:
> - it does have hardware-supported local loopback
> - it does NOT have any sort of "tx-complete" notification or interrupt
> - it does NOT have any indication that a frame went through the
>   hardware-supported local loopback
> 
> To work around the lack of "tx-complete" interrupts, I used the hardware
> local loopback feature. Every frame has hardware loopback set, which causes
> the ican3_napi() routine to be called for each frame sent. This works fine,
> except that sockets created with the default options (loopback on,
> can_raw_recv_own_msgs off) do receive their own messages. This seems wrong.
> 
> QUESTION 1:
> The functions can_(get|put)_echo_skb() are not used at all. Is this wrong?

Not necessarily. IIRC, the early versions of the Flexcan driver used the
hardware loopback as well but switched to classical echo-skb handling
because of the problem with recv-own-msgs.

> QUESTION 2:
> The socketcan test tst-rcv-own-msgs says:
> Starting PF_CAN frame flow test.
> checking socket default settings ... failure!
> 
> If I understand the code correctly, this means that the sending socket
> received an echo frame when it should not have received one.
> 
> This matches what I expect the code to do.
> 
> How can I fix this?
> 
> OBSERVATION 1:
> The following patch drops the relevant calls to netif_stop_queue() and
> netif_wake_queue(), as well as the hardware-supported local loopback.
> 
> The tst-rcv-own-msgs test passes.
> 
> Is dropping these API calls a reasonable thing to do?

Well, that controller will not allow to support all features and options
and we need to make a choice:

 recv-own-msgs support versus proper tx-done handling (correct timing)

As the recv-own-msgs is not used frequently, it would not be really
dramatic if the feature is not available. Just my 0.02 cent.

Wolfgang.
