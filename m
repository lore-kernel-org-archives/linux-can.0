From: =?ISO-8859-1?Q?Michael_J=E4ntsch?= <michael.jaentsch@in.tum.de>
Subject: Re: [Socketcan-users] Message stalls in SocketCan Layer?
Date: Fri, 03 Feb 2012 17:08:21 +0100
Message-ID: <4F2C0675.1050808@in.tum.de>
References: <4F29091F.4010908@in.tum.de> <4F2AA5DF.9080304@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:40540 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753719Ab2BCQPu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 11:15:50 -0500
Received: from [131.159.61.41] (atknoll184.informatik.tu-muenchen.de [131.159.61.41])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.in.tum.de (Postfix) with ESMTP id 59AF06559
	for <linux-can@vger.kernel.org>; Fri,  3 Feb 2012 17:08:22 +0100 (CET)
In-Reply-To: <4F2AA5DF.9080304@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org

Hi,

thanks Wolfgang, I didn't know the socket-can mailinglist is deprecated=
=2E

On 02.02.2012 16:03, Wolfgang Grandegger wrote:
> On 02/01/2012 10:42 AM, Michael J=E4ntsch wrote:
>> Hi everyone,
>>
>> for about a month now, I have a problem with messages that get stall=
ed,
>> causing the select system call on several CAN sockets to time out. W=
e're
>> using the PEAK PCAN-USB interface on a Ubuntu 11.10 (kernel:
>> 3.0.0-15-generic). I've been using the system for about 2 years now =
and
>> there were no revelant changes to the protocol or software lately. T=
his
>> problem occurs quite frequently now.
> When did the reported problems start to show up? After switching to a
> new kernel?

yes, it all started when I switched to kernel 3.0.0-15-generic. However=
,
weirdly enough there is one computer with this kernel where the problem
doesn't appear and two where it does. I think I will confirm this by
going back to an older kernel and seeing if the problem disappears.
>> What happens is, that our master sends out a message and receives 13
>> reply messages from 13 different nodes on the bus, at a frequency of
>> 50Hz. This works for some time (minutes) and then a timeout on the
>> select system call occurs that reads from the 13 sockets. Wireshark
>> shows that there is an unusual time delay between the messages. They=
 get
>> sent at the same time and are normally received within the time of
>> 2-4ms. When the timeout occurs, this time is 30ms. When I turn on th=
e
>> debug information in the peak driver I see debug output with time
>> stamps. On this layer the times are still ok when the timeout occurs=
=2E
>> Talking to the peak support, I got pointed at the socket can layer w=
hich
>> in this case might be causing the problem. However, I have no idea h=
ow
>> to debug this and find out more about the problem.
> Hm, is there some other activity blocking the kernel? You could use
> ftrace to find out what's going on.

I don't know, it does look like something is blocking my kernel.
However, I didn't really want to go into kernel debugging/tracing.
If you can give me some hints, as to where I should start I could give
it a shot...

thanks a lot
Michael

--=20
Technische Universit=E4t M=FCnchen
Michael J=E4ntsch
=46akult=E4t f=FCr Informatik
Robotics and Embedded Systems
Parkring 13
85748 Garching bei M=FCnchen
Tel: + 49.89.289.17626
=46ax: + 49.89.289.17637
michael.jaentsch@in.tum.de
www6.in.tum.de


