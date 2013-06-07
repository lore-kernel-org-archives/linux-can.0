From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Fri, 7 Jun 2013 22:10:04 +0200
Message-ID: <zarafa.51b23e1c.16b0.5a9e858f2ffa17a7@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:49929 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754148Ab3FGUKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 7 Jun 2013 16:10:07 -0400
Received: from v14647.1blu.de (unknown [IPv6:::1])
	by v14647.1blu.de (Postfix) with ESMTP id E8C88596768A
	for <linux-can@vger.kernel.org>; Fri,  7 Jun 2013 22:10:04 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can_Mailing_List?= <linux-can@vger.kernel.org>

Hello,

I'm looking for a easy solution to make the powerful cangw tool more comfortable for endusers (dummy user).

Therefore I prefer to have a webfrontend / Web GUI to configure the cangw rules with a webbrowser which is available on each PC/smartphone/etc

Is there already a configuration tool or best a Web GUI available which can i.e.:
cangw
- Load two Vector .dbc files (one for can0 and one for can1)
- Select on one side (can0) the input CAN frame which should be routed from can0 to can via cagw
- Select on the other side (can1) the input CAN fram whcih should be routed from can1 to can0 via cangw
- Manipulate of CAN-frames with some logic operations +/-/*/div to use the modification features of cangw
- start cangw

cansend
- load a Vector .dbc file
- select a CAN-frame for transmitting
- select a CAN-signal to fillin a value to transmit
- manipulate the CAN-frames/CAN-signals content/values independent
- start cansend for CAN simulation

candump
- configure can interface to monitor/log
- start candump -l in background


Environment background:
I'm currently using the two internal CAN-Interfaces of the BeagleBone Black. They are perfectly working for me with the latest Angstrom or Debian images.

Thanks for any hint or pointing me to the right place!

Regards
Mike
