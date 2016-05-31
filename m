From: linux-can@laure.nz
Subject: Rx not working when not started from terminal
Date: Tue, 31 May 2016 10:45:31 +0200
Message-ID: <e0cee7e7-07c8-feac-7262-d62c020d07f7@laure.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gacrux.uberspace.de ([185.26.156.53]:43851 "EHLO
	gacrux.uberspace.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbcEaIwQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 May 2016 04:52:16 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

I can only send but not receive can messages with an Ixxat USB-to-CAN V2 
and a Lawicel CANUSB over can0 (via Ixxat's ixx_usb) and slcan0 (via an 
udev-triggered slcand) respectively. When I start slcand from a 
terminal, slcan0 works as expected. Do you have an idea what could be 
the problem?

More info also here: http://unix.stackexchange.com/q/285858

Cheers
Laurenz

