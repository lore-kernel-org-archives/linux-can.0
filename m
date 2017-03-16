From: Francesco Giancane <francescogiancane8@gmail.com>
Subject: Re: Iso-tp status
Date: Thu, 16 Mar 2017 19:52:31 +0100
Message-ID: <CAEQ58shkPoAu+qDsCLLGyC2D7=6UytwuH5n-5maoQZi-etka6w@mail.gmail.com>
References: <CAEQ58siD2MfV0=VFoGC4B67KcbJLtTFQJzAUFN19XF=AnVhhCQ@mail.gmail.com>
 <CAEQ58shwC09Q+TTAhG=dH7VjZ9RSQ5xsW8Z9tBhhbyN+3JKvAQ@mail.gmail.com>
 <CAEQ58sj93WMMgyQVdBqUkaaH8fcwOwNZvwbwsdJ0zOR0dgjpKA@mail.gmail.com>
 <CAEQ58sgZh==ZTB6HSzOWJzXv56pQZ+VEKPsWThYFHCUtzUHTdA@mail.gmail.com>
 <CAEQ58sgmm5=UzxU_DcGj-qy+B+qpb1d9ko-GPxx75+D=8Mq4VA@mail.gmail.com>
 <CAEQ58sjBCytryhrCQ1DYRcYpg=3-6DGvDtDzJVHV2mBcDa5NiA@mail.gmail.com>
 <c3d436af-f305-89fb-a177-73e4bee8ee31@hartkopp.net> <CAEQ58sjaHg4-+E-RaFtwXdeZ71YCE_1LQDvGj6z2ssU_FERaXw@mail.gmail.com>
 <CAEQ58sjOO=o-0s2y_BQAobNhEMo9X+=VDGfJcb10PcWmRs3q7Q@mail.gmail.com> <c29c7f0e-1f5b-ebaa-73bb-fb11294ece17@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33469 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbdCPSwh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Mar 2017 14:52:37 -0400
Received: by mail-wr0-f176.google.com with SMTP id u48so38301164wrc.0
        for <linux-can@vger.kernel.org>; Thu, 16 Mar 2017 11:52:32 -0700 (PDT)
In-Reply-To: <c29c7f0e-1f5b-ebaa-73bb-fb11294ece17@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, mauro.cerrato@cnhind.com

Hi Oliver,
sorry for being late; thanks again for your feedback. Totally agree
for the first point, maybe let us just stay focused on being mainline
first - then we may think on how to send up to 4Gigs of data ;)

Being the ISO-TP unreliable, i think that the only meaningful
information may be whether the FF->FC exchange happened or not at
all... Maybe nobody is answering on the other side, so it is worth
informing the application at layer 7.

I have some good reference documentation by my side, it is the next
schedule to be read; in time I will have more accurate answers in the
form of which standard E* enumeration for errors maps good with which
case.

As always, I am available for helping & contributing to this project.
Let me know whether you need help :)

Bye,
Francesco Giancane

Via Paolo Braccini 46, 10141 Torino (TO)
+393933920466
https://it.linkedin.com/in/francesco-giancane-aa7213117



2017-03-11 23:42 GMT+01:00 Oliver Hartkopp <socketcan@hartkopp.net>:
> Hi Francesco,
>
> On 03/10/2017 05:10 PM, Francesco Giancane wrote:
>
>> #1) What if we use conventional read/writes sys calls for supporting
>> "old" ISO-TP specification up to 2^12 bytes, and using sendfile() +
>> mmap() for source file descriptor greater than that? I think it would be
>> unfeasible to statically allocate MAX_MSG_LENGTH to 4GB directly inside
>> kernel space; maybe using zero copy would help us.
>
>
> Yes. Something like this would be my intention too.
> I would suggest to stay on the established read/write API e.g. up to 8192
> byte to be able to play with the new length format.
>
> But for 'longer' PDUs sendfile & mmap would be cool.
>
> What about pushing the current approach to mainline first and add the 'long
> PDU' API in a second step?
>
>> #2) Errors are good thing but as always developers prefer the Happy
>> Path. I will double check standard socket() errors and see if there are
>> already suitable matching codes.
>
>
> As referenced in
> https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/isotp.c#L178
> there is a possibility to detect some kind of timeout on protocol level.
>
> But in fact ISO15765-2 is an unreliable protocol anyway (like UDP) and you
> never know whether the PDU was properly received at the data sink.
>
> For that reason you need a timeout handling a layer above anyway - e.g.
> provided by an UDS application. So it's worth to discuss whether we really
> need to provide a TIMEOUT error by the socket API.
>
>> #3) I wonder if setting an appropriate STmin parameter would fix this
>> issue. (Mauro suggests STMin strictly greater than 0, to avoid CAN
>> network flooding). Maybe also opening the socket in ISOTP mode should
>> increase the txqueuelen.
>
>
> Yeah - at least this reduces the problems. Adding an appropriate minimum
> N_As value depending on the minimum CAN frame transmission time for CAN or
> CAN FD.
> https://github.com/hartkopp/can-isotp-modules/blob/master/net/can/isotp.c#L374
>
> But still this reasonable default value does not solve the general problem
> of potential tx queue overflows. I wonder wether/how other network protocols
> handle this - but I did not take a look on this so far %-)
>
> Thanks for your feedback & the discussion,
> Oliver
>
