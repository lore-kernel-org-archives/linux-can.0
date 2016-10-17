From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: About adding a new CAN-FD driver...
Date: Mon, 17 Oct 2016 11:42:02 +0200
Message-ID: <d88756ae-0eb8-705d-e6a5-0e4532a8e28c@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:61118 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbcJQJ6p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Oct 2016 05:58:45 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

We're planning to add a new driver under drivers/net/can that adds 
support to our PCAN-PCIe FD boards family.

Before pushing any patches, I would first discuss about how and where to 
do that: all of our CAN-FD products actually embed some FPGA running the 
same µCode, internally called "uCAN core". So I first think to create a 
new sub-dir "drivers/net/can/ucan".

But several months ago (Kernel v4.0), we already have pushed a driver 
for our USB CAN-FD adapters, so the new files have been obviously added 
under "driver/net/can/usb/peak_usb". Among these new files, 
"pcan_ucan.h" describes messages exchanged between host and uCAN core, 
whatever the PC interface is (USB, PCie...). So, I can imagine that the 
new driver for PCIe should include this file too, as well as some pieces 
of code present in "peak_usb_fd.c"...

ASFAI, #include "../usb/peak_usb/pcan_ucan.h" is not the proper way to 
do this, isn't it?

So, first of all, I would propose to push some patch(es) in order to 
make things cleaner:

1/ move file "pcan_ucan.h" from "drivers/net/can/usb/peak_usb" to the 
(newly created) "drivers/net/can/ucan"

2/ add the corresponding CFLAGS def into 
"drivers/net/can/usb/peak_usb/makefile":

+CFLAGS_pcan_usb_fd.o        += -Idrivers/net/can/ucan

is this the best approach, please?

Thanks for your help.

Stéphane


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
