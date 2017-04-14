From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Fri, 14 Apr 2017 15:19:59 +0200
Message-ID: <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de> <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
 <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:32835 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdDNNUU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 09:20:20 -0400
Received: by mail-ua0-f182.google.com with SMTP id q26so47288371uaa.0
        for <linux-can@vger.kernel.org>; Fri, 14 Apr 2017 06:20:20 -0700 (PDT)
In-Reply-To: <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 14 April 2017 at 14:24, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/14/2017 10:25 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>> Hi Marc,
>>
>> Thanks for the review. My answers/comments inline.
>>
>> On 13 April 2017 at 17:56, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>> On 01/25/2017 02:02 PM, Remigiusz Ko=C5=82=C5=82=C4=85taj wrote:
>>>> SocketCAN driver for Microchip CAN BUS Analyzer
>>>> (http://www.microchip.com/development-tools/)
>>>>
>>>> Changes since v2:
>>>> - improved/simplified CAN ID conversion
>>>> - functions for transmission of skb and cmd separated
>>>> - fixed/improved netif_stop_queue handling
>>>> - style/cosmetic corrections
>>>>
>>>> Changes since v1:
>>>> - Termination handling reimplemented to fit new netlink API
>>>> (IFLA_CAN_TERMINATION)
>>>> - Bitrate handling reimplemented to fit new netlink API
>>>> (IFLA_CAN_BITRATE)
>>>> - CAN ID conversion refactored (changed from macro to inline functions=
)
>>>> - CAN DLC handling using get_can_dlc()
>>>> - Endianness handling for can_speed introduced
>>>> - Debugging removed
>>>> - Redundant error prints removed
>>>> - Style/cosmetic corrections (i.e. macro names, redefs, inits etc.)
>>>>
>>>> Signed-off-by: Remigiusz Ko=C5=82=C5=82=C4=85taj <remigiusz.kollataj@m=
obica.com>
>>>
>>> Can you pleeas add LED support, see commit:
>>>
>>>     adccadb92f05 can: flexcan: add LED trigger support
>>>
>>> as an example. More comments inline.
>>>
>>
>> In MBCA leds are controlled by device itself - CAN status leds are
>> connected directly CANTX and CANRX pins of PIC controller and CAN
>> Error led is driven by firmware.
>
> With LED support in the driver, you can use CAN RX and/or TX events to
> drive generic LEDs.
>

I am ok with adding it to the driver however I don't know if I
understand the idea. Will addition of generic LEDs expose device TX
and RX status via SYSFS?

Regards,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
