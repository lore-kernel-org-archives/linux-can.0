From: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
Subject: RE: BCM loopback - Information request
Date: Tue, 20 Sep 2016 15:19:14 +0000
Message-ID: <BECC71D675C45C4F912901A0BBE9A3A41493CDCC@srv-mail.DominioAlfa.local>
References: <BECC71D675C45C4F912901A0BBE9A3A41493CD7D@srv-mail.DominioAlfa.local>
 <1509366.LC0YPQ3zn0@ws-stein>
 <BECC71D675C45C4F912901A0BBE9A3A41493CDA1@srv-mail.DominioAlfa.local>
 <0cbe9cab-e983-0439-e11d-bd59b8e2f32e@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay.efuture.it ([81.29.204.82]:40254 "EHLO relay.efuture.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753804AbcITPTW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 20 Sep 2016 11:19:22 -0400
In-Reply-To: <0cbe9cab-e983-0439-e11d-bd59b8e2f32e@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Ok clear.

With local host you mean same Linux system or same CAN interface? On the uPC I'm currently using there are two CAN interfaces, and it could happen that one sends data to be processed to the other.

Regards,
Andrea

-----Original Message-----
From: Oliver Hartkopp [mailto:socketcan@hartkopp.net] 
Sent: martedì 20 settembre 2016 17:07
To: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>; Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org
Subject: Re: BCM loopback - Information request

Hi Andrea,

the CAN_BCM sets the loopback by default:

http://lxr.linux.no/#linux+v4.7.4/net/can/bcm.c#L1229

So it is not configurable by now.

An possibility could be to implement socket options for the CAN_BCM so that a setsockopt() with a new CAN_BCM_LOOPBACK becomes available.

But this is not in mainline Linux now.

Alternatively you can check for the fames you received on a CAN_RAW socket whether these frames have been created on the local host:

http://lxr.linux.no/#linux+v4.7.4/Documentation/networking/can.txt#L632

Which means that you have to use recvmsg() to read from CAN_RAW.

'candump' does it here:
https://github.com/linux-can/can-utils/blob/master/candump.c#L793

Regards,
Oliver

On 09/20/2016 12:19 PM, Angeloni Andrea wrote:
> Ciao Alexander,
>
> thanks for your answer.
>
> Unfortunately, CAN_RAW_LOOPBACK is not working. Option is indeed referring to socket and not device, while BCM messages are coming from a different socket.
>
> Andrea
>
> -----Original Message-----
> From: Alexander Stein [mailto:alexander.stein@systec-electronic.com]
> Sent: martedì 20 settembre 2016 11:54
> To: Angeloni Andrea <andrea.angeloni@alfamationglobal.com>
> Cc: linux-can@vger.kernel.org
> Subject: Re: BCM loopback - Information request
>
> Hi Andrea,
>
> On Tuesday 20 September 2016 09:42:53, Angeloni Andrea wrote:
>> In my application there is a thread for each initialized CAN 
>> interface that sends over TCP all the read data to a Windows Client. 
>> Data are read using Socket RAW. Application is also capable to send 
>> cyclic messages using Broadcast manager.
>>
>> Here is my question: how can I configure my application so that 
>> reading thread does not get messages sent by BCM on the same interface?
>
> I think the socket option CAN_RAW_LOOPBACK is what you need. Please 
> refer to
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/D
> ocumentation/networking/can.txt#n536
> You will not receive CAN frames sent from interface (BCM and other CAN frames), thus only messages from other CAN nodes.
>
> HTH
> Alexander
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>


