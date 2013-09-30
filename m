From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: adding can4linux to drivers/char
Date: Mon, 30 Sep 2013 10:21:55 +0200
Message-ID: <f5d9cc7300d20a95ccca9ae080c280ee@grandegger.com>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com>
 <2109885.0l6dWmo4a5@heinz.site> <52488278.4030603@grandegger.com>
 <CADGMhsWUYN8gYqaRFH802jHmDgC2kamdLzDCgOvhhB-MYG-0hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:45228 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754011Ab3I3IV5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 30 Sep 2013 04:21:57 -0400
In-Reply-To: <CADGMhsWUYN8gYqaRFH802jHmDgC2kamdLzDCgOvhhB-MYG-0hQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sebastian Haas <dev@sebastianhaas.info>
Cc: =?UTF-8?Q?Heinz-J=C3=BCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

On Mon, 30 Sep 2013 09:40:37 +0200, Sebastian Haas=0D
<dev@sebastianhaas.info> wrote:=0D
> 2013/9/29 Wolfgang Grandegger <wg@grandegger.com>:=0D
>> On 09/29/2013 06:28 PM, Heinz-J=C3=BCrgen Oertel wrote:=0D
>>>=0D
>>> Hello=0D
>>>=0D
>>> Am Samstag, 21. September 2013, 21:55:45 schrieb Wolfgang Grandegge=
r:=0D
>>>> I think you need *strong* arguments to get it accepted.=0D
>>>=0D
>>> I have some good arguments for this kind of driver=0D
>>> - it is much more simple in design than others,=0D
>>>   simplicity is one of the Linux design goals=0D
>>> - It has a simple user API=0D
>>> - It does not need any other infrastructure than the kernel API=0D
>>> - It is mature=0D
>>=0D
>> Well, the question is in what respect it's (much) better than the=0D
>> existing Linux-CAN. I can imagine some performance benefits on very =
low=0D
>> end systems, if at all.=0D
> Again think about memory (RAM/ROM) as well. We are talking here about=
=0D
small=0D
> ARM7TDMI stuff and other creepy and limited systems.=0D
=0D
Do you have figures? I remember that the a chardev based solution is no=
t=0D
really=0D
*much* better.=0D
=0D
>>> I agree, it would be nice to share the low level CAN controller=0D
related=0D
>>> experiences of the developers. That is may be something we can shar=
e=0D
if=0D
>>> we=0D
>>> could agree of a set of CAN controller header files with shared=0D
register=0D
>>> #defines. And a set of very basic functions like initialize and=0D
>>> activate CAN,=0D
>>> set acceptance filters, transmit and receive, read out error regist=
er=0D
or=0D
>>> whatever.=0D
>>=0D
>> Sounds ugly!=0D
> Sharing definitions and common functions sounds ugly to you? What doe=
s=0D
> the candev=0D
> and sja1000dev in Socket CAN does?=0D
=0D
OK, pure share is fine but I had ugly #ifdef's in mind.=0D
 =0D
>>> But to stay simple, I don't like the idea to have another additiona=
l=0D
>>> layer=0D
>>> around SocketCAN as layer below the can4linux API.=0D
>>>=0D
>>> Linux offers real diversity on the desktop, why not with drivers?=0D
Linux=0D
>>> also=0D
>>> has different sound devices and architectures.  Why not offering tw=
o=0D
>>> different=0D
>>> CAN driver concepts to the application programmer,=0D
>>> let she decide what to use.=0D
>>=0D
>>=0D
>> It's also about maintenance. It's real work to keep a driver in the=0D
>> kernel up-to-date, to review and accept new drivers, etc., not only =
for=0D
>> the initial submitter.=0D
> Right, and I think a chardev drivers has far less dependencies to=0D
maintain=0D
> then=0D
> the Socket CAN driver. No netdev changes to maintain, iputils stuff o=
r=0D
> changes=0D
> in the candev ;-)=0D
> =0D
> A reason more trying to share code with a chardev solution!=0D
> =0D
>> There are missing bits and pieces in Linux-CAN, e.g. hardware filter=
=0D
>> support, improved bus-off handling or even bitrate detection. That's=
=0D
>> also not a strong argument for can4linux. Just contribute them to=0D
>> Linux-CAN.=0D
> Well, some things can't be done cause of the underlying networking=0D
> subsystem=0D
> (namely the queuing) which is perfectly fine for real networking stuf=
f=0D
> (>=3D IP) but=0D
> not that well for CAN IMHO.=0D
=0D
I do not say that can4linux is bad but image we have another CAN interf=
ace=0D
in the kernel supporting a *different* set of devices... and we will en=
d=0D
up with such a solution sooner than later, for sure. This means that=0D
people=0D
will finally not have the real choice but are forced to use the interfa=
ce=0D
supporting their device. It breaks portability! I believe that's a *bad=
*=0D
solution for the community.=0D
=0D
Wolfgang.=0D

