From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Iso-tp status
Date: Sun, 5 Mar 2017 20:55:30 +0100
Message-ID: <c3d436af-f305-89fb-a177-73e4bee8ee31@hartkopp.net>
References: <CAEQ58siD2MfV0=VFoGC4B67KcbJLtTFQJzAUFN19XF=AnVhhCQ@mail.gmail.com>
 <CAEQ58shwC09Q+TTAhG=dH7VjZ9RSQ5xsW8Z9tBhhbyN+3JKvAQ@mail.gmail.com>
 <CAEQ58sj93WMMgyQVdBqUkaaH8fcwOwNZvwbwsdJ0zOR0dgjpKA@mail.gmail.com>
 <CAEQ58sgZh==ZTB6HSzOWJzXv56pQZ+VEKPsWThYFHCUtzUHTdA@mail.gmail.com>
 <CAEQ58sgmm5=UzxU_DcGj-qy+B+qpb1d9ko-GPxx75+D=8Mq4VA@mail.gmail.com>
 <CAEQ58sjBCytryhrCQ1DYRcYpg=3-6DGvDtDzJVHV2mBcDa5NiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:18810 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752329AbdCETzy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Mar 2017 14:55:54 -0500
In-Reply-To: <CAEQ58sjBCytryhrCQ1DYRcYpg=3-6DGvDtDzJVHV2mBcDa5NiA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Francesco Giancane <francescogiancane8@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Francesco,

On 03/03/2017 09:49 AM, Francesco Giancane wrote:
> I currently work in the automotive field and in particular in the
> diagnostics field. I am a Linux and oss enthusiasts and got by chance
> interest in can protocols.

Fine :-)

> I see that till now the Isotp L4 is still not
> supported mainline. I want to contribute so my question is can you give
> me some reference to the current status of the project? Are you planning
> to carry it on ?

Yes. Of course!

I updated the ISO-TP to the latest ISO 15765-2:2016 version for CAN FD - 
as I was part of the ISO standardization process.

> I read the docs and I saw that there are some open points.

Due to the update of ISO 15765-2:2016 the PDU length increased from 12 
bits (0 - 4095 byte) to 32(!) bit -> 4GB(!). See:

https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/isotp.c#L102

That's why I was thinking about if/how to rearrange the code.
Probably the sendfile() syscall could be a way to go for PDU sizes > 
16kByte?!?

Some other open point is
https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/isotp.c#L178

By now no one expects error values - and many people are using the 
implementation :-)

So maybe we need to introduce a new isotp option flag to enable error 
reporting.

Finally this

https://github.com/hartkopp/can-isotp-modules/blob/master/README.isotp#L234

is not a really good 'hack'. I wonder if it makes sense to throttle the 
transmission of outgoing CAN frames based on the ability of the CAN 
interface to cope with the traffic.

Besides these nitpicks I'm done for mainline :-)

Best regards,
Oliver

ps. putting linux-can ML on CC to be able to catch other peoples opinion 
too.
