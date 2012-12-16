From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: Re: USB CAN Scripts - was Re: usb_8dev: USB Protocoll available?
Date: Sun, 16 Dec 2012 18:17:51 +0100
Message-ID: <20686.575.599365.113903@elektron.ikp.physik.tu-darmstadt.de>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
	<50CC2226.10107@universalnet.at>
	<50CDFCA8.6000409@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:48521 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751513Ab2LPRSe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 16 Dec 2012 12:18:34 -0500
In-Reply-To: <50CDFCA8.6000409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Bernd Krumboeck <krumboeck@universalnet.at>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

>>>>> "Oliver" == Oliver Hartkopp <socketcan@hartkopp.net> writes:

    Oliver> Hello Bernd, thanks for sending the [v9] version of the 8devices
    Oliver> USB2CAN.

    Oliver> I'm looking forward to get my own devices (hopefully) the next
    Oliver> days to test your driver too. When it's applied to Daves
    Oliver> net-next we have additional two month to test ;-)

    Oliver> Btw. you mentioned the need for some scripting support ...

    Oliver> To me the problem is when attaching some USB CAN adapter the
    Oliver> enumeration of these adapters is arbitrarily.

    Oliver> E.g. if i wanted to set the bitrate according to the specific
    Oliver> adapter, i need some kind of reference, let's say a unique
    Oliver> device identifier.

    Oliver> When i would be able to identify the USB CAN adapters device ID
    Oliver> i could add some udev scripts to set the bitrate - even if i
    Oliver> change the plug-in order.

Hello,

I have a lot of FTDI USB adapter related boards here. For manufacturer, I
programmed "IKDA", product is the board name and each board has a unique
number, here enumeratad beginning with 0000, 0001 etc.
To construct a unique /dev/ entry for each of them, I have a line
SUBSYSTEMS=="usb", KERNEL=="ttyUSB*", ATTRS{../manufacturer}=="IKDA", \
SYMLINK="%s{../product}_%s{../serial}_%s{bInterfaceNumber}"

in my udev rules. When plugged in, e.g. /dev/FTDITAG_0002_01 is created.
Network devices behave different, but maybe above gives you an idea.

Bye 
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
