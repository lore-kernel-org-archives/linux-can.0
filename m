From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About timestamping and can-utils
Date: Thu, 06 Mar 2014 12:03:48 +0100
Message-ID: <53185614.5040307@peak-system.com>
References: <53183F0E.7050309@peak-system.com> <53184641.1040506@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:59787 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaCFLD6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Mar 2014 06:03:58 -0500
In-Reply-To: <53184641.1040506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

(sending this message again, first was in HTML... Sorry for the noise)

Thanks for your quick answer.
Meanwhile, I finally found by myself how to get the "hardware"=20
timestamps the (peak_usb) driver is saving for each CAN frame it receiv=
es...
Comparing to your candump patch, there are several things a bit=20
different I want to discuss about:

Your patch enables to get the (so-called) "hardware raw timestamp" as=20
well as the "hardware system transformed timestamp", right ?

When I look into net/socket.c, both timestamps are copied by=20
"__sock_recv_timestamp()", according to:

- SOCK_TIMESTAMPING_RAW_HARDWARE flag ("shhwtstamps->hwtstamp" is copie=
d=20
into the skb ctrlmsg)
- SOCK_TIMESTAMPING_SYS_HARDWARE flag ("shhwtstamps->syststamp" is=20
copied into the skb ctrlmsg)

If I understand well:

"hwtstamp" is the RAW timestamp received from the CAN device, without=20
ANY transformation, while "syststamp" is a "system transformed hardware=
=20
timestamp", which I understand as a timestamp the CAN device driver has=
=20
computed (according to the "raw timestamp" for example), to be=20
consistent with the system/kernel time.

So, a well-mannered linux-can device driver should (in case it is able=20
to get hardware timestamps from its device):

- store in "hwstamp" the raw value received from the device
- store in "syststamp" the "transformed" value the driver computes

Is it right?

Regards,

St=E9phane



Le 06/03/2014 10:56, Oliver Hartkopp a =E9crit :
> Hi Stephane,
>
> here's a discussion thread from last year focussing HW timestamping:
>
> http://marc.info/?l=3Dlinux-can&m=3D138210737431112&w=3D2
>
> Additionally I attached two patches:
>
> cants-test.patch:
> added some functionality to add a monotonic (sw) timestamp to sja1000
>
> candump-hwts.patch:
> added some functionality to candump to get these timestamps
>
> The candump patch is from the time before the include file cleanup in=
side the
> can-utils provided by Uwe. (including from socketcan directory)
>
> Together with the discussion thread from above, this should give a go=
od
> starting point.
>
> Regards,
> Oliver
>
>
> On 06.03.2014 10:25, Stephane Grosjean wrote:
>> Hi linux-can team,
>>
>> I've got one question about how timestamping is done now in linux-ca=
n,
>> regarding to HW timestamps.
>>
>> In the early ages (~v3.4), the CAN hardware driver could set the tim=
estamp of
>> an skb by itself and push it with the received CAN frame, so that th=
e
>> application could get it using SO_TIMESTAMP socket option, right?
>> Now, this "hardware" timestamp is to be copied into "hwstamp" field =
of the
>> "skb_hwtstamps(skb)" area.
>>
>> But how does user application manage to get this hardware timestamp =
on its
>> side? AFAIK, the "candump" can-utils utility always reads and displa=
ys the
>> "network" timestamp (that is, always uses SO_TIMESTAMP socket option=
). I had a
>> quick look to the Kernel sources and tried to find the links between=
 things
>> but it's not very clear to me: first idea I tested was to set the
>> SO_TIMESTAMPING socket option, but candump never received any hw tim=
estamp in
>> the control messages he reads from the CAN socket...
>>
>> Any help would be appreciated.
>>
>> Regards,
>>
>> St=E9phane
>> --=20
>> PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt
>> Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstad=
t HRB-9183
>> Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391 Tel.+49
>> (0)6151-817320 / Fax:+49 (0)6151-817329,info@peak-system.com
>> --=20

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
