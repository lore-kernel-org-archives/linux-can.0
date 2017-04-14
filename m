From: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
        <remigiusz.kollataj@mobica.com>
Subject: Re: [PATCH v3] can: mcba_usb: Add support for Microchip CAN BUS Analyzer
Date: Fri, 14 Apr 2017 19:16:06 +0200
Message-ID: <CAKT-o-f981C6K5hRhSfQqGATTV8Z81NtWZApmQZ64c4C3yQjJQ@mail.gmail.com>
References: <20170125130201.6432-1-remigiusz.kollataj@mobica.com>
 <51ef5231-673f-6a77-74ab-c0560b82ed27@pengutronix.de> <CAKT-o-d6bo075gkp_=t4LSKjw_WpH68G2wKQYNSOEP0F-sYNWA@mail.gmail.com>
 <1c65544f-e024-0243-2343-881f0790bcca@pengutronix.de> <CAKT-o-eLiciPzst1SHvhpeBg20VS2UYpPnOHcQg7dWsEEoMwZg@mail.gmail.com>
 <209acfa8-59d4-6d5a-eb4c-019d191cad7c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36693 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdDNRQ1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 13:16:27 -0400
Received: by mail-ua0-f175.google.com with SMTP id a1so49677448uaf.3
        for <linux-can@vger.kernel.org>; Fri, 14 Apr 2017 10:16:27 -0700 (PDT)
In-Reply-To: <209acfa8-59d4-6d5a-eb4c-019d191cad7c@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 14 April 2017 at 16:34, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 04/14/2017 03:19 PM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:>>> In M=
BCA leds are
> controlled by device itself - CAN status leds are
>>>> connected directly CANTX and CANRX pins of PIC controller and CAN
>>>> Error led is driven by firmware.
>>>
>>> With LED support in the driver, you can use CAN RX and/or TX events to
>>> drive generic LEDs.
>>
>> I am ok with adding it to the driver however I don't know if I
>> understand the idea. Will addition of generic LEDs expose device TX
>> and RX status via SYSFS?
>
> No. If your System has a generic LED, you can use the CAN RX/TX trigger
> to blink the LED - in a total generic way, see:
>
> https://fabiobaltieri.com/2011/09/21/linux-led-subsystem/

Got it now. Thanks!

Regards,
Remik

--=20
____________________
Remigiusz Ko=C5=82=C5=82=C4=85taj
Mobica Ltd
Technology Consultant
Skype: remigiusz.kollataj
www.mobica.com
