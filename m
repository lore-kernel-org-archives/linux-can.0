From: Maxime Vinci <maxime.vinci@gmail.com>
Subject: Re: BCM cyclic transmission tasks : cpu load
Date: Fri, 17 Apr 2015 13:04:36 +0200
Message-ID: <CAA_20DDxA_uB8au=7K4mj8y0tJxudQd_hbNxuFx_iLFL3Tn7Vg@mail.gmail.com>
References: <CAA_20DA1UmnyrMSOy8vS1HRyhMm7xbjta1BZdK9Gfe1x2MAXBA@mail.gmail.com>
 <552FF89F.6030603@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34314 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbDQLFR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Apr 2015 07:05:17 -0400
Received: by iedfl3 with SMTP id fl3so78378633ied.1
        for <linux-can@vger.kernel.org>; Fri, 17 Apr 2015 04:05:16 -0700 (PDT)
In-Reply-To: <552FF89F.6030603@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>

Hi Oliver,

2015-04-16 19:59 GMT+02:00 Oliver Hartkopp <socketcan@hartkopp.net>:
> Hi Maxime,
>
> On 16.04.2015 19:28, Maxime Vinci wrote:
>>
>> This is my first message on a mailing list like this one, please be gentle
>> ;)
>
>
> Welcome. But beware - we are monsters :-)


Thank you, I will be careful ! ;)


>> Currently, I am using the SocketCAN BCM feature to setup cyclic frame
>> transmissions.
>>
>> Setting up everything appears to work fine : I can create multiple
>> tasks with different periods, with one or more frames in each one.
>>
>> I would like to use it inside a Qt application (with qml based user
>> interface), but it seems that right when I set up the first cyclic
>> task, the cpu load increase from ~5% to 100%.
>>
>> Even when all tasks are deleted (by using the opcode TX_DELETE), the
>> cpu load stays at the same level.
>>
>> To see if the UI was messing it up, I wrote a simple test program
>> where I call the BCM functions to set up some cyclic tasks before
>> entering a Qt application event loop (a simple "Hello world" app).
>>
>> It showed me that the cpu load goes crazy when the event loop starts.
>>
>> Correct me if I am wrong, but according to these 2 behaviors, it could
>> be assumed that the issue happens every time the BCM and a Qt-based UI
>> are being used together.
>>
>> Does anyone have any hints about this particular issue ?
>
>
> I know about a colleague who's using Qt together with SocketCAN - but I'm
> not sure if he uses CAN_BCM sockets or only CAN_RAW. But AFAIK he
> implemented the communication stuff (including CAN access) into a separate
> thread.
>
> So one suggestion would be to use strace (-> man strace) to check what's
> going on at syscall level. E.g. when your event loop does some
> blocking/polling stuff you can likely see it.
>
> Regards,
> Oliver
>
>> PS: I did not try to put the object that wraps the BCM features in a
>> new thread, but I think this will not solve the problem. (this is kind
>> of done inside SocketCan, right ?)
>
>
> Maybe you give it a try ;-)


I did as you suggested, it appears that the cpu load is due to this
repeated sequence of syscalls :


clock_gettime(CLOCK_MONOTONIC, {6853, 227416546}) = 0
poll([{fd=5, events=POLLIN}, {fd=6, events=POLLIN}, {fd=12,
events=POLLIN}, {fd=13, events=POLLIN}, {fd=19, events=POLLIN}], 5,
-1) = 1 ([{fd=5, revents=POLLIN}])
read(5, "\1\0\0\0\0\0\0\0", 16)         = 8
write(5, "\1\0\0\0\0\0\0\0", 8)         = 8
recvmsg(6, 0xbfc4fa64, 0)               = -1 EAGAIN (Resource
temporarily unavailable)


I did not know about strace, it is a very useful tool indeed !


I think I have found the cause of this issue, by running some
additionnal tests (threading my object or starting 2 sperate programs
- one with only a clean Qt example - the other with only BCM tasks)
and looking at the output given by strace.

My first test program was apprently not as basic as I thought, in
addition to the CAN_BCM, my object was creating a CAN_RAW socket and
was listening for incoming frames by using a QSocketNotifier.

As I use a virtual CAN, which loopback sent frames, the
QSocketNotifier was calling the function associated with the
notification (triggering a read operation on the CAN_RAW socket).

Therefore, there should be a conflict between the 2 sockets trying to
access the same interface ?

This is happening at the syscall (can I say kernel ?) level, as I
managed to reproduce the issue by using CAN_RAW (reading) in one
program and CAN_BCM (writing) in another.

I may lack of knowledge about configuring/manipulating sockets, but is
the solution to use (IPC) semaphores on read/write operations ?


Again thank you, you already helped me a lot !

Regards,

Maxime
