From: "Geoff Olson" <geoffeolson@gmail.com>
Subject: RE: Trying to use ESD CAN-USB with SocketCAN
Date: Thu, 28 Feb 2013 13:27:00 -0800
Message-ID: <002d01ce15fa$58fa0270$0aee0750$@gmail.com>
References: <loom.20130228T180224-395@post.gmane.org> <512FA083.6060205@myvdr.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:33291 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab3B1V1D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Feb 2013 16:27:03 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so1313843pbc.30
        for <linux-can@vger.kernel.org>; Thu, 28 Feb 2013 13:27:03 -0800 (PST)
In-Reply-To: <512FA083.6060205@myvdr.de>
Content-Language: en-us
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'uescher' <linux-can_ger.kernel.org@myvdr.de>, linux-can@vger.kernel.org

Thanks for the quick reply.   Good suggestion.  I will try to get it wired
up to something today I can communicate to.

Am 28.02.2013 18:57, schrieb GeoffO:
> Tried to attach the USB device to SocketCAN
> 	sudo slcan_attach /dev/ttyACM0
> 	ioctl TIOCSETD: Invalid argument
>
Did you test the communication with the device with raw slcan commands?
Like cat /dev/ttyACM0 and echo -ne "O" > /dev/ttyACM0 ?

