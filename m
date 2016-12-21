From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: CAN Termination API - was Re: Adding new CAN driver
Date: Wed, 21 Dec 2016 18:54:29 +0100
Message-ID: <CAKT-o-fJnA-ZYogbHosgihy2EgiRe7f4_m+R7P2jCfMchcxsLQ@mail.gmail.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <3113364.8FuUfmAlHQ@ws-stein> <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein> <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net> <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net> <SG2PR06MB1038E2022EEA5837EB6BD25BC3A60@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net> <18d3932b-8c74-a470-661d-7f2ee1a9f2f5@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35400 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756948AbcLURyv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2016 12:54:51 -0500
Received: by mail-ua0-f175.google.com with SMTP id 2so85002147uax.2
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2016 09:54:50 -0800 (PST)
In-Reply-To: <18d3932b-8c74-a470-661d-7f2ee1a9f2f5@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

What about keeping possibility to set termination value as u16 but
without defining supported values? This will give us opportunity to
define every value and it will be up to driver to verify it. I know
such approach will be less convenient for a user as he will not get
list of supported terminations. On the other hand these values can be
simply logged (i.e. netdev_info/warn/err).

This is pretty similar to setting up bitrate in USB devices. They are
usually predefined and there is no way to learn supported values with
ip command

Regards,
Remik

On 25 November 2016 at 15:16, Oliver Hartkopp <socketcan@hartkopp.net> wrot=
e:
> Hi all,
>
> I would like to pick up the termination API again.
>
>>>> +
>>>> +    /* array of supported discrete resistor values (Ohm) */
>>>> +    __u16 term[8];
>>
>>
>> Do you think 8 resistor values are enough?
>>
>
> see below ...
>
>>>> +};
>>>> +
>>>> +/*
>>>> + * CAN termination
>>>> + */
>>>> +struct can_termination {
>>>> +    __u16 term;
>>>> +};
>>>> +
>>>> +#define CAN_RESISTOR_INVALID    0x0000U    /* indicates no value /
>>>> unsupported */
>>>> +#define CAN_RESISTOR_DISABLED    0xFFFFU    /* indicates disabled
>>>> termination */
>>>> +
>>>>   #define CAN_CTRLMODE_LOOPBACK        0x01    /* Loopback mode */
>>>>   #define CAN_CTRLMODE_LISTENONLY        0x02    /* Listen-only mode *=
/
>>>>   #define CAN_CTRLMODE_3_SAMPLES        0x04    /* Triple sampling
>>>> mode */
>>>> @@ -127,6 +153,8 @@ enum {
>>>>       IFLA_CAN_BERR_COUNTER,
>>>>       IFLA_CAN_DATA_BITTIMING,
>>>>       IFLA_CAN_DATA_BITTIMING_CONST,
>>>> +    IFLA_CAN_TERMINATION,
>>>> +    IFLA_CAN_TERMINATION_CONST,
>>>>       __IFLA_CAN_MAX
>>>>   };
>>>>
>>>> With this interface the ip tool can get the capabilities of the
>>>> termination analogue to the BITTIMING_CONST values.
>>>> And it can set the termination with IFLA_CAN_TERMINATION.
>>>
>>>
>>> ACK.
>
>
> I tried to get into the netlink stuff and I wonder how to make this API
> really simple.
>
> By now the netlink interface in linux/drivers/net/can/dev.c looks like:
>
> /*
>  * CAN netlink interface
>  */
> static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] =3D {
>         [IFLA_CAN_STATE]        =3D { .type =3D NLA_U32 },
>         [IFLA_CAN_CTRLMODE]     =3D { .len =3D sizeof(struct can_ctrlmode=
) },
>         [IFLA_CAN_RESTART_MS]   =3D { .type =3D NLA_U32 },
>         [IFLA_CAN_RESTART]      =3D { .type =3D NLA_U32 },
>         [IFLA_CAN_BITTIMING]    =3D { .len =3D sizeof(struct can_bittimin=
g) },
>         [IFLA_CAN_BITTIMING_CONST]
>                                 =3D { .len =3D sizeof(struct
> can_bittiming_const) },
>         [IFLA_CAN_CLOCK]        =3D { .len =3D sizeof(struct can_clock) }=
,
>         [IFLA_CAN_BERR_COUNTER] =3D { .len =3D sizeof(struct can_berr_cou=
nter)
> },
>         [IFLA_CAN_DATA_BITTIMING]
>                                 =3D { .len =3D sizeof(struct can_bittimin=
g) },
>         [IFLA_CAN_DATA_BITTIMING_CONST]
>                                 =3D { .len =3D sizeof(struct
> can_bittiming_const) },
> };
>
> To add IFLA_CAN_TERMINATION we would just need
>
>         [IFLA_CAN_TERMINATION]   =3D { .type =3D NLA_U16 },
>
> to enable a defined termination value from 1 to 65534 Ohms where 65535 wo=
uld
> be CAN_RESISTOR_DISABLED. In the CAN driver this given value is checked
> against the supported list of termination values and switched on if
> supported.
>
> To provide a list of possible termination values with
> IFLA_CAN_TERMINATION_CONST we need to pass an array of u16 constants to t=
he
> userspace.
>
> In opposite to our current netlink messages this array make contain 1..n
> constant values - so defining a fixed struct of e.g. 8 entries looks like=
 a
> bad design.
>
> But how to provide the array to the netlink interface correctly?
>
> With the netlink type NLA_UNSPEC, NLA_NESTED, NLA_NESTED_COMPAT or
> NLA_BINARY??
>
> See http://lxr.linux.no/#linux+v4.8.10/include/net/netlink.h#L160
>
> The current
>
> [IFLA_CAN_DATA_BITTIMING]  =3D { .len =3D sizeof(struct can_bittiming_con=
st) },
>
> seems to use NLA_UNSPEC which means the .len value is the _minimum_ lengt=
h
> value.
>
> Would this mean we can define
>
> [IFLA_CAN_TERMINATION_CONST]   =3D { .len =3D sizeof(__u16) },
>
> as a minimum length value and provide as much termination values as the C=
AN
> interface supports?
>
> Regards,
> Oliver
>



--=20
________________________

Remigiusz Ko=C5=82=C5=82=C4=85taj

Mobica Ltd

Software Consultant, CTO Team

Skype: remigiusz.kollataj

www.mobica.com


Mobica is a provider of software engineering, testing and consultancy
services based in the UK, Poland and the USA, with a worldwide
customer base. We have a proven track record in delivering innovative
solutions to some of the world=E2=80=99s best-known companies in a range of
sectors including Automotive, Mobile, Semiconductor, Finance, TV,
Marine and Aviation.
