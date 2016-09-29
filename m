From: Damien Dusha <d.dusha@gmail.com>
Subject: Recommended NAPI practices for new drivers
Date: Thu, 29 Sep 2016 15:05:21 +1000
Message-ID: <CABeNA8f3Tyhqt0AQPA-T_KeMSZE3gshfrWKGAx1dhy=Ae0fNdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:36418 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbcI2FFX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Sep 2016 01:05:23 -0400
Received: by mail-it0-f48.google.com with SMTP id u134so90755152itb.1
        for <linux-can@vger.kernel.org>; Wed, 28 Sep 2016 22:05:23 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dear All,

I am currently writing a driver for the IFI CAN IP Core [1]*.  It uses
TX and RX FIFOs rather than mailboxes.

What is the current best practice for using NAPI? The models appear to
be quite different between drivers:

Uses NAPI for RX only:
 - rcan
 - xilinx
 - mscan
-  ti_hecc

Uses NAPI for RX and ERR:
 - flexcan
 - at91
 - m_can
 - ifi_canfd

Uses NAPI for the whole IRQ:
 - pch_can
 - c_can
 - ican3

Some others do not use NAPI at all, notably the venerable SJA1000 driver.

For new drivers, what scheme is recommended?

Kind regards.
Damien.


[1] http://www.ifi-pld.de/IP/NiosII_CAN/niosii_can.html
* Not to be confused with the recently-mainlined ifi-canfd core from
the same company.
