From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 14:29:05 +0100
Message-ID: <1683048.Xku7xyE0R6@ws-stein>
References: <20120321091055.GA433@vandijck-laurijssen.be> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58550 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932075Ab2CUN3I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Mar 2012 09:29:08 -0400
In-Reply-To: <4F69CA74.3020607@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

Am Mittwoch, 21. M=E4rz 2012, 13:32:52 schrieb Marc Kleine-Budde:
> On 03/21/2012 01:08 PM, Kurt Van Dijck wrote:
> > On Wed, Mar 21, 2012 at 12:43:31PM +0100, Marc Kleine-Budde wrote:
> >> On 03/21/2012 12:05 PM, Kurt Van Dijck wrote:
> >>> Hi Sebastian,
> >>>=20
> >>> On the ICC, Bosch presentend CANFD[1].
> >>> I'll share my interpretation:
> >>> * CANFD is meant as a successor of CAN.
> >>>=20
> >>> * it addressess data throughput in 2 ways:
> >>>   - higher data bitrate for data using a second
> >>>  =20
> >>>     set of bittimings.
> >>>  =20
> >>>   - longer message payload (up to 64 byte).
> >>>=20
> >>> * it remains very compatible to CAN, although _NOT_
> >>>=20
> >>>   bus-compatible (ie. you put it on a seperate bus).
> >>=20
> >> This means:
> >> You cannot have a Bus using one (or more) of the CAN-FD features w=
ith
> >> non CAN-FD compatible nodes.
> >>=20
> >> From my point of view this can be translated into a new property i=
n
> >> "can.ctrlmode_supported". A device adds "CAN_CTRLMODE_CANFD" if it
> >> supports CAN FD mode. Then it's a global setting to put the device
> >> into
> >> CAN FD mode.
> >=20
> > Yep, good idea.
> >=20
> >> In the TX path the stack should refuse the new 64 byte frames at a=
ll
> >> or
> >> frames with dlc > 8 byes if the device is not in CAN FD mode.
> >=20
> > I did not yet do such think since I did not implement CANFD on devi=
ce
> > level yet. I think can_send() is a good place to put such tricks.
>=20
> Yes, for CAN_RAW, but in the driver we must extend the
> "can_dropped_invalid_skb()" function, too: drop frames with dlc >8 if
> device is not in CAN FD mode.
>=20
> Further, there are only certain dlc values allowed for CAN FD. We mus=
t
> decide if the enforce these values or simply do padding with "0" some=
where.

What I understand from the proposal is that DLCs >8 are optional. So yo=
u might=20
get hardware which still supports only 8 bytes. How can/should this be=20
handled?

Alexnder
--=20
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
