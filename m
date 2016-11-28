From: Maaike Zijderveld <Maaike.Zijderveld@moba.nl>
Subject: Write to can chip, to send with remote request (not earlier)
Date: Mon, 28 Nov 2016 09:53:29 +0000
Message-ID: <3b3e6879fc5a490d9124872e13f0e94b@NLBS117EDAG1.moba-bv.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.moba.nl ([87.251.45.222]:15978 "EHLO mail.moba.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbcK1KDC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 28 Nov 2016 05:03:02 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I am trying to rewrite old DOS software to Linux for a machine. We use CAN to communicate with the 'master pc'. I have a PC104 board with Intel i82527 ISA CAN Card. We use remote request in the following way: we write a message to the CAN chip (don't broadcast it yet), so when the CAN card receives a remote request, the message will be sent. So the write to the chip isn't followed by a send command. 

The i82527 is not very well supported anymore and the Socketcan driver for this card (CC770_isa) doesn't support remote request. So we have several options, one of the options is another CAN card. It looks like for example Peak has some different CAN cards, I expect all with the same chip. Is it possible to do what I just described with the Peak CAN cards and SocketCAN? Or is there possibly another solution?

It has to work this way, because there is not much space left on the Can bus anymore. So the frames only have to be send on a remote request. 

Thanks in advance,

Maaike Zijderveld
Moba B.V., P.O. Box 7, 3770 AA Barneveld Stationsweg 117, The Netherlands, Trade register 09042296.  


This message is meant for the addressee only and may contain confidential and legally privileged information. Any unauthorised review, use, copying, storage, disclosure or distribution of this E-mail and any attachments is strictly prohibited. If you are not the named recipient or have otherwise received this communication in error, please destroy this message from your system and kindly notify the sender by E-mail. Thank you for your co-operation.
It's time for a new standard. <http://www.moba.net/page/en/Omnia-PX>

