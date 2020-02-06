From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: Is /dev/ttyACM0 of ATMEL serial CAN bus ?
Date: Thu, 6 Feb 2020 09:10:42 +0100
Message-ID: <CAGm1_ksLOtbu=PEOYfkzsckejLEUPyF1HRh1Xf--iaukPkwrTQ@mail.gmail.com>
References: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40030 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgBFILI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2020 03:11:08 -0500
Received: by mail-vs1-f67.google.com with SMTP id g23so3202482vsr.7
        for <linux-can@vger.kernel.org>; Thu, 06 Feb 2020 00:11:07 -0800 (PST)
In-Reply-To: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Lev R. Oshvang ." <levonshe@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Lev,

On Thu, Feb 6, 2020 at 8:56 AM Lev R. Oshvang . <levonshe@gmail.com> wrote:
>
> Hi All,
>
> I decided to split my correspondence with Oliver to be very specific
> I have Atmel Chip  on DELL 3201 board with built-in CAN port , as well
> as LAN and  USB ports
>
> I followed Dell manual and run proposed command below
>
> > for i in /dev/ttyACM*; do udevadm info $i | grep -q 03eb_2404_USB_CAN_FD && echo "path:/dev/$(basename $i)"; done
>
> It prints the device
>  /dev/ttyACM0
>
> What is this device?
> Does it serve CAN port or USB port?
> Can I use it as a serial CAN  device?
>
> BTH, even kernel 5.3 does not have a configuration option for ATMEL CAN device.

DELL's description is very poor indeed. I would try something like
this just to verify whether this device can speak slcan:

sudo slcand -o -c -s6 /dev/ttyACM0 can0

See [1] for more information.

[1] https://elinux.org/Bringing_CAN_interface_up#SLCAN_based_Interfaces

Regards,
Yegor
