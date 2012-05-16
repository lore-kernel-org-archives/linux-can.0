From: bruce bushby <bruce.bushby@gmail.com>
Subject: usb to canbus
Date: Wed, 16 May 2012 14:33:50 +0100
Message-ID: <CAHvj1qaf1vbFp--OtiNRBVhZqE3fvuFa+=OEDV9dw8JHk6T0SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34294 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824Ab2EPNdv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 May 2012 09:33:51 -0400
Received: by dady13 with SMTP id y13so993831dad.19
        for <linux-can@vger.kernel.org>; Wed, 16 May 2012 06:33:50 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

Couple of question I'm hoping the list can help with. I've been
playing with a "beagleboard type" omap3 module and decided to try
attach/read a canbus. For this, I've chosen:
http://shop.greenstage.co.nz/product/usb-can-bus-interface

Has anybody had any joy with usb/canubs? Anything special needed to
recognize/bring up "can0"?

The above canbus is using: SJA1000

and lastly, is there a wireshark module for looking at canbus packets?
... would I need something special to capture the packets using
"tcpdump"

Any help much appreciated!!!

Thanks
Bruce
