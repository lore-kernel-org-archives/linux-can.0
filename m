From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH RFC] can fd: Add separate bittiming infrastructure
Date: Fri, 17 Jan 2014 08:44:00 +0100
Message-ID: <52D8DF40.7050405@peak-system.com>
References: <52D6CB48.9010206@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:55104 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbaAQHoW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2014 02:44:22 -0500
In-Reply-To: <52D6CB48.9010206@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

Some questions:

Le 15/01/2014 18:54, Oliver Hartkopp a =C3=A9crit :
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/ca=
n/netlink.h
> index df944ed..bd0493a2 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -96,6 +96,7 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
>   #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>   #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
> +#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */

- What is exactly the goal of this new CAN_CTRLMODE_FD please? Did you=20
define it to allow user to enable the CANFD function into the hardware,=
=20
for example? If yes, isn't it redundant with setting the MTU to 72 byte=
s?

- Moreover, how a CANFD -able driver has to handle a CANFD frame read=20
from the CANFD controller, when its network device MTU *ISNOT* =3D=3D 7=
2 ???=20
Should it discard the CANFD frame?

>  =20
>   /*
>    * CAN device statistics
> @@ -122,6 +123,9 @@ enum {
>   	IFLA_CAN_RESTART_MS,
>   	IFLA_CAN_RESTART,
>   	IFLA_CAN_BERR_COUNTER,
> +	IFLA_CAN_DATA_BITTIMING,
> +	IFLA_CAN_DATA_BITTIMING_CONST,
> +	IFLA_CAN_DATA_CLOCK,
>   	__IFLA_CAN_MAX
>   };

- by defining another clock for the data bitrate, do you suppose that=20
some hardwares could use different clocks for both arbitration and data=
=20
bitrates?

Regards,

St=C3=A9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
