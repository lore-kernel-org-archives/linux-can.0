From: uescher <linux-can_ger.kernel.org@myvdr.de>
Subject: Re: Trying to use ESD CAN-USB with SocketCAN
Date: Thu, 28 Feb 2013 19:22:59 +0100
Message-ID: <512FA083.6060205@myvdr.de>
References: <loom.20130228T180224-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:42435 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab3B1SXF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Feb 2013 13:23:05 -0500
In-Reply-To: <loom.20130228T180224-395@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: GeoffO <geoffeolson@gmail.com>

Am 28.02.2013 18:57, schrieb GeoffO:
> Tried to attach the USB device to SocketCAN
> 	sudo slcan_attach /dev/ttyACM0
> 	ioctl TIOCSETD: Invalid argument
>
Did you test the communication with the device with raw slcan commands?
Like cat /dev/ttyACM0 and echo -ne "O" > /dev/ttyACM0 ?
