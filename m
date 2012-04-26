From: cedric koch-hofer <cedric.koch-hofer@snowsat.com>
Subject: Configuration CAN sja1000_isa
Date: Thu, 26 Apr 2012 09:35:19 +0200
Message-ID: <CALptkFSikmR9wix-fvuD9ckxt1-PWSFQUYP3ekrZ7kL4WJ54iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33033 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab2DZHfT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Apr 2012 03:35:19 -0400
Received: by iadi9 with SMTP id i9so1210523iad.19
        for <linux-can@vger.kernel.org>; Thu, 26 Apr 2012 00:35:19 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello all,

I am currently trying to use the CAN output of an Aaeon embedded
system using sja1000 CAN chipset controler.
I am using an Ubuntu with a kernel 3.0 and I do not succeed to change
the state of my can device from down to up.
As you can see in the following trace, all seems to work untill I try
to activate my CAN network interface.
After that, the interface is in state "UNKNOWN" and I can not use it
with the socketcan tools: cansend, candump, cansniffer...

Any idea will be welcome,
thanks in advance,
cedric.
