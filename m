From: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
Subject: RE: BCM loopback - Information request
Date: Tue, 20 Sep 2016 10:19:02 +0000
Message-ID: <BECC71D675C45C4F912901A0BBE9A3A41493CDA1@srv-mail.DominioAlfa.local>
References: <BECC71D675C45C4F912901A0BBE9A3A41493CD7D@srv-mail.DominioAlfa.local>
 <1509366.LC0YPQ3zn0@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.efuture.it ([81.29.204.82]:37438 "EHLO relay.efuture.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbcITKTN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Sep 2016 06:19:13 -0400
In-Reply-To: <1509366.LC0YPQ3zn0@ws-stein>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Ciao Alexander,

thanks for your answer.

Unfortunately, CAN_RAW_LOOPBACK is not working. Option is indeed referring to socket and not device, while BCM messages are coming from a different socket.

Andrea

-----Original Message-----
From: Alexander Stein [mailto:alexander.stein@systec-electronic.com] 
Sent: martedì 20 settembre 2016 11:54
To: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
Cc: linux-can@vger.kernel.org
Subject: Re: BCM loopback - Information request

Hi Andrea,

On Tuesday 20 September 2016 09:42:53, Angeloni Andrea wrote:
> In my application there is a thread for each initialized CAN interface 
> that sends over TCP all the read data to a Windows Client. Data are 
> read using Socket RAW. Application is also capable to send cyclic 
> messages using Broadcast manager.
> 
> Here is my question: how can I configure my application so that 
> reading thread does not get messages sent by BCM on the same interface?

I think the socket option CAN_RAW_LOOPBACK is what you need. Please refer to
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/can.txt#n536
You will not receive CAN frames sent from interface (BCM and other CAN frames), thus only messages from other CAN nodes.

HTH
Alexander


