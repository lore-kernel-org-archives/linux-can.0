From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Help to set up can net interface on Dell 3200 Intel Atom
Date: Tue, 4 Feb 2020 17:08:00 +0100
Message-ID: <f2f20f9f-7810-e555-f6d0-11fc0510491c@hartkopp.net>
References: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:32228 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgBDQII (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 11:08:08 -0500
In-Reply-To: <CAP22eLHKe=0FEoS3DfRK8Oi6k2xntCvxQPVpXhau_bnuOAs71A@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Lev R. Oshvang ." <levonshe@gmail.com>
Cc: linux-can@vger.kernel.org

On 04/02/2020 14.07, Lev R. Oshvang . wrote:

> I have with DELL 3002 Edge server
> It has can and can_raw drivers loaded at boot time
> It does not have /boot/config.txt file
> 
> Unfortunately, I do not have kernel sources and kernel config file is
> not present in /proc, so I do not know which exactly chip is on b
> oard and board specs says only:
> 
> (CAN2.0 A/B/FD) 1Mbps (CAN2.0), 5Mbps (CAN-FD).

https://topics-cdn.dell.com/pdf/dell-edge-gateway-3000-series_Specifications2_de-de.pdf
says that there is a 
https://www.microchip.com/wwwproducts/en/ATSAME70N19 Cortex-M7 which 
handles the CAN FD controller.

The ATSAME70N19 is connected somehow to the Intel Atom-Prozessor E3805.

So I won't assume, that you can access the CAN controller from the Intel 
CPU.

> I tried to set it up but get the following error
> 
> 
> root@5HCF902:~# ip link add dev can0 type can
> RTNETLINK answers: Operation not supported

You can not "add" a real CAN interface with "ip link add ..." - this 
works only for virtual CANs.

Try

ip -det link show

where some CAN interface (e.g. can0) should be visible, if you have one.

Regards,
Oliver
