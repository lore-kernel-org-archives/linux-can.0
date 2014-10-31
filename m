From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 1/1] can: Add support for esd CAN PCIe/402 card
Date: Fri, 31 Oct 2014 19:43:08 +0100
Message-ID: <5453D83C.8030707@hartkopp.net>
References: <1414136470-544-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:44078 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbaJaSnL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Oct 2014 14:43:11 -0400
In-Reply-To: <1414136470-544-1-git-send-email-thomas.koerper@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VGhvbWFzIEvDtnJwZXI=?= <thomas.koerper@esd.eu>, linux-can@vger.kernel.org

Hi Thomas,

I saw one of your 402 cards on the plugfest last Tuesday :-)

On 24.10.2014 09:41, Thomas K=C3=B6rper wrote:

>   drivers/net/can/esd/esd402_pci.c | 1015 +++++++++++++++++++++++++++=
+++++++++++
>   drivers/net/can/esd/esdacc.c     |   69 +++
>   drivers/net/can/esd/esdacc.h     |  396 +++++++++++++++

Hm - looking at esd402_pci.c there are many functions which look very g=
eneric=20
and should therefore be moved to esdacc.c .

E.g.


> +static void pci402_coremsg_rxtxdone(struct acc_core *core,
> +				    const struct acc_bmmsg_rxtxdone *msg)

> +static void pci402_coremsg_txabort(struct acc_core *core,
> +				   const struct acc_bmmsg_txabort *msg)


> +static void pci402_coremsg_overrun(struct acc_core *core,
> +				   const struct acc_bmmsg_overrun *msg)


> +static void pci402_coremsg_buserr(struct acc_core *core,
> +				  const struct acc_bmmsg_buserr *msg)

=2E.. etc

esd402_pci.c should mainly contain the PCI and card specific initializa=
tion stuff.

E.g. linux/drivers/net/can/sja1000/plx_pci.c is a good example what con=
tent=20
should be hosted in esd402_pci.c

This is something for esdacc.c too:

> +
> +/* For cards with FPGA Version < PCI402_VERSION_NEWBTR */
> +static const struct can_bittiming_const pci402_bittiming_const_old =3D=
 {
> +	.name =3D "pci402_old",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 16,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 8,
> +	.sjw_max =3D 4,
> +	.brp_min =3D 1,
> +	.brp_max =3D 256,
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const pci402_bittiming_const =3D {
> +	.name =3D "pci402",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D 256,
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D 128,
> +	.sjw_max =3D 128,
> +	.brp_min =3D 1,
> +	.brp_max =3D 256,
> +	.brp_inc =3D 1,
> +};
> +

Regards,
Oliver
