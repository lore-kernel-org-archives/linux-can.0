From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Write to can chip, to send with remote request (not earlier)
Date: Mon, 28 Nov 2016 18:51:22 +0100
Message-ID: <6084dbdb-3817-f9d3-0309-86c46cd62366@hartkopp.net>
References: <3b3e6879fc5a490d9124872e13f0e94b@NLBS117EDAG1.moba-bv.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:13206 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbcK1Rvc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2016 12:51:32 -0500
In-Reply-To: <3b3e6879fc5a490d9124872e13f0e94b@NLBS117EDAG1.moba-bv.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Maaike Zijderveld <Maaike.Zijderveld@moba.nl>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Maaike,

On 11/28/2016 10:53 AM, Maaike Zijderveld wrote:
> I am trying to rewrite old DOS software to Linux for a machine. We use CAN to communicate with the 'master pc'. I have a PC104 board with Intel i82527 ISA CAN Card. We use remote request in the following way: we write a message to the CAN chip (don't broadcast it yet), so when the CAN card receives a remote request, the message will be sent. So the write to the chip isn't followed by a send command.
>
> The i82527 is not very well supported anymore and the Socketcan driver for this card (CC770_isa) doesn't support remote request. So we have several options, one of the options is another CAN card. It looks like for example Peak has some different CAN cards, I expect all with the same chip. Is it possible to do what I just described with the Peak CAN cards and SocketCAN? Or is there possibly another solution?
>
> It has to work this way, because there is not much space left on the Can bus anymore. So the frames only have to be send on a remote request.

using special CAN controller mechanisms to write CAN frames to the CAN 
controller that are not sent - but stored to some TX object to perform 
RTR answers - is not supported by now.

But there's a solution to perform RTR with every existing CAN controller 
(including c770) by using the RTR functionality of the CAN broadcast 
manager (BCM).

See example at:

https://github.com/linux-can/can-tests/blob/master/tst-bcm-rtr.c

Regards,
Oliver
