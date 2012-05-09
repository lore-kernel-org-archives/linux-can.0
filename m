From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Wed, 09 May 2012 16:35:09 +0200
Message-ID: <4FAA809D.8070502@hartkopp.net>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com> <4FA9394A.90303@pengutronix.de> <20120508173001.31ce8f0c@eb-e6520> <4FA93FC1.7030808@pengutronix.de> <20120508191459.703c4369@eb-e6520> <4FA95A17.8090406@hartkopp.net> <4FA96750.6020206@pengutronix.de> <20120509081650.GA426@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:35539 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759661Ab2EIOfO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 May 2012 10:35:14 -0400
In-Reply-To: <20120509081650.GA426@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>

On 09.05.2012 10:16, Kurt Van Dijck wrote:

> On Tue, May 08, 2012 at 08:34:56PM +0200, Marc Kleine-Budde wrote:
>> On 05/08/2012 07:38 PM, Oliver Hartkopp wrote:
>>> On 08.05.2012 19:14, Eric B=C3=A9nard wrote:
>>>
>>>> Le Tue, 08 May 2012 17:46:09 +0200,
>>>> Marc Kleine-Budde <mkl@pengutronix.de> a =C3=A9crit :
>>>>
>>>>> On 05/08/2012 05:30 PM, Eric B=C3=A9nard wrote:
>>>>>> Hi Marc,
>>>>>>
>>>>>> Le Tue, 08 May 2012 17:18:34 +0200,
>>>>>> Marc Kleine-Budde <mkl@pengutronix.de> a =C3=A9crit :
>>>>>>
>>>>>>> On 05/08/2012 05:12 PM, Eric B=C3=A9nard wrote:
>>>>>>>> tested on an i.MX257
>>>>>>>
>>>>>>> What about the transceiver? Does is make sense to switch it off=
, too?
>>>>>>>
>>>>>> this could make sense on platform which have a transceiver with =
an
>>>>>> enable input. I can add flexcan_transceiver_switch after/before
>>>>>> flexcan_chip_disable/enable but won't be able to test that featu=
re.
>>>>>
>>>>> I looked at two ethernet drivers: ethernet/intel/ixgbe/ixgbe_main=
=2Ec and
>>>>> ethernet/intel/ixgbe/ixgbe_main.c and AFAICS they basically do th=
e same
>>>>> as in open/close. (btw: the flexcan driver switches the transceiv=
er
>>>>> on/off on open/close.) I haven't implemented any network driver p=
m yet,
>>>>> but what is a driver supposed to do in suspend/resume?
>>>>>
>>>> concerning the transceiver : that depends if you need to resume wh=
en
>>>> receiving a message on the CAN bus in which case you can't disable=
 the
>>>> transceiver (btw, I have an other patch which enable wakeup when
>>>> receiving a message on the CAN bus, but I need to clean and test i=
t
>>>> again).
>>>
>>>
>>> I wonder if you mix up the enabling/disabling of the CAN transceive=
r (trx)
>>> with the entire system power management.
>>>
>>> E.g. if you take the TJA1054A as an example, you can switch the trx=
 into a
>>> mode that switches off the power supply (INH-line) in order to wake=
 up with a
>>> received CAN frame, which switches on the power supply and boots th=
e system.
>>>
>>> Even if you don't switch the power supply with the INH pin the trx =
wakes up
>>> with CAN traffic in this mode.
>>>
>>> To me switching the trx modes only makes sense to implement system =
power
>>> management states. IMO there's no need to switch them when setting =
the
>>> interface to up/down state. Or did i miss anything?
> * the transceiver consumes power when on, while the netif if off.
>   That just feels a bit stupid.
> * From outside, the wires looks 'active', while there's just noone li=
stening.
>=20
> For these 2 arguments, I would think a regular system switches them o=
ff too.looks
>=20
>>
>> In the current implementation you can register a callback via
>> platform_data to enable/disable the transceiver. It's up to the boar=
d to
>> do something useful with it.
> Like in: The driver must call the callback, and the board can act upo=
n this.
>>
>> I think for now I'll take Eric's patch as it is, until we've impleme=
nted
>> something more complicated to support automotive style transceivers =
:)
>=20
> To implement something more complicated:
> http://www.mail-archive.com/socketcan-core@lists.berlios.de/msg00269.=
html
>=20


Wow - indeed i was not remembering your effort for these CAN transceive=
r class
support.

It looks interesting. Btw. i would name all the transceiver stuff with =
'trx'
instead of 'tr' (see http://www.acronymfinder.com/TRX.html) and i think=
 there
are some more modes than

+
+/*
+ * CAN transceiver modes
+ */
+#define CANTR_MODE_OFF 0
+#define CANTR_MODE_ON  1
+

especially for automotive power switching.

Additionally a netlink config interface is preferred these days too.

Btw. do you plan to pick the trx support up sometime?

Regards,
Oliver
