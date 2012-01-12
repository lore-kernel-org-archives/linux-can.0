From: Felix Obenhuber <felix@obenhuber.de>
Subject: loopback/recv own messages option not working as expected with
 plx_pci (Adlink Technology PCI-7841)
Date: Thu, 12 Jan 2012 14:53:36 +0100
Message-ID: <CAJsOQGNE959CjAJUCQzxqh_zyrLj-Ed=-RDYBvJq9OrtScMkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33849 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab2ALNxh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2012 08:53:37 -0500
Received: by wgbdt14 with SMTP id dt14so211959wgb.1
        for <linux-can@vger.kernel.org>; Thu, 12 Jan 2012 05:53:36 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I just encountered a problem with the loopback and receive own
messages option in combination with the plx_pci driver serving a
Adlink PCI-7841. It driver behaves a the CAN_RAW_RECV_OWN_MSGS and
LOOPBACK option would have been set (and they aren't).

One box with the Adlink card connected to another host with a approved
and well initialized CAN card. Sending single frames from each hosts
works fine. When I start the canecho test from trunk/test and send a
frame on  the bus (from the other node) its duplicated each time
canecho reads/writes the frame. You would get the same result if you
set the CAN_RAW_RECV_OWN_MSGS and LOOPBACK option on the socket in the
canecho test.
I have the same behavior with a tool written by me and tested with the
latest trunk revision - same result.
Running canecho on a vcan or peak usb device works as expected.

Has someone seen something similar with that driver? I'd just like to
ask before digging into it.

cheers,

Felix
