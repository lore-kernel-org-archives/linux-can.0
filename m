From: =?ISO-8859-1?Q?Michael_J=E4ntsch?= <michael.jaentsch@in.tum.de>
Subject: Re: [Socketcan-users] Message stalls in SocketCan Layer?
Date: Mon, 13 Feb 2012 11:00:22 +0100
Message-ID: <4F38DF36.9060007@in.tum.de>
References: <4F29091F.4010908@in.tum.de> <4F2AA5DF.9080304@grandegger.com> <4F2C0675.1050808@in.tum.de> <4F2C11DF.7010707@hartkopp.net> <4F2C3884.2000808@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out1.informatik.tu-muenchen.de ([131.159.0.8]:51715 "EHLO
	mail-out1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753306Ab2BMKAZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Feb 2012 05:00:25 -0500
In-Reply-To: <4F2C3884.2000808@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi,

sorry for the late reply. I wanted to test the older kernel and
therefore needed to setup the OS from scratch which I didn't have time
to do right away. Now, I tested it with Ubuntu 11.04 and kernel 2.6.38-=
13.
The problem appears a lot less often. From the time frame of a few
minutes we went to something more like half an hour. So maybe this has
been there all along but did not appear frequently enough to be noticed=
=2E
=46or the reasons I already mentioned I'm still pretty sure this has
nothing to do with our code.
Does anybody have an idea how to go about debugging this?

On 03.02.2012 20:41, Wolfgang Grandegger wrote:
> On 02/03/2012 05:57 PM, Oliver Hartkopp wrote:
>> please consider that if it works on other machines with the same ker=
nel that
>> there could be some changes within the USB subsystem or some interru=
pt or
>> ACPI/powersaving issues too.
>>
>> Going back to an older Kernel is a good check - don't know, if you a=
lso can go
>> further (3.1, 3.2) with Ubuntu 11.10 too ?!?
>>
>> Maybe there's some USB debugging available to check whether the URB =
has been
>> sent properly to the USB wire and if the interrupt of the USB contro=
ller
>> reached the system after sending.
> IIUC, he said that the time stamps indicated that the USB transfers h=
ave
> happened in time. The delays occured later. That's wired, indeed.
Wolfgang is right, the debug output of the driver indicated that the US=
B
transfers happened in time which is why I the guys from PEAK send me to
you. This looks to me like the messages get stalled somewhere in the
PF_CAN netlayer, but I'm also not a hundred percent sure how to verify
this, as this of course not that reproducable. Any ideas?

thanks
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


