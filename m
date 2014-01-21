From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Tue, 21 Jan 2014 10:56:15 +0100
Message-ID: <52DE443F.9080105@hartkopp.net>
References: <52D6CB48.9010206@hartkopp.net> <52D8DF40.7050405@peak-system.com> <52DABB28.4070608@hartkopp.net> <52DE32FD.5010300@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:44367 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbaAUJ4W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 04:56:22 -0500
In-Reply-To: <52DE32FD.5010300@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 21.01.2014 09:42, Stephane Grosjean wrote:
> Le 18/01/2014 18:34, Oliver Hartkopp a =C3=A9crit :

>> 1. Is it a good idea to provide CANFD8 frames to legacy applications=
?
>=20
> Well, at first, I didn't very agree with this idea ... But I'm not ab=
le to
> find an example against, so ...

Ok. Me too :-)

I'll better create a new thread for this compatibility question ...

>> My idea behind CAN_CTRLMODE_FD is to enable/disable the CAN FD mode =
in the
>> CAN FD capable controller chip.
>>
>> Depending on this CAN_CTRLMODE_FD the CAN FD functionality is enable=
d when
>> this feature is supported(!) by the driver, see priv->ctrlmode_suppo=
rted:
>=20
> Ok I agree with the usage of this new flag in "ctrmode_supported".
>=20
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/=
drivers/net/can/dev.c#n669
>>
>>
>> Depending on CAN_CTRLMODE_FD the MTU is then set to CAN_MTU or CANFD=
_MTU
>=20
> So? Do you mean that the *CAN core* will set the MTU to CAN_MTU or CA=
NFD_MTU
> according to "priv->ctrlmode_supported & CAN_CTRLMODE_FD" ?
> (Atm, the MTU is changed from user space only).

Not really. Not the CAN core but the driver does so.

What you see is, that the MTU for the VCAN is set at configuration(!) t=
ime.
But this is an exception to me, as the VCAN does not use the stuff from=
 dev.c
as it has no bitrate setting, etc.

Therefore the MTU for the VCAN is set by root - and not by any applicat=
ion.

Usually AFAIK the MTU is not set by root but from the driver side.

Here: Setting CAN_CTRLMODE_FD at configuration time leads to CAN_MTU or
CANFD_MTU set by the driver when the interface is set to 'up'.

The mode of the driver can be checked by *reading* dev->mtu then.

>=20
>> (note that the interface has to be 'down' when configuring this feat=
ure -
>> that's just the same as with configuring the bitrate).
>>
>> When CAN_CTRLMODE_FD was set but the second bitrate was *not* set be=
fore the
>> interface is requested to be set to 'up' this leads to the same erro=
r as if
>> the (single and only) bitrate is missing today.
>=20
> So, this means that the arbitration bitrate could not be the default =
data
> bitrate, doesn't it?
>=20

You think about copying the arbitration bitrate into the data bitrate w=
hen the
data bitrate was not set (with CAN_CTRLMODE_FD), right?

Yes, this could be an idea too.

The question is if this convenience functionality is confusing people o=
r not.
IMO your idea is nice.

When you set a different bitrate this will be used. If not, the arbitra=
tion
bitrate is used for data bitrate too. No objections.

Regards,
Oliver

