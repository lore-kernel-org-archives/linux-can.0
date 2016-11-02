From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: Adding new CAN driver
Date: Wed, 2 Nov 2016 19:03:11 +0100
Message-ID: <CAKT-o-cJ3UwD=xakh7-hF5101rS2zCa5AHfjBvdRNATJD+Weqw@mail.gmail.com>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <3113364.8FuUfmAlHQ@ws-stein> <SG2PR06MB1038F0416E850F0C09BC5CCEC3A00@SG2PR06MB1038.apcprd06.prod.outlook.com>
 <1490105.s3iJfGbYsS@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34700 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbcKBSDd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2016 14:03:33 -0400
Received: by mail-vk0-f45.google.com with SMTP id x186so19634828vkd.1
        for <linux-can@vger.kernel.org>; Wed, 02 Nov 2016 11:03:33 -0700 (PDT)
In-Reply-To: <1490105.s3iJfGbYsS@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

On 2 November 2016 at 17:08, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> On Wednesday 02 November 2016 15:49:50, Ramesh Shanmugasundaram wrote:
>> > > > > I didn't get a chance to work on adding support for termination to
>> > > > > "ip". Before investing any effort I would prefer to get
>> > > > > confirmation from Oliver of Marc that the direction is right.
>> > > > > Anyway setting up termination via sysfs works just fine. It is
>> > > > > described in readme file in repository.
>> > > >
>> > > > I'd like to see a netlink interface for this. Oliver what about
>> > > > adding it to CTRL_MODE?
>> > >
>> > > Is it about the CAN bus termination? Why the driver need to be aware of
>> >
>> > it?
>> >
>> > > If it needed for some reason shouldn't it be a device tree property of
>> > > that device/bridge node?
>> >
>> > I would consider this as a feature, which has to be enabled or disabled on
>> > demand dynamically, depending on current physical connection, especially
>> > regarding USB devices. In thise cases there is also no device tree
>> > applicable.
>>
>> OK. My question was on the lines - "Is the termination information is needed
>> on a register of the CAN device that the driver manages?" There are cases
>> where the termination is provided by the D-sub connector. The controller
>> should just see bus error when improperly terminated. I don't know about
>> USB based devices and please forgive me if this is the norm.
>
> No problem, I just wanted to point out that device tree is not suitable in
> this case.
>
>> But this is physical layer information as Oliver mentioned. The CAN
>> transceiver may even require some start-up state that may be enabled by
>> setting couple of GPIOs (as on my board). Yes, it is part of the CAN
>> interface configuration but it not part of the CAN controller driver. I
>> think we could map it to Ethernet MAC & PHY case - isn't it?
>
> The transceiver might be managed by regulators as done by e.g. flexcan. This
> is part of the hardware description, so device tree here is fine.
> But in my opinion bus termination is an end user configuration which might
> change rather often than not. It might be independent of the controller driver
> as e.g. in flexcan, but it might be part of the device as in USB hardware
> which requires some specific command to change bus termination.
> IMHO it makes no sense to split an USB interface driver into two parts using
> the same interface in the end.

I agree that termination is a physical layer setting but to be
specific in case of Microchip's CAN BUS it is neither related to CAN
controller nor transceiver. It is rather device specific - termination
settings are controlled via GPIO pin that just attaches/deattaches
resistor. You can find schematics here:
http://ww1.microchip.com/downloads/en/DeviceDoc/51848B.pdf (CAN RES
line).

I can see that the topic is not as straight forward as I thought in
the beginning. I don't even know if termination is configurable in
different CAN devices. As far as I recall Vector for example provides
physical DB9 gender changer with built-in terminator. Maybe we should
treat Microchip as "special case" and leave termination settings in
sysfs?

>
> Best regards,
> Alexander

Regards,
Remik
