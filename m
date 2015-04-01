From: Paarvai Naai <opensource3141@gmail.com>
Subject: Re: Fwd: Querying current tx_queue usage of a SocketCAN interface
Date: Wed, 1 Apr 2015 13:33:14 -0700
Message-ID: <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com>
	<CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com>
	<55187FF1.7020701@optusnet.com.au>
	<CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com>
	<5519E5A9.7080104@optusnet.com.au>
	<CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com>
	<551A0FF3.4070400@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34811 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbDAUdO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Apr 2015 16:33:14 -0400
Received: by obbgh1 with SMTP id gh1so92467324obb.1
        for <linux-can@vger.kernel.org>; Wed, 01 Apr 2015 13:33:14 -0700 (PDT)
In-Reply-To: <551A0FF3.4070400@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au
Cc: linux-can@vger.kernel.org

Hi Tom,

I'm not sure if you quite followed my concern with multiple clients to
the SocketCAN interface.  All of the clients of a particular SocketCAN
interface (i.e., "can0") are piggybacking on the same electrical node
of the CAN bus -- this is their shared pipe to get their frames out on
the bus.  Let me try to do a better job of explaining:

1) Lets call presuppose a node in our network, node "A", that runs
Linux and has uses SocketCAN.
2) Client #1 of node A's SocketCAN-based interface submits a frame to
its socket with ID=0x7ff.
3) Other non-Linux-based nodes on the bus, say nodes "B", "C", and "D"
are spewing higher priority messages out on the bus.
4) As such, node A is unable to send frame with ID=0x7ff for while.
5) Now, some small amount of time later, Client #2 of the
SocektCAN-based interface to node "A" submits a frame to its socket
with ID=0x000.  Client #2 might be another thread or process running
on the Linux OS of node A.
6) On the next arbitration loss of ID=0x7ff, node A should ideally
reprioritize its TX queue such that ID=0x000 has a chance to get out.

I have a suspicion that SocketCAN implementations are not careful
about doing this, even though particular controllers may support this
type of re-prioritization of frames (with their own internal TX
queues).

Does this make sense?  Do you have any thoughts?

Thanks,
Paarvai


On Mon, Mar 30, 2015 at 8:09 PM, Tom Evans <tom_usenet@optusnet.com.au> wrote:
> On 31/03/15 11:26, Paarvai Naai wrote:
>>
>> Hi Tom,
>
>> ...
>>
>> If there are multiple clients, there is idneed the priority inversion
>> problem you mention.  Even if one has a single process designated to
>> read/write to the interface, managing priority is not fool proof.  A
>> low priority message could get submitted to the underlying SocketCAN
>> interface and be unable to go out onto the bus because of other
>> third-party nodes on the bus sending higher priority traffic at high
>> frequency.  This would block further messages from going out on the
>> SocketCAN interfaces, even though they have higher priority, no?
>
>
> Of course. That's the working definition of "PRIORITY".
>
> If that happens the system is behaving exactly as it has been designed to
> do, both by the hardware and software vendors, and by YOU, the default
> "System Architect".
>
> It that isn't doing what you want it to do, reassign the IDs so the "Higher
> Priority" or time sensitive messages have a higher priority, and the "high
> frequency" traffic has a sensibly lower priority.
>
> CAN was never meant to be used in an "Open System" where different and
> unrelated devices can be plugged onto a common bus. It is meant to be used n
> a single car where the whole system has been designed, specified (including
> assignment of all IDs with appropriate priorities), and rigorously tested to
> ensure the situation you're describing can't happen.
>
> Tom
>
