From: "Lev R. Oshvang ." <levonshe@gmail.com>
Subject: Is /dev/ttyACM0 of ATMEL serial CAN bus ?
Date: Thu, 6 Feb 2020 09:55:46 +0200
Message-ID: <CAP22eLE2ro96aZymd3-b9HW6k2XAJeZGWBS5jRe+WU0pCJJFmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-il1-f179.google.com ([209.85.166.179]:39035 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFHz5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2020 02:55:57 -0500
Received: by mail-il1-f179.google.com with SMTP id f70so4279271ill.6
        for <linux-can@vger.kernel.org>; Wed, 05 Feb 2020 23:55:57 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

I decided to split my correspondence with Oliver to be very specific
I have Atmel Chip  on DELL 3201 board with built-in CAN port , as well
as LAN and  USB ports

I followed Dell manual and run proposed command below

> for i in /dev/ttyACM*; do udevadm info $i | grep -q 03eb_2404_USB_CAN_FD && echo "path:/dev/$(basename $i)"; done

It prints the device
 /dev/ttyACM0

What is this device?
Does it serve CAN port or USB port?
Can I use it as a serial CAN  device?

BTH, even kernel 5.3 does not have a configuration option for ATMEL CAN device.


Thanks all
Lev
