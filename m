From: "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Re: Help to set up can net interface on Dell 3200 Intel Atom
Date: Wed, 5 Feb 2020 14:00:15 +0200
Message-ID: <CAP22eLE4L53Qcf0tK4X0kieKxw_=jtoh_qvnUpeq1yUy_cvBsw@mail.gmail.com>
References: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
 <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:40273 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBEMA2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2020 07:00:28 -0500
Received: by mail-io1-f65.google.com with SMTP id x1so1808872iop.7
        for <linux-can@vger.kernel.org>; Wed, 05 Feb 2020 04:00:26 -0800 (PST)
In-Reply-To: <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

I tried command which is proposed in Dell manual
https://www.dell.com/support/manuals/il/en/ilbsdt1/dell-edge-gateway-3000-series/dell-edge_gateway-3002-install_manual/can-module?guid=guid-b6b7f697-0a5c-4b9c-acfe-9b436ca90bdc&lang=en-us

or i in /dev/ttyACM*; do udevadm info $i | grep -q
03eb_2404_USB_CAN_FD && echo "path:
                                    /dev/$(basename $i)"; done

It prints the device  /dev/ttyACM0 is present.

Can I use it as serial CAN  device?
I am novice to CAN devices. Now I understand that can and can_raw are
only generic drivers and I need real driver.
I wrote to Microchip support, perhaps they have driver for this box.

But still I do not understand why can driver is loaded at boot time I
used to think that only real hardware cause the driver to appear.

   16.727375] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have
ASPM control
[   16.742055] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have
ASPM control
[   16.824470] peak_usb 1-2:1.0 can0: attached to PCAN-USB channel 0
(device 255)
[   30.661705] can: controller area network core (rev 20120528 abi 9)
[   30.678155] can: raw protocol (rev 20120528)

I saw these lines in dmesg and now I thing they apperead because CAN
support was not a module but built-in in kernel configuration.
Regards,
Lev

On Tue, Feb 4, 2020 at 6:08 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> On 04/02/2020 14.07, Lev R. Oshvang . wrote:
>
> > I have with DELL 3002 Edge server
> > It has can and can_raw drivers loaded at boot time
> > It does not have /boot/config.txt file
> >
> > Unfortunately, I do not have kernel sources and kernel config file is
> > not present in /proc, so I do not know which exactly chip is on b
> > oard and board specs says only:
> >
> > (CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).
>
> https://topics-cdn.dell.com/pdf/dell-edge-gateway-3000-series_Specifications2_de-de.pdf
> says that there is a
> https://www.microchip.com/wwwproducts/en/ATSAME70N19 Cortex-M7 which
> handles the CAN FD controller.
>
> The ATSAME70N19 is connected somehow to the Intel Atom-Prozessor E3805.
>
> So I won't assume, that you can access the CAN controller from the Intel
> CPU.
>
> > I tried to set it up but get the following error
> >
> >
> > root@5HCF902:~# ip link add dev can0 type can
> > RTNETLINK answers: Operation not supported
>
> You can not "add" a real CAN interface with "ip link add ..." - this
> works only for virtual CANs.
>
> Try
>
> ip -det link show
>
> where some CAN interface (e.g. can0) should be visible, if you have one.
>
> Regards,
> Oliver
>
