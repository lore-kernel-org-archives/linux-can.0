From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 2/3 V3.1] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Fri, 20 Jan 2012 15:53:30 +0100
Message-ID: <4F197FEA.10007@peak-system.com>
References: <Pine.LNX.4.44L0.1201191004540.1447-100000@iolanthe.rowland.org>
 <4F191D44.9080101@hartkopp.net> <4F195E08.5010504@volkswagen.de>
 <4F195F46.6080102@grandegger.com> <4F195FD7.9070808@grandegger.com>
 <4F196E1A.9020005@volkswagen.de> <4F19718A.7020801@grandegger.com>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:52125 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2ATOxl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jan 2012 09:53:41 -0500
In-Reply-To: <4F19718A.7020801@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>, stern@rowland.harvard.edu

Hi,

=46ound time to answer to all of you:

- first, thanks for your review and tests
- next, I did a new version of the driver which fixes Alan's issue abou=
t=20
the variables in the stack, and which is *very* much less verbose too.
- the driver itself sets now the can state according to some usb adapte=
r=20
events

When unplugging the can cable, candump displays now:

   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
         controller-problem{rx-error-passive,tx-error-passive}
   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
         controller-problem{rx-error-passive,tx-error-passive}
   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
         controller-problem{rx-error-passive,tx-error-passive}
   can4  20000004  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
         controller-problem{rx-error-passive,tx-error-passive}
=2E..

I'm looking now to do the short circuit to check for bus-off manual=20
restart. I also confirm that auto restart hangs the kernel.

Thanks and regards,

St=E9phane


Le 20/01/2012 14:52, Wolfgang Grandegger a =E9crit :
> On 01/20/2012 02:37 PM, Oliver Hartkopp wrote:
>> On 20.01.2012 13:36, Wolfgang Grandegger wrote:
>>> On 01/20/2012 01:34 PM, Wolfgang Grandegger wrote:
>>>> Hi Oliver,
>>>>
>>>> On 01/20/2012 01:28 PM, Oliver Hartkopp wrote:
>>>>
>>>>> @Wolfgang: I always get "RTNETLINK answers: Device or resource bu=
sy"
>>>>> when the device is up - even on the EMS PCMCIA card. Should the m=
anual
>>>>> restart generally be also possible even when the device is up??
>>>> The restart is only for bus-off recovery. It will *not* restart if=
 you
>>>> are not in bus-off.
>> Ah, ok. Reading the *open* source helps :-))
>>
>>>>> I think the automatic restart (with restart-ms) has no preconditi=
ons to
>>>>> the device up/down state.
>>>> But it only triggers in case of bus-off. It has nothing to do with=
 up/down.
>>> If you are at it, please also test the bus-off and bus-off recovery=
=2E..
>>> Thanks...
>> Yes. Good point.
>>
>> I set the PCAN-USB adapter (can2) to 100000 bit/s and let the two ot=
her
>> nodes at 500kbit/s.
>>
>> With low traffic at 500kbit and sending one frame from the PCAN-USB
>> (cansend can2 123#00) the bus-off is easy to reach on can2.
>>
>> But the effect is:
>>
>> I get every second(!) an error msg with
>>
>>    can2  20000044  [8] 00 30 00 00 00 00 00 00   ERRORFRAME
>>      controller-problem{rx-error-passive,tx-error-passive}
>>      bus-off
>>
>> But the state displayed in
>>
>> ip -details -statistics link show can2
>>
>> always says
>>
>> 15: can2:<NO-CARRIER,NOARP,UP,ECHO>  mtu 16 qdisc pfifo_fast state D=
OWN qlen 10
>>      link/can
>>      can state ERROR-ACTIVE restart-ms 0
>>
>> ... with increasing bus-off counter every second.
>>
>> After setting the two other nodes at 100kbit/s too and do some traff=
ic there, the
>> state of the PCAN-USB should get back to work - but is does not.
>>
>> The error msgs every second remain from can2.
> The CAN error state is *not* handled at all in the driver :(. Obvious=
ly
> I missed that. Stephane, could you please check error state changes t=
o
> error passive (no calble) and bus-off (short-circuit) and bus-off
> recovery. "ip -d -s link show can0" and "candump any,0:0,#FFFFFFFF -e=
"
> will give you useful information. Or even better, show use the output=
=2E
>
> Thanks,
>
> Wolfgang.
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
