From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: CAN Termination API - was Re: Adding new CAN driver
Date: Fri, 25 Nov 2016 15:16:10 +0100
Message-ID: <18d3932b-8c74-a470-661d-7f2ee1a9f2f5@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <3113364.8FuUfmAlHQ@ws-stein>
 <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
 <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
 <5f302213-c072-b6b8-aa78-4bc405dc167d@hartkopp.net>
 <20161103212427.GA1677@airbook.vandijck-laurijssen.be>
 <SG2PR06MB10381FBE7242FA602F1AC319C3A20@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <e521bee5-d0e3-d894-2c0f-be2c437a2f48@hartkopp.net>
 <SG2PR06MB1038E2022EEA5837EB6BD25BC3A60@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:33266 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbcKYOTZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Nov 2016 09:19:25 -0500
In-Reply-To: <fc26a0a8-8c15-9b1f-c699-31f83177c431@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi all,

I would like to pick up the termination API again.

>>> +
>>> +    /* array of supported discrete resistor values (Ohm) */
>>> +    __u16 term[8];
>
> Do you think 8 resistor values are enough?
>

see below ...

>>> +};
>>> +
>>> +/*
>>> + * CAN termination
>>> + */
>>> +struct can_termination {
>>> +    __u16 term;
>>> +};
>>> +
>>> +#define CAN_RESISTOR_INVALID    0x0000U    /* indicates no value /
>>> unsupported */
>>> +#define CAN_RESISTOR_DISABLED    0xFFFFU    /* indicates disabled
>>> termination */
>>> +
>>>   #define CAN_CTRLMODE_LOOPBACK        0x01    /* Loopback mode */
>>>   #define CAN_CTRLMODE_LISTENONLY        0x02    /* Listen-only mode */
>>>   #define CAN_CTRLMODE_3_SAMPLES        0x04    /* Triple sampling
>>> mode */
>>> @@ -127,6 +153,8 @@ enum {
>>>       IFLA_CAN_BERR_COUNTER,
>>>       IFLA_CAN_DATA_BITTIMING,
>>>       IFLA_CAN_DATA_BITTIMING_CONST,
>>> +    IFLA_CAN_TERMINATION,
>>> +    IFLA_CAN_TERMINATION_CONST,
>>>       __IFLA_CAN_MAX
>>>   };
>>>
>>> With this interface the ip tool can get the capabilities of the
>>> termination analogue to the BITTIMING_CONST values.
>>> And it can set the termination with IFLA_CAN_TERMINATION.
>>
>> ACK.

I tried to get into the netlink stuff and I wonder how to make this API 
really simple.

By now the netlink interface in linux/drivers/net/can/dev.c looks like:

/*
  * CAN netlink interface
  */
static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
         [IFLA_CAN_STATE]        = { .type = NLA_U32 },
         [IFLA_CAN_CTRLMODE]     = { .len = sizeof(struct can_ctrlmode) },
         [IFLA_CAN_RESTART_MS]   = { .type = NLA_U32 },
         [IFLA_CAN_RESTART]      = { .type = NLA_U32 },
         [IFLA_CAN_BITTIMING]    = { .len = sizeof(struct can_bittiming) },
         [IFLA_CAN_BITTIMING_CONST]
                                 = { .len = sizeof(struct 
can_bittiming_const) },
         [IFLA_CAN_CLOCK]        = { .len = sizeof(struct can_clock) },
         [IFLA_CAN_BERR_COUNTER] = { .len = sizeof(struct 
can_berr_counter) },
         [IFLA_CAN_DATA_BITTIMING]
                                 = { .len = sizeof(struct can_bittiming) },
         [IFLA_CAN_DATA_BITTIMING_CONST]
                                 = { .len = sizeof(struct 
can_bittiming_const) },
};

To add IFLA_CAN_TERMINATION we would just need

	[IFLA_CAN_TERMINATION]   = { .type = NLA_U16 },

to enable a defined termination value from 1 to 65534 Ohms where 65535 
would be CAN_RESISTOR_DISABLED. In the CAN driver this given value is 
checked against the supported list of termination values and switched on 
if supported.

To provide a list of possible termination values with 
IFLA_CAN_TERMINATION_CONST we need to pass an array of u16 constants to 
the userspace.

In opposite to our current netlink messages this array make contain 1..n 
constant values - so defining a fixed struct of e.g. 8 entries looks 
like a bad design.

But how to provide the array to the netlink interface correctly?

With the netlink type NLA_UNSPEC, NLA_NESTED, NLA_NESTED_COMPAT or 
NLA_BINARY??

See http://lxr.linux.no/#linux+v4.8.10/include/net/netlink.h#L160

The current

[IFLA_CAN_DATA_BITTIMING]  = { .len = sizeof(struct can_bittiming_const) },

seems to use NLA_UNSPEC which means the .len value is the _minimum_ 
length value.

Would this mean we can define

[IFLA_CAN_TERMINATION_CONST]   = { .len = sizeof(__u16) },

as a minimum length value and provide as much termination values as the 
CAN interface supports?

Regards,
Oliver

