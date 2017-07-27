From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: reading from socket can
Date: Thu, 27 Jul 2017 20:32:37 +0200
Message-ID: <492e6c1e-efad-155d-4557-bf8ce1a1cec0@hartkopp.net>
References: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:31364 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0Scs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Jul 2017 14:32:48 -0400
In-Reply-To: <alpine.LNX.2.21.1707271530280.9093@mpslxdressel.desy.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Dressel <michael.dressel@desy.de>, linux-can@vger.kernel.org

Hi Michael,

On 07/27/2017 03:40 PM, Michael Dressel wrote:

> is it guaranteed that a read on a SOCK_RAW  socket will always
> return complete can_frames, if it returns data at all?

Yes.

I double checked the code in net/can/raw.c which uses 
sock_queue_rcv_skb() in net/core/sock.c which completely fails when it's 
not possible to to place the skb content (the CAN frame) in the socket 
receive buffer.

In this case the dropcount counter is increased which can be monitored 
by recvmsg() (see dropcount example in candump.c)

> The documentation of "read" explicitly states, that it is not an error to
> return with any number of bytes less than the "requested" number of
> bytes.

Yes that's right for read() in general.

At least it makes sense to check whether the return value is 
sizeof(struct can_frame) or sizeof(struct canfd_frame) or if some error 
occured.

> I found calls to read in some applications taking it for granted
> that read always returns full can_frames.

You also might get negative values for error codes, e.g. when the (USB) 
CAN interface disappeared! So assuming to *always* get a CAN frame and 
not checking for errors is bad.

> And, having some very
> rare issues not understood yet, I wonder if an error in reading
> from the socket may cause this issues.

Don't know. Can you post some code?

> Actually I found a similar bug in a library for ModBus communication,
> and there it was possible to verify that the issues came from using read
> in a wrong way.

Dito.

Best,
Oliver

